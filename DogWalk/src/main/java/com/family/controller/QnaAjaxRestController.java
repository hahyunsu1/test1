package com.family.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.family.qna.mapper.QnaMapper;
import com.family.qna.model.QnaVO;

@RestController
public class QnaAjaxRestController {
	
	private static final Logger logger = LoggerFactory.getLogger(QnaAjaxRestController.class);

	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	@Autowired
	QnaMapper qnaMapper;
	
	// ajax 페이징
	@RequestMapping("QnaListAjax")
	public Map<String, Object> qnaListAjax(String cp, String ps, String userid) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		// List 페이지 처음 호출 ...
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

		
		List<QnaVO> qnalist = null;

		QnaMapper dao = sqlsession.getMapper(QnaMapper.class);
		qnalist = dao.getQnaList(cpage, pageSize);
		// request.setAttribute("emplist", emplist);

		int totalQnaCount = dao.getQnaCount();
		logger.info("totalQnaCount" + totalQnaCount);
		if (totalQnaCount % pageSize == 0) {
			pageCount = totalQnaCount / pageSize;

		} else {
			pageCount = (totalQnaCount / pageSize) + 1;
		}

		map.put("qnalist", qnalist);
		map.put("cpage", cpage);
		map.put("totalQnaCount", totalQnaCount);

		return map;

	}
}
