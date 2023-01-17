package com.family.qna.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.family.qna.mapper.QnaCommentMapper;
import com.family.qna.mapper.QnaMapper;
import com.family.qna.model.QnaCommentVO;
import com.family.qna.model.QnaVO;

@Service("qnaServiceImpl")
public class QnaServiceImpl implements QnaService {
	
	private static final Logger logger = LoggerFactory.getLogger(QnaService.class);

	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	@Autowired
	QnaMapper qnaMapper;

	@Autowired
	QnaCommentMapper qnaCommentMapper;

	@Override // 일반 회원가입
	public int writeQna(QnaVO qna) {
		int result = 0;

		try {

			qnaMapper = sqlsession.getMapper(QnaMapper.class);
			result = qnaMapper.writeQna(qna);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return result;
	}

	@Override
	public HashMap<String, Object> mainView(String cp, String ps, String userid) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		// List 페이지 처음 호출
		if (ps == null || ps.trim().equals("")) {
			// default 값 설정
			ps = "5"; // 5개씩
		}

		if (cp == null || cp.trim().equals("")) {
			// default 값 설정
			cp = "1"; // 1번째 페이지 보겠다
		}

		int pageSize = Integer.parseInt(ps);
		int cpage = Integer.parseInt(cp);
		int pageCount = 0;

		logger.info("pageSize" + pageSize);
		logger.info("cpage" + cpage);

		// DAO 데이터 받아오기
		List<QnaVO> qnaList = null;

		// mapper 를 통한 인터페이스 연결
		qnaMapper = sqlsession.getMapper(QnaMapper.class);

		int totalQnaCount = qnaMapper.getQnaCount(userid);

		//
		qnaList = qnaMapper.getQnaList(cpage, pageSize);

		// 페이지 크기에 맞춰 페이지 수 구하기
		if (totalQnaCount % pageSize == 0) {
			pageCount = totalQnaCount / pageSize;
		} else {
			pageCount = (totalQnaCount / pageSize) + 1;
		}

		map.put("qnaList", qnaList);
		map.put("cpage", cpage);
		map.put("pageSize", pageSize);
		map.put("pageCount", pageCount);
		map.put("totalQnaCount", totalQnaCount);

		return map;
	}

	@Override
	public QnaVO getPost(int qaindex) {
		QnaVO qna = null;

		qnaMapper = sqlsession.getMapper(QnaMapper.class);
		qna = qnaMapper.getPost(qaindex);
							
		return qna;
	}
	@Override
	public int updateQnaCount(int qaindex) {
		int result = 0;
		
		qnaMapper = sqlsession.getMapper(QnaMapper.class);
		result = qnaMapper.updateQnaCount(qaindex);
		
		return result;
	}

	@Override
	public int editPost(QnaVO post) {

		qnaMapper = sqlsession.getMapper(QnaMapper.class);
		
		
		return qnaMapper.editPost(post);
	}

	@Override
	public int editReplyPost(QnaVO post) {
		
		qnaMapper = sqlsession.getMapper(QnaMapper.class);
		
		
		return qnaMapper.editReplyPost(post);
	}

	@Override
	public int deletePost(QnaVO post) {
		
		qnaMapper = sqlsession.getMapper(QnaMapper.class);
		
		
		return qnaMapper.deletePost(post);
	}

	@Override
	public int writeCommnet(QnaCommentVO qnaComment) {
		int result = 0;

		try {

			qnaCommentMapper = sqlsession.getMapper(QnaCommentMapper.class);
			result = qnaCommentMapper.writeComment(qnaComment);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return result;
	}

	@Override
	public int editComment(QnaCommentVO qnaComment) {
		int result = 0;

		try {

			qnaCommentMapper = sqlsession.getMapper(QnaCommentMapper.class);
			result = qnaCommentMapper.editComment(qnaComment);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return result;
	}

	@Override
	public QnaCommentVO getComment(int qnaindex) {
		QnaCommentVO comment = null;

		try {

			qnaCommentMapper = sqlsession.getMapper(QnaCommentMapper.class);
			comment = qnaCommentMapper.getComment(qnaindex);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return comment;
	}

	@Override
	public List<QnaCommentVO> getCommentList(int qaindex) {
		
		List<QnaCommentVO> commentList = null;

		try {

			qnaCommentMapper = sqlsession.getMapper(QnaCommentMapper.class);
			commentList = qnaCommentMapper.getCommentList(qaindex);
			System.out.println(commentList);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return commentList;
	}

	@Override
	public int deleteComment(QnaCommentVO comment) {
		qnaCommentMapper = sqlsession.getMapper(QnaCommentMapper.class);

		return qnaCommentMapper.deleteComment(comment);
	}

	@Override
	public List<QnaVO> getQnaList() {
		System.out.println("확인용");
		List<QnaVO> qnaList = null;
		
		try {

			qnaMapper = sqlsession.getMapper(QnaMapper.class);
			qnaList = qnaMapper.getAdminQnaList();
			System.out.println(qnaList);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return qnaList;
	}

	

}
