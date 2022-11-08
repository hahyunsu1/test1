package memo.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import memo.model.MemoDAO;
import memo.model.MemoVO;


@WebServlet("/MemoEditFrom")
public class MemoEditFromServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
//		MemoEditFormServlet작성
//		url매핑=> MemoEditForm 
//
//		1. 수정할 글 번호 받아 오기
//
//		2. 유효성 체크 -> redirect MemoList로 이동
//
//		3. MemoDAO의 selectMemo(idx)호출
//		==> MemoVO받아서 req에 저장
//		키값 "memo"
//
//		4. forward로 edit.jsp로 이동시킨다.
//		-----------------------------------------------
//		edit.jsp에서는 req에서 저장된 "memo"를 꺼내서
//		형변환한다. out.println(memo)
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out=res.getWriter();		
		String idxStr=req.getParameter("idx");		
		
			if(idxStr==null||idxStr.trim().isEmpty()) {	
				res.sendRedirect("MemoList");
				return;
				
			}
			int idx=Integer.parseInt(idxStr.trim());
			MemoDAO dao=new MemoDAO();
			try {
			MemoVO memo=dao.selectMemo(idx);						
			req.setAttribute("memo", memo);			
			String viewPage="memo/edit.jsp";
			RequestDispatcher disp=req.getRequestDispatcher(viewPage);
			disp.forward(req, res);
			}catch(Exception e) {
				e.printStackTrace();
				out.print("error: "+e.getMessage()+"<br>");
			}
			out.close();

	}

}
