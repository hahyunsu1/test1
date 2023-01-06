package com.member.controller;

import java.security.Principal;
import java.util.List;
import java.util.Random;
import java.security.*;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.family.pet.model.PetVO;
import com.family.pet.service.MedicalService;
import com.member.mapper.MemberMapper;
import com.member.model.MemberVO;
import com.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping(value = "/member")
public class MemberController {

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

	    rawPw = member.getPwd();            // 비밀번호 데이터 얻음
        encodePw = pwEncoder.encode(rawPw);        // 비밀번호 인코딩
        member.setPwd(encodePw);            // 인코딩된 비밀번호 member객체에 다시 저장

        /* 회원가입 쿼리 실행 */
        memberservice.MemberJoin(member);

		return "redirect:/index";
	}

	// 로그인 페이지 이동
	@GetMapping("/login")
	public void loginForm() {

		log.info("로그인 페이지 진입");

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

		log.info("결과값 = " + result);

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
	@PostMapping("/login")
	public String loginPOST(HttpServletRequest request, MemberVO member, RedirectAttributes rttr,@RequestParam("userid") String userid) throws Exception {
		HttpSession session = request.getSession();
        String rawPw = "";
        String encodePw = "";
        // 제출한아이디와 일치하는 아이디있는지 
        MemberVO lvo = memberservice.memberLogin(member);
        MemberVO memberVO= memberservice.selectById(userid);
        if(lvo != null) {// 일치하는 아이디 존재시
        	rawPw = member.getPwd();// 사용자가 제출한 비밀번호
            encodePw = lvo.getPwd();// 데이터베이스에 저장한 인코딩된 비밀번호
            
            if(true == pwEncoder.matches(rawPw, encodePw)) {// 비밀번호 일치여부 판단
                lvo.setPwd("");                    // 인코딩된 비밀번호 정보 지움
                session.setAttribute("member", lvo);     // session에 사용자의 정보 저장
                session.setAttribute("userid", userid);
        		session.setAttribute("mName", member.getName());
        		session.setAttribute("nick", member.getNick());
                return "redirect:/index";        // 메인페이지 이동
            } else {
            	 rttr.addFlashAttribute("result", 0);            
                 return "redirect:/member/login";    // 로그인 페이지로 이동
            }
            
        } else {// 일치하는 아이디가 존재하지 않을 시 (로그인 실패)
        	rttr.addFlashAttribute("result", 0);            
            return "redirect:/web/member/login";    // 로그인 페이지로 이동
        }

		
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
	/*
	 * @GetMapping("/")
	 */
    @GetMapping(value="/mypage", produces ="application/json")
	public ModelAndView updateMember(HttpSession session) throws Exception {
		MemberVO member = (MemberVO)session.getAttribute("member");
		/* .member. 회원정보 가져와 */
		/* memberservice. 멤버정보를 가져오는걸*/
		return new ModelAndView("member/mypage");
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
 	
 	// 반려동물의 마이페이지 view
 	@RequestMapping(value = "petPage.bit", method = RequestMethod.GET)
 	public String petPage(String cp, String ps, HttpServletRequest request, Model model) {
 		String userid = null;
 		//request객체로 세션 접근해서 userid 빼기
 		MemberVO user = (MemberVO)request.getSession().getAttribute("member");
 		if(user !=null) {
 			userid = user.getUserid();
 		}
 		String petindex = request.getParameter("petindex");
 		
 		//반려동물 정보 가져오기
 		PetVO pet = ms.getPet(Integer.parseInt(petindex));		
 		model.addAttribute("pet",pet);
 		
 		
 		return "member/petPage";
 	}	

}// end---------------------------------------------------------------------------------
