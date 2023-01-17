package com.family.controller;

import java.io.*;
import java.security.*;
import java.util.*;

import javax.servlet.http.*;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.servlet.mvc.support.*;

import com.family.model.AnimalBoardVO;
import com.family.pet.mapper.ScheduleMapper;
import com.family.pet.model.PetLikeVO;
import com.family.pet.model.PetVO;
import com.family.pet.model.ScheduleVO;
import com.family.pet.service.MedicalService;
import com.family.pet.service.PetService;
import com.family.service.AnimalBoardService;
import com.member.model.MemberVO;
import com.member.service.MemberService;


@Controller
@RequestMapping("/management/")
public class ManagementController {

	private static final Logger logger = LoggerFactory.getLogger(ManagementController.class);

	@Autowired
	private PetService petService;
	
	private SqlSession sqlsession;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired private MedicalService medicalService;
	 
	@Autowired
	private AnimalBoardService amb;
	// 반려동물 관리 홈 보여주기
	@RequestMapping(value = "main.bit", method = RequestMethod.GET)
	public String mainView(String cp, String ps, Principal principal, Model model, HttpSession httpSession) {
		
		

		String userid = (String) httpSession.getAttribute("userid");
		MemberVO user = (MemberVO)httpSession.getAttribute(userid);
		logger.info("로그인 유저 아이디: " + userid);
		List<PetVO> pet = petService.getPetInfo(userid);

		if (pet != null) {
			System.out.println("펫인포: " + pet);
			logger.info("반려동물 정보 가져오기 성공");
			model.addAttribute("petInfoList", pet);
		} else {
			logger.info("반려동물 정보 가져오기 실패");
			return "redirect:/main.bit";
		}
		List<PetVO> petList = petService.getPetPicture(userid);
		//System.out.println("petList===="+petList);
		List<PetLikeVO> list = petService.getPetLike(userid);
		List<PetVO> recommendPetList = petService.getRecommendPetList(petList, user);
		//System.out.println("recommendPetList===="+recommendPetList);
		  HashMap<String, Object> map = medicalService.getMrecordList(cp, ps, userid);
		  logger.info("병원이용 리스트 조회 완료");
		  
		  model.addAttribute("mrecordList", map.get("mrecordList"));
		  model.addAttribute("cpage", map.get("cpage")); model.addAttribute("pageSize",
		  map.get("pageSize")); model.addAttribute("postList", map.get("postList"));
		  model.addAttribute("pageCount", map.get("pageCount"));
		  model.addAttribute("totalPostCount", map.get("totalPostCount"));
		  model.addAttribute("petLikeList", list);
		  model.addAttribute("petList", petList); 
		  model.addAttribute("recommendPetList", recommendPetList);
		return "management/main";
	}

	// 반려동물 등록 페이지 보여주기
	@RequestMapping(value = "register.bit", method = RequestMethod.GET)
	public String registerPets() {
		return "management/register";
	}

