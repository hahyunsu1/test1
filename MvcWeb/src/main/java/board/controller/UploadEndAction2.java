package board.controller;

import java.io.File;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
//cos.jar를 "프로젝트/WEB-INF/lib"아래 두었음
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractAction;

public class UploadEndAction2 extends AbstractAction {
	
	String upDir="C:/myjava";
	
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		//컨텐트타입, 파일크기
		MultipartRequest mr=new MultipartRequest(req,upDir,100*1024*1024,"utf-8",new DefaultFileRenamePolicy());
		System.out.println("파일 업로드 성공: "+upDir+"에서 확인하세요");
		//DefaultFileRenamePolicy객체를 매개변수로 전달하면 upload파일 명이 동일한 것이 있을 경우 
		//"파일명+인덱스번호" 식으로 업로드를 해서 덮어쓰지 못하게 함

		String name=mr.getParameter("name");
		System.out.println("name: "+name);
		//첨부파일명 ==>mr.getFilesystemName()메서드 이용
		String fname=mr.getFilesystemName("fname");
		System.out.println("fname: "+fname);
		
		//첨부파일크기
		File file=mr.getFile("fname");
		long fsize=0;
		if(file!=null) {
			fsize=file.length();//파일크기
		}
		req.setAttribute("content", "파일 업로드 성공: "+upDir+"에서 확인하세요");
		req.setAttribute("name", name);
		req.setAttribute("fname", fname);
		req.setAttribute("fsize", fsize);
		this.setViewPage("board/uploadResult.jsp");
		this.setRedirect(false);
	}

}
