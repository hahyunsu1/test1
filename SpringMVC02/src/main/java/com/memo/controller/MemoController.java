package com.memo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.memo.model.MemoDAO;
import com.memo.model.MemoVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MemoController {
	//by type으로 주입한다.MemoDAO타입의 객체가 있으면 주입한다.
	@Autowired
	private MemoDAO memoDao;
	
	@RequestMapping(value="/memo",method=RequestMethod.GET)
	public String memoForm() {
		return "memo/input";
		//"/WEB-INF/views/memo/input.jsp"
		
	}
	@RequestMapping(value="/memo",method=RequestMethod.POST)
	public String memoInsert(Model model,@ModelAttribute("memo") MemoVO memo) {
		//System.out.println("memo===="+memo);
		
		log.info("memo>>>>"+memo);
		int n=memoDao.insertMemo(memo);
		String str=(n>0)?"등록 성공":"등록 실패";
		String loc=(n>0)?"memoList":"javascript:history.back()";
		model.addAttribute("message",str);
		model.addAttribute("loc",loc);
		return "msg";
		//"/WEB-INF/views/msg.jsp"
	}
	@RequestMapping("/memoList")
	public String memoList(Model model) {
		int totalCount=memoDao.getTotalCount();
		List<MemoVO> arr=memoDao.listMemo();
		
		model.addAttribute("memoArr",arr);
		model.addAttribute("totalCount",totalCount);
		
		return "memo/list";
		//"/WEB-INF/views/memo/list.jsp"
	}
//	#메모 삭제처리 완성하세요
//
//
//	#메모 수정폼 가져와 보여주기
//	memoEdit?idx=33
//	memoDao통해서 해당 글 번호의 내용을 가져와서
//	model에 저장한 뒤
//	==> memo/edit

	@RequestMapping("/memoDel")
	public String memoDelete(Model model, @RequestParam(defaultValue = "0") int idx) {
		log.info("idx====="+idx);//idx파라미터값이 넘어오지 않으면 디폴트값을 0으로 준다
		if(idx==0) {
			return "redirect:memoList";//redirect방식으로 이동
		}
		int n=memoDao.deleteMemo(idx);
		String str=(n>0)?"삭제 성공":"삭제 실패";
		model.addAttribute("message",str);
		model.addAttribute("loc","memoList");
		return "msg";
	}
	@RequestMapping(value="/memoEdit",method=RequestMethod.GET)
	public String MemoEditForm(Model model,@RequestParam(defaultValue = "0") int idx) {
		if(idx==0) {
			return "redirect:memoList";//redirect방식으로 이동
		}
		MemoVO memo=memoDao.getMemo(idx);
		model.addAttribute("memo",memo);		
		return "memo/edit"; 
	}
//	#수정된 메모 수정처리
//	memoEdit==>POST방식일 때
//	수정한 값을 MemoVO로 받기
//	memoDao의 updateMemo()호출
//	그결과 model 저장
	@RequestMapping("/memoEdit")
	public String MemoEdit(Model model,@ModelAttribute("memo") MemoVO memo) {
		log.info("memo>>>>"+memo);
		int n=memoDao.updateMemo(memo);
		String str=(n>0)?"수정 성공":"수정 실패";
		String loc=(n>0)?"memoList":"javascript:history.back()";
		model.addAttribute("message",str);
		model.addAttribute("loc",loc);
		return "msg";
	}
}
