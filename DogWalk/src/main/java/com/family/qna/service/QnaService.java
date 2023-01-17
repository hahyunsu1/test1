package com.family.qna.service;

import java.util.HashMap;
import java.util.List;

import com.family.qna.model.QnaCommentVO;
import com.family.qna.model.QnaVO;

public interface QnaService {
	
	
		// 일반 회원가입
		public int writeQna(QnaVO qna);



		public HashMap<String, Object> mainView(String cp, String ps, String userid);

	
		//글 상세보기 
		public QnaVO getPost(int qaindex);
		//글 조회수 증가
		public int updateQnaCount(int qaindex);
		
		//글 상세보기  서비스 다시
		public int editPost(QnaVO post);
		
		
		//글 상세보기  서비스 다시
		public int editReplyPost(QnaVO post);
		
		//글 삭제
		public int deletePost(QnaVO post);
		
		
		//QNA > 댓글 쓰기
		public int writeCommnet(QnaCommentVO qnaComment);


		//QNA > 댓글 수정
		public int editComment(QnaCommentVO qnaComment);	
		//QNA > 댓글 조회
		public QnaCommentVO getComment(int qnaindex);
		
		//QNA > 댓글 리스트 조회
		public List<QnaCommentVO> getCommentList(int qaindex);
		
		
		//QNA > 댓글 삭제
		public int deleteComment(QnaCommentVO comment);
	
		//어드민 > Qna 리스트 조회
		public List<QnaVO> getQnaList();
}
