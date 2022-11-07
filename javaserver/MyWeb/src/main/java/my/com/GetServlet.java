package my.com;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//어노테이션으로 servlet-mapping url-pattern을 등록한다. 이때 @WebServlet("/GetTest") 안의 url pattern은 unique해야 한다.
@WebServlet("/GetTest")
public class GetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out=res.getWriter();
		out.println("<h1>GetServlet</h1>");
		out.println("<h2>GET방식의 요청을 처리할 때는 doGet()메서드를 오버라이드 합니다.</h2>");
		out.close();
	}

}
