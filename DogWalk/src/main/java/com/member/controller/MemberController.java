package com.member.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.family.pet.model.PetVO;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.member.mapper.MemberMapper;
import com.member.model.MemberVO;
import com.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping(value = "/member")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);


	@Autowired
	private MemberService memberservice;

	@Autowired
	private JavaMailSender mailSender;

	 @Autowired
	private BCryptPasswordEncoder pwEncoder;
	 
	 @Autowired
	 private MemberService ms;
	 @Autowired 
	 private MemberMapper mapper;
	 
	//하현수 0112 시작
	 @Autowired
	 private NaverLoginBO naverLoginBO;
	 private String apiResult = null;
	 
	 @Autowired
		private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
			this.naverLoginBO = naverLoginBO;
		}
		
	// 회원가입 화면 보러가기
	 @GetMapping("/register")
	 public String register(Model model, HttpSession session) throws IOException {
		 String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		 logger.info("네이버:" + naverAuthUrl);	
		 
		 model.addAttribute("naver_url", naverAuthUrl);
		 logger.info("naver_url:" + naverAuthUrl);
		 return "member/register";
	 
	 }
	 ////하현수 0112 끝
	// 회원가입 페이지 이동
	@GetMapping("/join")
	public void joinForm() {

		log.info("회원가입 페이지 진입");
		

	}

	// 회원가입
	@PostMapping("/join")
	public String joinPost(MemberVO member) {
		String rawPw = "";            // 인코딩 전 비밀번호
	    String encodePw = "";        // 인코딩 후 비밀번호
	    
	    if(member.getSnstype()==null) {
	    rawPw = member.getPwd();            // 비밀번호 데이터 얻음
        encodePw = pwEncoder.encode(rawPw);        // 비밀번호 인코딩
        member.setPwd(encodePw);            // 인코딩된 비밀번호 member객체에 다시 저장
	    }
        /* 회원가입 쿼리 실행 */
        memberservice.MemberJoin(member);
        
		return "redirect:/index";
	}

	// 로그인 페이지 이동
	@GetMapping("/login")
	public String loginForm(Model model, HttpSession session) {

		log.info("로그인 페이지 진입");
		//네이버
        String naver_url = naverLoginBO.getAuthorizationUrl(session);
        model.addAttribute("naver_url", naver_url);
        logger.info("네이버:" + naver_url);
        return "member/login";
		

	}

	// 아이디 중복 검사
	@PostMapping("/memberIdCheck")
	@ResponseBody
	public String memberIdCheckPOST(String userid) throws Exception {

		// log.info("memberIdCheck() 진입");

		int result = memberservice.idCheck(userid);

		// log.info("결과값 = "+result);

		if (result != 0) {
			return "fail"; // 중복된 아이디 존재
		} else {
			return "success"; // 중복된 아이디 x
		}

	}// -------------------------------------

	// 닉네임 중복 검사
	@PostMapping("/nickCheck")
	@ResponseBody
	public String nickCheckPOST(String nick) throws Exception {

		// log.info("nickCheck() 진입");

		int result = memberservice.nickCheck(nick);

		//log.info("결과값 = " + result);

		if (result != 0) {
			return "fail";
		} else {
			return "success";
		}

	}// ---------------------------------------------

	// 이메일 인증
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheckGET(String email) throws Exception {

		/* 인증번호(난수) 생성 */
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		log.info("인증번호 " + checkNum);

		/* 이메일 보내기 */
		String setFrom = "tmxhak12@naver.com";
		String toMail = email;
		String title = "회원가입 인증 이메일 입니다.";
		String content = "홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + "인증 번호는 " + checkNum + "입니다." + "<br>"
				+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

		String num = Integer.toString(checkNum);

		return num;

	}

	/* 로그인 */
	@PostMapping(value="/login", produces = "text/plain")
	@ResponseBody
	public String loginPOST(Model model, @ModelAttribute MemberVO member,HttpSession session) throws Exception {	
        String rawPw = "";
        String encodePw = "";
      
        // 제출한아이디와 일치하는 아이디있는지 
        MemberVO lvo = memberservice.memberLogin(member);
        log.info("lvo=="+lvo);
       // MemberVO memberVO= memberservice.selectById(member.getUserid());
        

        if(lvo != null) {// 일치하는 아이디 존재시
        	
        	if(lvo.getStatus()==2) {//추방회원
        		return "drop";
        	}
        	rawPw = member.getPwd();// 사용자가 제출한 비밀번호
            encodePw = lvo.getPwd();// 데이터베이스에 저장한 인코딩된 비밀번호
            
            if(true == pwEncoder.matches(rawPw, encodePw)) {// 비밀번호 일치여부 판단
                lvo.setPwd("");                    // 인코딩된 비밀번호 정보 지움
                session.setAttribute("member", lvo);     // session에 사용자의 정보 저장
                session.setAttribute("userid", member.getUserid());
        		session.setAttribute("mName", member.getName());
        		session.setAttribute("nick", member.getNick());
                return "ok";        // 메인페이지 이동
            } else {
            	 //rttr.addFlashAttribute("result", 0);
            	session.setAttribute("result", 0);
                 return "pwdError";    // 로그인 페이지로 이동
            }
            
        } else {// 일치하는 아이디가 존재하지 않을 시 (로그인 실패)
        	//rttr.addFlashAttribute("result", 0);
        	session.setAttribute("result", 0);
            return "idError";    // 로그인 페이지로 이동
        }
	}
	
	//네이버 로그인 성공시 callback호출 메소드
		@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
		public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session,
				HttpServletRequest request)
				throws IOException, ParseException {
			logger.info("여기는 callback");
			OAuth2AccessToken oauthToken;
			oauthToken = naverLoginBO.getAccessToken(session, code, state);
		//1. 로그인 사용자 정보를 읽어온다.
				apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터
				
		//2. String형식인 apiResult를 json형태로 바꿈
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(apiResult);
				JSONObject jsonObj = (JSONObject) obj;
		//3. 데이터 파싱
		//Top레벨 단계 _response 파싱
				JSONObject response_obj = (JSONObject) jsonObj.get("response");
				System.out.println("response_obj"+response_obj);
		//response의 nickname값 파싱
				String name = (String) response_obj.get("name");
				String email = (String) response_obj.get("email");
				logger.info(name);
				logger.info(email);
		//4.파싱 닉네임 세션으로 저장
				session.setAttribute("sessionId", name); // 세션 생성
				session.setAttribute("userid", email); // 세션 생성
				model.addAttribute("result", apiResult);
				logger.info(apiResult);
				logger.info(email);
				//5.회원가입한 아이디 여부 판단하여 회원가입으로 보낼지 로그인 시킬지 결정
				if(ms.normalLogin(email)==null) {
					logger.info("가입안한 아이디면 여기로");
					
					model.addAttribute("sns_id", email);  //회원가입 시 id로 활용
					model.addAttribute("snstype", "naver"); //snstype 파악을 위해
					return "member/SNSJoinForm";  //나중에 redirect화 하자
				}
				
				//lo 세션에 들어갈 권한을 설정
					List<GrantedAuthority> list = new ArrayList<GrantedAuthority>();
					list.add(new SimpleGrantedAuthority("ROLE_USER"));
		
					SecurityContext sc = SecurityContextHolder.getContext();
			//아이디, 패스워드, 권한을 설정. 아이디는 Object단위로 넣어도 무방하며
			//패스워드는 null로 하여도 값이 생성.
					sc.setAuthentication(new UsernamePasswordAuthenticationToken(email, null, list));
					session = request.getSession(true);
		
			//위에서 설정한 값을 Spring security에서 사용할 수 있도록 세션에 설정
					session.setAttribute(HttpSessionSecurityContextRepository.
			                       SPRING_SECURITY_CONTEXT_KEY, sc);
		//스프링 시큐리티 수동 로그인을 위한 작업 끝//
		
		//로그인 유저 정보 가져와서 세션객체에 저장  
		    MemberVO user = ms.normalLogin(email);
		    logger.info("유저네임: "+user.getUserid());      	   
		   
		    session = request.getSession();
		    session.setAttribute("member", user);
	    //로그인 유저 정보 가져와서 세션객체에 저장 끝//		
			
		return "login/naverSuccess";

		}
				
		
		
	 /* 메인페이지 로그아웃 */
	@GetMapping("/logout")
    public String logoutMainGET(HttpServletRequest request) throws Exception{
		  	log.info("logoutMainGET메서드 진입");
	        
	        HttpSession session = request.getSession();
	        session.invalidate();
	        
	        return "redirect:/index";   
    }
	
	/* 비동기방식 로그아웃 메서드 */
    @PostMapping("/logout")
    @ResponseBody
    public void logoutPOST(HttpServletRequest request) throws Exception{
        
        log.info("비동기 로그아웃 메서드 진입");
        
        HttpSession session = request.getSession();
        
        session.invalidate();
        
    }
 
 ///////////////////////////////////////////////////////////////////////////////////
    @GetMapping(value="/memberUpdate", produces ="application/json") 
	  public ModelAndView memberUpdate(HttpSession session) throws Exception { 
	  MemberVO member = (MemberVO)session.getAttribute("member");
	  return new ModelAndView("member/memberUpdate"); 
	  
	  }
    
 // 마이페이지 > 내 반려동물 정보(반려동물 관리의 내 반려동물 정보와 동일한 내용의 페이지)
 	@RequestMapping(value = "myPetsInfo.bit", method = RequestMethod.GET)
 	public String myPetPage(Principal principal, Model model,HttpSession httpSession) {
 		String userid = (String) httpSession.getAttribute("userid");
// 		String userid =  principal.getName();
 		log.info("로그인 유저 아이디: "+userid);
 		
 		List<PetVO> petList = ms.getPetInfo(userid);
 		
 		if(petList!=null) {
 			
 			log.info("반려동물 정보 가져오기 성공");
 			model.addAttribute(petList);
 		}else {
 			
 			log.info("반려동물 정보 가져오기 실패");
 			
 			return "redirect:/newPet.bit";
 		}
 		
 		return "member/myPetsInfo";
 	}
 	
 	

	//회원 정보 수정
	@RequestMapping("/updateMember")
	public String updateMember(MemberVO member) {
		String rawPw = ""; // 인코딩 전 비밀번호
		String encodePw = ""; // 인코딩 후 비밀번호

		rawPw = member.getPwd(); // 비밀번호 데이터 얻음
		encodePw = pwEncoder.encode(rawPw); // 비밀번호 인코딩
		member.setPwd(encodePw); // 인코딩된 비밀번호 member객체에 다시 저장
		mapper.updateMember(member);
		return "redirect:/index";
	}
	
	//회원삭제
	@GetMapping("/remove")
	// 버튼을 통해 넘어왔기에 무조건 get post는 폼에서 post를 지정해줘야만 가능하다
	public ModelAndView removeMember(HttpSession session, ModelAndView mv) {

		MemberVO member = (MemberVO) session.getAttribute("member");
		String userid = member.getUserid();

			int result = memberservice.removeMember(userid);

			if (result == 1) {
				session.invalidate();
				mv.setViewName("redirect:/index");
			}
			
		return mv;
	}

}// end---------------------------------------------------------------------------------
