package board.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAOMyBatis;
import board.model.BoardVO;
import common.controller.AbstractAction;
import user.model.UserVO;

public class BoardDeleteAction extends AbstractAction {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HttpSession session=req.getSession();
		UserVO user=(UserVO)session.getAttribute("loginUser");
		if(user==null) {
			req.setAttribute("msg", "로그인해야 글삭제가 가능합니다");
			req.setAttribute("loc", "javascript:history.back()");
			
			this.setViewPage("message.jsp");
			this.setRedirect(false);
			return;
		}
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
		
		BoardVO vo=dao.viewBoard(Integer.parseInt(numStr.trim()));
		
		if(!vo.getUserid().equals(user.getUserid())) {
			req.setAttribute("msg", "자신이 쓴글만 삭제 가능합니다");
			req.setAttribute("loc", "javascript:history.back()");
			
			this.setViewPage("message.jsp");
			this.setRedirect(false);
			return;
		}
		
		if(vo.getFilename()!=null) {
			//첨부파일이 있다면 서버 Upload디렉토리에서 해당 파일을 먼저 삭제하자
			String upDir=req.getServletContext().getRealPath("/Upload");
			File delFile=new File(upDir,vo.getFilename());
			if(delFile!=null) {
				delFile.delete();
			}
		}
		
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
