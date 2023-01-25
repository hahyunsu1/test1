package com.member.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.family.model.AnimalBoardVO;
import com.family.service.AnimalBoardService;
import com.member.model.MemberVO;
import com.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin")
@Log4j
public class AdminController {
	
	@Autowired
	private AnimalBoardService boardservice;
	
	@Autowired
	private MemberService memberservice;
	
 
	 /* 관리자 메인 페이지 이동 */
	@GetMapping("/main")
    public void main(Model model) {
    	log.info("메인 페이지로 이동");
    	model.addAttribute("boardList",boardservice.getAdminList());
    	model.addAttribute("userinfo",memberservice.adminUserList());
    }
	
	@GetMapping("/boardList")
	public void mainList(Model model) {
		log.info("어드민메인 게시판 리스트");
		model.addAttribute("allBoard",boardservice.getAllboard());
	}
	
	//어드민 회원 관리
	@GetMapping("/userList")
	public void user_list(Model model) {
		//회원 기본정보 페이징(x)
		log.info("/admin/userList요청");
		List<MemberVO> list = memberservice.adminUserList2();
		model.addAttribute("userinfo",list);
	}
	
	@ResponseBody
	@PostMapping("/getuserInfo")
	public MemberVO getuserInfo(String userid) {
		log.info("유저 인포 아작스"+userid);
		MemberVO member=memberservice.selectById(userid);
		log.info("member=="+member);
		return member;
	}
	
	@ResponseBody
	@PostMapping("/getUserBoardList")
	public List<AnimalBoardVO> getUserBoardList(String userid) {
		log.info("open! user boardList ajax!");
		log.info("조회할 회원 아이디 : " + userid);
		List<AnimalBoardVO> list = boardservice.getUserBoardList(userid);
		
		return list;
	}
	
	@ResponseBody
	@PostMapping("/successId")
	public void successId(String userid) {
		log.info(userid);
		log.info("open! user sign success Id ajax!");
		memberservice.successId(userid);
	}
	
	@ResponseBody
	@PostMapping("/failId")
	public void failId(String id) {
		log.info(id);
		log.info("open! user sign failId Id ajax!");
		memberservice.failed(id);
	}
	
	@ResponseBody
	@PostMapping("/deleteBoard")
	public void deleteBoard(int idx) {
		log.info("삭제할 게시물 : " + idx);
		boardservice.deleteBoard(idx);
	}
	
	@GetMapping("dataTotal")
	public void admin_dataTotal(Model model) {
		model.addAttribute("allTotal", boardservice.getAllTotal());
	}
	
	@ResponseBody
	@PostMapping("/findDate")
	public List<HashMap<String, Object>> admin_findDate(String date1 , String date2) {
		log.info(date1);
		log.info(date2);
		List<HashMap<String, Object>> list = boardservice.admin_findDate(date1, date2);
		System.out.println(boardservice.admin_findDate(date1, date2));
		return list;
	}
	
	@ResponseBody
	@PostMapping("/dropId")
	public void dropID(String userid) {
		memberservice.dropUser(userid);
	}
}

