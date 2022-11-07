package memo.servlet;

import java.io.*;


import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import memo.model.*;
import java.util.*;


@WebServlet("/MemoDelete")
public class MemoDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out=res.getWriter();
		
		int idx=Integer.parseInt(req.getParameter("idx"));
		try {
		if(idx!=0) {
			
			MemoDAO dao=new MemoDAO();
			dao.deleteMemo(idx);
			List<MemoVO> arr=dao.selectMemoAll();
			req.setAttribute("memoArr", arr);			
			String viewPage="memo/list.jsp";
			RequestDispatcher disp=req.getRequestDispatcher(viewPage);
			disp.forward(req, res);
		}
		}catch(Exception e) {
			e.printStackTrace();
			out.print("error: "+e.getMessage()+"<br>");
		}
		
		
	}


	

}
