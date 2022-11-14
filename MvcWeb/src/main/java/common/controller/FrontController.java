package common.controller;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/*FrontController : *.do 패턴의 모든 요청을 받아들인다.
 * - Command.properties 파일에 있는 매핑 정보를 읽어들여 해당 요청uri와 매핑되어 있는
 *   SubController(XXXAction)을 찾아 객체화 한 뒤 해당 객체의 메소드(execute)를 호출한다.
 * - 서브 컨트롤러는 해당 작업을 수행한 뒤에 다시 FrontController로 돌아와 보여줘야 할 View
 *   페이지(JSP) 정보를 넘긴다.
 * - FrontController는 해당 뷰페이지로 이동시킨다. (forward방식 이동 or redirect방식 이동)    
 * */
//Command.properties파일의 절대경로를 본인의 경로에 맞게 수정 함


@WebServlet(
		urlPatterns = { "*.do" }, 
		initParams = { 
				@WebInitParam(name = "config", 
						value = "C:\\Users\\hysdd\\Documents\\test1\\MvcWeb\\src\\main\\webapp\\WEB-INF\\Command.properties")
		})
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	public void init(ServletConfig conf )throws ServletException{
		System.out.println("init()호출된....");
		String props=conf.getInitParameter("config");
		System.out.println("props=="+props);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request,response);
	}
	

	private void process(HttpServletRequest req, HttpServletResponse res) {
		
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		process(request,response);
	}

}
