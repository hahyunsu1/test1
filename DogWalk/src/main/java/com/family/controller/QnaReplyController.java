package com.family.controller;


import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.family.qna.model.QnaVO;
import com.family.qna.service.QnaService;

@Controller
@RequestMapping("/qnaRe")
public class QnaReplyController {
private static final Logger logger = LoggerFactory.getLogger(QnaReplyController.class);
	
	@Autowired
	QnaService qnas;
	
	
	// Qna 보러가기
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String mainView(String cp, String ps, HttpSession httpSession, Model model) {
		
		String userid = (String) httpSession.getAttribute("userid");
		logger.info("로그인 유저 아이디: " + userid);
		
		HashMap<String, Object> map = qnas.mainView(cp, ps, userid);
		
		// view까지 전달 (forward)
		model.addAttribute("cpage", map.get("cpage"));
		model.addAttribute("pageSize", map.get("pageSize"));
		model.addAttribute("qnaList", map.get("qnaList")); 		
		model.addAttribute("pageCount", map.get("pageCount"));
		model.addAttribute("totalMsgcount", map.get("totalMsgcount"));
		
		return "qna/main";
	}


	// QNA 상세 페이지 view
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String detail(int qaindex, Model model) {

		QnaVO qna = qnas.getPost(qaindex);
		logger.info("내 Qna 글 조회 완료");
		model.addAttribute("qna", qna);
		
		return "qna/detail";
	}
	
	// Qna > Qna글 수정 view
		@RequestMapping(value = "/edit", method = RequestMethod.GET)
		public String update(int qaindex, Model model) {
			
			QnaVO qna = qnas.getPost(qaindex);
			logger.info("내 QNA 글 조회 완료");
			model.addAttribute("qna", qna);
			
			return "qna/edit";	
		}
	
	
		// Qna > 글 수정 처리
		@RequestMapping(value = "/edit", method = RequestMethod.POST)
		public String update(QnaVO qna, Model model) {
						
			int result = qnas.editPost(qna);
			String msg = null;
			String url = null;
		
			if(result==1) {
				
				logger.info("Qna 글 수정 완료");
				msg = "Qna 글 수정 완료";
		        url = "/main";
				
			}else { 
				
				logger.info("Qna 글 수정 실패");
				msg = "Qna 글 수정 실패";
		        url = "javascript:history.back();";

			}
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			
			return "redirect";	
			
		}
		
		// Qna > Qna글 답글 view
		@RequestMapping(value = "/reply", method = RequestMethod.GET)
		public String replyUpdate(int qaindex, Model model) {
					
			QnaVO qna = qnas.getPost(qaindex);
			logger.info("내 QNA 글 조회 완료");
			model.addAttribute("qna", qna);
					
			return "qna/reply";	
		}
			
			
		// Qna > 글 댓글 처리
		@RequestMapping(value = "/reply", method = RequestMethod.POST)
		public String insertReply(QnaVO qna, Model model) {
														
			
						
			int result = qnas.editPost(qna);
				
			if(result==1) {
						
				logger.info("Qna 글 답글 완료");
			
				return "redirect:/qna/main";
			}else { 
						
				logger.info("Qna 글 답글 실패");
			
				return "redirect:/qna/main";
			}
			
					
		}
		

		// Qna > 글 삭제 처리
		@RequestMapping(value = "/delete", method = {RequestMethod.GET, RequestMethod.POST})
		public String delete(QnaVO post, Model model) {
			
			int result = qnas.deletePost(post);
		
			if(result==1) {
				
				logger.info("Qna 글 삭제 완료");
				
				return "redirect:/qna/main";
			}else { 
				
				logger.info("Qna 글 삭제 실패");
				
				return "javascript:history.back()";
			}
			
			
		}
	

	// Qna write보러가기
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String qaWrite() {
	
		return "qna/write";
	}

	// Qna>글쓰기 페이지 view
			@RequestMapping(value = "/write", method = RequestMethod.POST)
			public String write(QnaVO qna,HttpSession httpSession) {

				String userid = (String) httpSession.getAttribute("userid");
				logger.info("로그인 유저 아이디: " + userid);
			
				// 세션 userid post객체에 입력
				qna.setUserid(userid);


				int result = qnas.writeQna(qna);
				if (result == 1) {
					
					logger.info("Qna 글작성  성공");

					return "redirect:/qna/main";
					
				} else { // 회원가입 실패시 어찌할지 로직구현해야 함

					logger.info("Qna 글작성 실패");

					return "redirect:/qna/main";
				}
	

			}
}