	// 반려동물 등록 처리
	@RequestMapping(value = "register.bit", method = RequestMethod.POST)
	public String registerPets(PetVO pet, Principal principal, HttpServletRequest request,
			MultipartHttpServletRequest multiFile, RedirectAttributes redirectAttributes, Model model,
			HttpSession httpSession) {

		String userid = (String) httpSession.getAttribute("userid");
	//String userid =  principal.getName();
		logger.info("반려동물을 등록한 유저 아이디: " + userid);

	// 반려동물 등록한 유저 아이디 저장
		pet.setUserid(userid);

		// 파일 업로드
		MultipartFile file = multiFile.getFile("file");
		if (file != null && file.getSize() > 0) {
			// String filename = file.getOriginalFilename();
			String filename = UUID.randomUUID().toString();
			String path = request.getServletContext().getRealPath("/assets/images");
			System.out.println("path: " + path);

			// String fpath = path + "\\"+ filename; //윈도우
			String fpath = path + "/" + filename; // 맥이랑 윈도우 다른거??

			if (!filename.equals("")) { // 실 파일 업로드
				FileOutputStream fs;

				try {
					fs = new FileOutputStream(fpath);
					fs.write(file.getBytes());
					fs.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			pet.setPetimg(filename); // 파일명을 별도 관리 (DB insert)
		} else { // 프로필 사진 입력을 하지 않았을 경우
			pet.setPetimg("pet_profile.jpg");
		}

		// 동물 나이 저장
		pet.setAge((pet.getAge_year() * 12) + pet.getAge_month());

		int result = petService.newPet(pet);

		String msg = null;
		String url = null;

		if (result == 1) {

			logger.info("반려동물 등록 성공");

			msg = "반려동물이 등록되었습니다.";
			return "redirect:/management/main.bit?tab=myPets";

		} else {

			redirectAttributes.addFlashAttribute("failedRegisterPet", "failed");
			logger.info("반려동물 등록 실패");

			msg = "등록 실패";
			return "javascript:history.back();";

		}

//		
	}

	

	// 반려동물 정보 수정 페이지 보여주기
	@RequestMapping(value = "edit.bit", method = RequestMethod.GET)
	public String edit(int petindex, Model model) {

		PetVO pet = petService.editPetInfo(petindex);
		model.addAttribute("petInfo", pet);

		return "management/edit";
	}

	// 반려동물 정보 수정 처리
	@RequestMapping(value = "edit.bit", method = RequestMethod.POST)
	public String editOk(PetVO pet, HttpServletRequest request, MultipartHttpServletRequest multiFile, Model model) {

		// 파일 업로드
		MultipartFile file = multiFile.getFile("file");
		if (file != null && file.getSize() > 0) {
			// String filename = file.getOriginalFilename();
			String filename = UUID.randomUUID().toString();
			String path = request.getServletContext().getRealPath("/assets/images");

			// String fpath = path + "\\"+ filename; //윈도우
			String fpath = path + "/" + filename; // 맥

			if (!filename.equals("")) { // 실 파일 업로드
				FileOutputStream fs;

				try {
					fs = new FileOutputStream(fpath);
					fs.write(file.getBytes());
					fs.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			pet.setPetimg(filename); // 파일명을 별도 관리 (DB insert)
		}
		logger.info("동물 사진" + pet.getPetimg());

		// 동물 나이 저장
		pet.setAge((pet.getAge_year() * 12) + pet.getAge_month());

		int result = petService.updatePetInfo(pet);

		if (result == 1) {

			logger.info("반려동물 정보 수정 완료");

			return "redirect:/management/main.bit?tab=myPets";
		} else {

			logger.info("반려동물 정보 수정 실패");
			// msg = "반려동물 정보 수정 실패";
			// url = "javascript:history.back();";
			return "javascript:history.back();";
		}

		// model.addAttribute("msg", msg);
		// model.addAttribute("url", url);

		// return "redirect";

	}

	// 반려동물 정보 삭제
	@RequestMapping(value = "delete.bit", method = RequestMethod.GET)
	public String delete(int petindex, Model model, RedirectAttributes redirectAttributes) {

		int result = petService.deletePet(petindex);

		String msg = null;
		String url = null;

		if (result == 1) {

			logger.info("반려동물 삭제 성공");

			msg = "반려동물 정보가 삭제되었습니다.";
			url = "../";

		} else {

			redirectAttributes.addFlashAttribute("failedRegisterPet", "failed");
			logger.info("반려동물 삭제 실패");

			msg = "삭제 실패";
			url = "javascript:history.back();";

		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "redirect:/management/main.bit?tab=myPets";
	}
	@RequestMapping("getMyPetSchedule.bit")
	public List<ScheduleVO> getMyPetSchedule(String userid, String petname) {
		
		List<ScheduleVO> list = null;
		try {
			ScheduleMapper scheduleMapper = sqlsession.getMapper(ScheduleMapper.class);
			list = scheduleMapper.getMyPetSchedule(userid, petname);
			
		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
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
			PetVO pet = petService.getPet(Integer.parseInt(petindex));		
			System.out.println("페의정보"+pet);
			//포스트와 관련된 pet정보를 추출하기 위한 작업//
			List<PetVO> pArr = new ArrayList<PetVO>();
			Set<String> pindexSet = new HashSet(); //petindex 중복 제거를 위한 임시 Set

			
			for(String pindex: pindexSet) {
				pArr.add(petService.editPetInfo(Integer.parseInt(pindex))); 
			}
			PetLikeVO petLike = null;
			//유저가 팔로우한 반려동물인지 확인
			if(user !=null) {
				petLike = petService.isFollowPet(petindex, userid);		 
			}
			model.addAttribute("petInfoList2",pet);			
			model.addAttribute("pArr", pArr);
			model.addAttribute("petLike", petLike);
			
			return "management/petPage";
		}
		
		// 반려동물 팔로우(petlike) 처리
		@ResponseBody
		@PostMapping(value = "followPet.bit",produces="application/json" )
		public int followPet(PetLikeVO petLike, HttpSession httpSession) {
			
			petLike.setUserid((String)httpSession.getAttribute("userid"));
			System.out.println("petLike2"+petLike);
			return petService.followPet(petLike);
		}
		
		// 반려동물 언팔로우(petlike) 처리
		@ResponseBody
		@PostMapping(value = "unFollowPet.bit", produces="application/json")
		public int unFollowPet(PetLikeVO petLike, HttpSession httpSession) {
			
			petLike.setUserid((String)httpSession.getAttribute("userid"));		
			System.out.println("petLike3"+petLike);
			return petService.unFollowPet(petLike);
		}

}
