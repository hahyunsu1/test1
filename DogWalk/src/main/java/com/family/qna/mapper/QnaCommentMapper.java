package com.family.qna.mapper;

import java.util.List;

import com.family.qna.model.QnaCommentVO;

public interface QnaCommentMapper {
	
		// Qna > 댓글 쓰기 			
		public int writeComment(QnaCommentVO QnaCommentVO);

		// Qna > 댓글 수정	
		public int editComment(QnaCommentVO QnaCommentVO);	
		
		// Qna > 댓글 리스트 조회
		public List<QnaCommentVO> getCommentList(int qaindex); 
		
		// Qna > 특정 댓글 조회
		public QnaCommentVO getComment(int qnaindex); 
		
		// Qna > 댓글 삭제
		public int deleteComment(QnaCommentVO comment);

}
