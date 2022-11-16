package board.controller;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
//cos.jar를 "프로젝트/WEB-INF/lib"아래 두었음

import common.controller.AbstractAction;

public class UploadEndAction2 extends AbstractAction {
	
	String upDir="C:/myjava";
	
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		req.setCharacterEncoding("UTF-8");
		//컨텐트타입, 파일크기
		MultipartRequest mr=new MultipartRequest(req,upDir);
		System.out.println("파일 업로드 성공: "+upDir+"에서 확인하세요");
		req.setAttribute("content", "파일 업로드 성공: "+upDir+"에서 확인하세요");
		this.setViewPage("board/uploadResult.jsp");
		this.setRedirect(false);
	}

}
