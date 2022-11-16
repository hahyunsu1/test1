package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.BoardDAOMyBatis;
import board.model.BoardVO;
import common.controller.AbstractAction;

public class BoardDeleteAction extends AbstractAction {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
//		[1] 삭제할 글 번호 받기
		String numStr = req.getParameter("num");
//		[2] 유효성 체크 => boardList.do  redirect이동
		if (numStr == null||numStr.trim().isEmpty()) {
			this.setViewPage("boardList.do");
			this.setRedirect(true);
			return;
		}
//		[3] dao의 deleteBoard(num)
		
		BoardDAOMyBatis dao=new BoardDAOMyBatis();		
		int n = dao.deleteBoard(Integer.parseInt(numStr.trim()));
//		[4] 실행결과 메시지 및 이동 경로 지정
//		   => req에 저장. msg, loc
		
		String str = (n > 0) ? "삭제 성공" : "실패";
		String loc = (n > 0) ? "boardList.do" : "javascript:history.back()";
		req.setAttribute("msg", str);
		req.setAttribute("loc", "boardList.do");

		
//		[5] 뷰페이지 지정/이동방식 지정
//			=> message.jsp
		this.setViewPage("message.jsp");
		this.setRedirect(false);


	}

}