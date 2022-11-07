package my.com;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
/*
 * [1] HttpServlet을 상속받아 구현 : http프로토콜에 특화된 서블릿
 * [2] doGet() 또는 doPost() 메서드를 오버라이드 한다
 * [3] 2번에서 재정의한 메서드 안에서 코드 구현
 * 
 * 서블릿은 구현하고 나면 서블릿을 web.xml 에 등록하던지,아니면 어노테이션(@WebServlet)을 기술해야한다.
 * 
 */
public class HelloServlet extends HttpServlet{
	
	@Override
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException{
		//req: 사용자 요청과 관련된 정보를 추출하거나 다루는 객체
		//res: 브라우저와 연결되어 브라우저에 동적으로 html을 생성해서 쓸 수 있는 객체
		res.setContentType("text/html; charset=UTF-8");//브라우저에 보여줄 문서형식(마임타입,컨텐트타입)을 지정
														//디폴트 charset은 ISO-
		PrintWriter pw=res.getWriter();//브라우저와 노드 연결하고 있는 출력스트림을 반환한다.
		//출력스트림을 이용해 브라우저에 html을 출력하자
		pw.println("<h1>Hello Servlet</h1>");
		pw.println("<h2>안녕 서블릿~~</h2>");
		pw.println("<hr color='red'>");
		Date d=new Date();
		pw.println("<h3>Server Date: "+d.toString()+"</h3>");
		pw.println("");
		pw.close();
	}
}
