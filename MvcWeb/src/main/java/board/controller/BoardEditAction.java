package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import common.controller.AbstractAction;

public class BoardEditAction extends AbstractAction {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//0.post방식일떈 한글처리
		req.setCharacterEncoding("UTF-8"); 
		//1. num,userid,subject,content,filename,
		String numStr = req.getParameter("num");
		String userid = "hong";		
		String subject = req.getParameter("subject");
		String content = req.getParameter("content");
		String filename = null;
		long filesize=0;
		//2.유효성 체크(num,subject,userid)
		if(numStr==null||userid==null||subject==null||numStr.trim().isEmpty()||userid.trim().isEmpty()||subject.trim().isEmpty()) {
			this.setViewPage("boardWrite.do");
			this.setRedirect(true);
			return;
		}
		//3.1번에서 받은 값 BoardVO에 담아주기
		int num=Integer.parseInt(numStr.trim());
		BoardVO vo = new BoardVO(num,userid,subject,content,null,filename,filesize);
		
		//4. dao의 updateBoard(vo)
		BoardDAOMyBatis dao = new BoardDAOMyBatis();
		int n = dao.updateBoard(vo);
		String str = (n > 0) ? "글수정 성공" : "글수정 실패";
		String loc =  "boardList.do";
		//5.req에 메시지,이동경로 저장
		req.setAttribute("msg", str);
		req.setAttribute("loc", "boardList.do");
		this.setViewPage("message.jsp");
		this.setRedirect(false);

	}

}
