package com.family.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.family.qna.model.QnaCommentVO;
import com.family.qna.model.QnaVO;
import com.family.qna.service.QnaService;

@Controller
@RequestMapping("/qna")
public class QnaController {
	
private static final Logger logger = LoggerFactory.getLogger(QnaController.class);
	
	@Autowired
	QnaService qnas;
	
	
	// Qna 보러가기
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String mainView(String cp, String ps, HttpSession httpSession, Model model) {
		
		String userid = (String) httpSession.getAttribute("userid");
		//logger.info("로그인 유저 아이디: " + userid);
		
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
		//logger.info("내 Qna 글 조회 완료");
		
		int result = 0;
		
		//자신의 글이 아니면 조회수 증가
		if(!qna.getUserid().equals(qaindex)) {
			result = qnas.updateQnaCount(qaindex);  
		}
		
		if (result == 1) {
			//logger.info(qaindex+"번 블로그 글 조회수 업데이트 성공");
		}
		
		
		model.addAttribute("qna", qna);
		
		return "qna/detail";
	}
	
	// Qna > Qna글 수정 view
		@RequestMapping(value = "/edit", method = RequestMethod.GET)
		public String update(int qaindex, Model model) {
			
			QnaVO qna = qnas.getPost(qaindex);
			//logger.info("내 QNA 글 조회 완료");
			model.addAttribute("qna", qna);
			
			return "qna/edit";	
		}
		// Qna > Qna글 답글작성 view
	
		@RequestMapping(value = "/reply", method = RequestMethod.GET)
		public String replyUpdate(int qaindex, Model model) {
			
			QnaVO qna = qnas.getPost(qaindex);
			//logger.info("답글 작성 뷰 완료");
			model.addAttribute("qna", qna);
			
			return "qna/reply";	
		}
		
		
		// Qna > 글 수정 처리
		@RequestMapping(value = "/edit", method = RequestMethod.POST)
		public String update(QnaVO qna, Model model) {
												
			String msg = "";
			String url = "";
				
			int result = qnas.editPost(qna);
			//System.out.println(result);
			if(result==1) {
				
				//logger.info("Qna 글 수정 완료");
				msg = "Qna 글 수정 완료";
		        url = "main";	
			}else { 
				
				//logger.info("Qna 글 수정 실패");
				msg = "Qna 글 수정 실패";
		        url = "javascript:history.back();";
			}
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			
			return "redirect:main";	
			
		}
		

		// Qna > 관리자 답글 처리
		
		@RequestMapping(value = "/reply", method = RequestMethod.POST)
		public String replyUpdate(QnaVO qna, Model model) {
												
			String msg = "";
			String url = "";
				
		int result = qnas.editReplyPost(qna);
		
			if(result==1) {
				
				//logger.info("관리자 답글 작성 완료");
				msg = "관리자 답글 작성 완료";
		        url = "main";
				
			}else { 
				
				//logger.info("관리자 답글 작성 실패");
				msg = "관리자 답글 작성 실패";
		        url = "javascript:history.back();";

			}
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			
			return "redirect:main";	
			
		}	
		@RequestMapping(value = "/delete", method = {RequestMethod.GET, RequestMethod.POST})
		public String delete(QnaVO post, Model model) {
									
			int result = qnas.deletePost(post);
		
			if(result==1) {
				
				//logger.info("Qna 글 삭제 완료");
				return "redirect:/qna/main";
			}else { 
				
				//logger.info("Qna 글 삭제 실패");
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
			public String write(QnaVO qna, HttpSession httpSession) {

				String userid = (String) httpSession.getAttribute("userid");
				
				//logger.info("로그인 유저 아이디: " + userid);
			
				// 세션 userid post객체에 입력
				qna.setUserid(userid);


				int result = qnas.writeQna(qna);
				if (result == 1) {
					
					//logger.info("Qna 글작성  성공");

					return "redirect:/qna/main";
					
				} else { // 회원가입 실패시 어찌할지 로직구현해야 함

					//logger.info("Qna 글작성 실패");

					return "redirect:/qna/main";
				}
	

			}
			
			
		// Qna 댓글 입력 Ajax 처리  
		@ResponseBody
		@RequestMapping(value = "/writeComment", method = { RequestMethod.POST })
		public int writeComment(QnaCommentVO qnaComment, HttpServletRequest request, Model model) throws IOException {
			
			//비밀글 체크 여부 
			if(qnaComment.getScstate() == null) {

				qnaComment.setScstate("N");
			}
			
			int result = qnas.writeCommnet(qnaComment);
			
			if(result==1) {
				//logger.info("Qna"+qnaComment.getQaindex()+"번글 댓글 입력 처리 완료");
			}else {
				//logger.info("Qna"+qnaComment.getQaindex()+"번글 댓글 입력 처리 실패");
			}
			
			return result;
		}
		
		// Qna 댓글 수정 Ajax 처리  
		@ResponseBody
		@RequestMapping(value = "/editComment", method = { RequestMethod.POST })
		public int editComment(QnaCommentVO qnaComment, HttpServletRequest request, Model model) throws IOException {
			
			//비밀글 체크 여부 
			if(qnaComment.getScstate() == null) {

				qnaComment.setScstate("N");
			}
			
			int result = qnas.editComment(qnaComment);
			
			if(result==1) {
				//logger.info("Qna"+qnaComment.getQaindex()+"번글 댓글 수정 처리 완료");
			}else {
				//logger.info("Qna"+qnaComment.getQaindex()+"번글 댓글 수정 처리 실패");
			}
			
			return result;
		}
		
		// Qna 댓글 조회 Ajax  
		@ResponseBody
		@GetMapping(value = "/getCommentList", produces="application/json;  charset=UTF-8" )
		public List<QnaCommentVO> getCommentList(HttpServletRequest request, Model model) throws IOException {
			
			int qaindex = Integer.parseInt(request.getParameter("qaindex"));
			////System.out.println("qaindex===="+qaindex);
			List<QnaCommentVO> commentList = qnas.getCommentList(qaindex);
			////System.out.println("commentList===="+commentList);
			if(commentList!=null) {
				//logger.info("Qna"+qaindex+"번글 댓글내역 조회 완료");
			}else {
				//logger.info("Qna"+qaindex+"번글 댓글입력 조회 실패");
			}
			
			return commentList;
		}
		
			
		// QNA > 댓글 삭제 처리
		@RequestMapping(value = "/deleteComment", method = {RequestMethod.GET, RequestMethod.POST})
		public String deleteComment(QnaCommentVO comment, Model model) {

			int result = qnas.deleteComment(comment);
			int qaindex = comment.getQaindex();
			if(result==1) {

				//logger.info("QNA 댓글 삭제 완료");
				return "redirect:/qna/detail?qaindex="+qaindex+"";
				
			}else { 

				//logger.info("QNA 댓글 삭제 실패");
		        return "javascript:history.back()";
			}

	
		}
}
