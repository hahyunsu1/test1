package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;

import common.controller.AbstractAction;
import java.util.*;
public class BoardListAction extends AbstractAction {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		BoardDAOMyBatis dao=new BoardDAOMyBatis();
		int count=dao.getTotalCount();
		 
		List<BoardVO> boardArr=dao.listBoard();
		req.setAttribute("totalCount", count);
		req.setAttribute("boardArr", boardArr);
		
		this.setViewPage("board/boardList.jsp");
		this.setRedirect(false);
	}

}
