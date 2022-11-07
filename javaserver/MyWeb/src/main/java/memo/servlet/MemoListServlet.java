package memo.servlet;

import java.io.*;


import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import memo.model.*;
import java.util.*;
@WebServlet("/MemoList")
public class MemoListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out=res.getWriter();
		//전체 메모 목록 가져오기
		MemoDAO dao=new MemoDAO();
		try {
			List<MemoVO> arr=dao.selectMemoAll();
			//모델 통해 가져온 데이터를 req에 저장한뒤 View페이지로 이동한다.
			//==>이떄 주의. redirect방식이 아니라forward방식으로 이동해야 한다.
			//req.setAttribute(key값,value값);
			req.setAttribute("memoArr", arr);
			
			String viewPage="memo/list.jsp";
			
//			res.sendRedirect(viewPage);//새로운 요청을 발생시킨다.
			
			//forward이동해보자.
			RequestDispatcher disp=req.getRequestDispatcher(viewPage);
			disp.forward(req, res); //forward이동할때 req,res를 가지고 간다.
			//redirect: 브라우저의 url을 변경해서 새로운 request를 발생시ㅣ는 방식으로 이동
			//forward: 서버 내부에서 페이지 이동을 한다.따라서 브라우저는 이동한 url을 알지 못한다.
		} catch (Exception e) {
			e.printStackTrace();
			out.println("error: "+e.getMessage()+"<br>");
		}
		out.close();
	}

}
