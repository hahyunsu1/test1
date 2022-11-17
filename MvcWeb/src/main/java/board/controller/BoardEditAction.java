package board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.model.*;
import common.controller.AbstractAction;
import user.model.UserVO;

public class BoardEditAction extends AbstractAction {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HttpSession session=req.getSession();
		UserVO user=(UserVO)session.getAttribute("loginUser");
		if(user==null) {
			req.setAttribute("msg", "로그인해야 글쓰기가 가능합니다");
			req.setAttribute("loc", "javascript:history.back()");
			
			this.setViewPage("message.jsp");
			this.setRedirect(false);
			return;
		}		
		
		//0.post방식일떈 한글처리
		//req.setCharacterEncoding("UTF-8"); 
		//1. num,userid,subject,content,filename 값 받기
		ServletContext application=req.getServletContext();
		String upDir=application.getRealPath("/Upload");
		System.out.println("upDir="+upDir);
		
		MultipartRequest mr=null;
		try {
			mr=new MultipartRequest(req, upDir,100*1024*1024,"utf-8",new DefaultFileRenamePolicy());
			System.out.println("파일 업로드 성공!!");
		} catch (IOException e) {
			e.printStackTrace();
			
		}
		String numStr = mr.getParameter("num");
		String userid = user.getUserid();		
		String subject = mr.getParameter("subject");
		String content = mr.getParameter("content");
		String filename = mr.getFilesystemName("filename");
		File file=mr.getFile("filename");
		long filesize=0;
		if(file!=null) {//첨부한 파일이 있다면
			filesize=file.length();
			//예전에 첨부한 파일명 얻기
			String old_file=mr.getParameter("old_file");
			if(old_file!=null&& !old_file.trim().isEmpty()) {
				File delFile=new File(upDir,old_file);
				if(delFile!=null) {
					boolean b=delFile.delete();
					System.out.println("파일 삭제 여부: "+b);
				}
			}
		}
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
