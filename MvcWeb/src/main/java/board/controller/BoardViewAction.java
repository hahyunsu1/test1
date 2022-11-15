package board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import board.model.*;
import common.controller.AbstractAction;

public class BoardViewAction extends AbstractAction {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		///boardView.do=board.controller.BoardViewAction
		//--------------------------------------------------------------
		//BoardViewAction클래스 작성
		//
		//[1] 글번호 받기
		String numStr = req.getParameter("num");
		//[2] 유효성 체크 => boardList.do로 redirect이동
		if (numStr == null||numStr.trim().isEmpty()) {
			this.setViewPage("boardList.do");
			this.setRedirect(true);
			return;
		}
		//[3] dao의 viewBoard(num) 호출==>BoardVO를 반환
		//   => req에 저장하기=> "board"라는 key값으로
		int num=Integer.parseInt(numStr.trim());
		BoardDAOMyBatis dao=new BoardDAOMyBatis();
		
		BoardVO vo=dao.viewBoard(num);
		req.setAttribute("board", vo);
		//[4] 뷰페이지 지정/이동방식 지정
//			board/boardView.jsp
		this.setViewPage("board/boardView.jsp");
		this.setRedirect(false);
		//--------------------------------------------------------------
		//boardView.jsp
		//${board}
		//--------------------------------------------------------------

		
		
		

	}

}
