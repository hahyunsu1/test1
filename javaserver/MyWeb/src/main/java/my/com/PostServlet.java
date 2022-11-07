package my.com;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/PostTest")
public class PostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text.html; charset=UTF-8");
		PrintWriter out=res.getWriter();//html태그를 출력할 때
		//이미지나 동영상파일
		//ServletOutputStream sos=res.getOutputStream();
		
		String name=req.getParameter("name");
		String user=req.getParameter("userid");
		out.println("<h1>POST방식 Test</h1>");
		out.println("<h2>POST방식 -doPost()메서드를 오버라이드 해야 한다</h2>");
		out.println("<hr color='red'>");
		out.println("<h3>이 름 :"+name+"</h3>");
		out.println("<h3>아이디 :"+user+"</h3>");
		
		
	}

}
