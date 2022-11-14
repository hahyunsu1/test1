package common.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Properties;
import java.util.Set;

import javax.servlet.RequestDispatcher;
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

@WebServlet(urlPatterns = { "*.do" }, initParams = {
		@WebInitParam(name = "config", value = ""
				+ "C:\\Users\\hysdd\\Documents\\test1\\MvcWeb\\src\\main\\webapp\\WEB-INF\\Command.properties") })
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private HashMap<String, Object> cmdMap=new HashMap();
	
	@Override
	public void init(ServletConfig conf) throws ServletException {
		System.out.println("init()호출된....");
		String props = conf.getInitParameter("config");
		System.out.println("props==" + props);
		
		Properties pr=new Properties();
		try {
			FileInputStream fis=new FileInputStream(props);
			pr.load(fis);
			//Command.properties파일 정보를 Properties객체로 옮긴다.
			if(fis!=null) fis.close();
//			String val=pr.getProperty("/index.do");
//			System.out.println("val="+val);
			Set<Object> set=pr.keySet();
			if(set==null) return;
			for(Object key:set) {
				String cmd=key.toString();//key값 "/index.do"
				String className=pr.getProperty(cmd);//"common.controller.IndexAction"
				if(className!=null) {
					className=className.trim();//문자열 앞뒤 공백 제거
					
				}
				System.out.println(cmd+": "+className);
				//className을 실제 객체로 인스턴스화
				Class<?> cls=Class.forName(className);
				Object cmdInstance=cls.getDeclaredConstructor().newInstance();
				cmdMap.put(cmd, cmdInstance);
			}
			System.out.println("cmdMap.size(): "+cmdMap.size());
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		process(request, response);
	}

	private void process(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException{
		//1.클라이언트의 요청 URI를 번석해보자.
		/*
		String uri=req.getRequestURI();
		System.out.println("uri: "+uri);
		String myctx=req.getContextPath();//"/MvcWeb"
		int len=myctx.length();//7
		String cmd=uri.substring(len);
		*/
		String cmd=req.getServletPath();
		System.out.println("cmd===>"+cmd);
		
		Object instance=cmdMap.get(cmd);
		if(instance==null) {
			System.out.println("Action이 null");
			throw new ServletException("Action이 null입니다");
		}
		System.out.println("instance==>"+instance);
		AbstractAction action=(AbstractAction)instance;
		
		try {
			action.execute(req, res);
			//execute()는 컨트롤러 로직을 수행 한 뒤 뷰페이지랑 이동방식을 지정한다
			String viewPage=action.getViewPage();
			boolean isRedirect=action.isRedirect();
			System.out.println("viewPage: "+viewPage);
			if(viewPage==null) {
				viewPage="index.jsp";
			}
			if(isRedirect) {
				//redirect방식으로 페이지 이동
				res.sendRedirect(viewPage);
			}else {
				//forward방식으로 이동				
				RequestDispatcher disp=req.getRequestDispatcher(viewPage);
				disp.forward(req, res);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		process(request, response);
	}

}
