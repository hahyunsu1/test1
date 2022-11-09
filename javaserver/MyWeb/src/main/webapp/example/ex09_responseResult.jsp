<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<a href="ex09_response.jsp">로그인 폼으로 돌아가기</a>
<%
	//아이디,비번밥ㄷ기
	String userid=request.getParameter("userid");
	String pwd=request.getParameter("pwd");
	out.print(userid+"/"+pwd+"<br>");
	//유효성 체크
	if(userid==null||pwd==null){
		response.sendRedirect("ex09_response.jsp");
		//브라우저의 url을 ex09_response.jsp로 바꾸어서 새롭게 요청을 보내는 방식으로 이동한다.
		return;
	}
	if("".equals(userid.trim())||pwd.trim().isEmpty()){//빈문자열 체크
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);//잘못된 요청 에러 400에러
		return;
	}
	if(userid.equalsIgnoreCase("killer")){
		response.sendError(response.SC_FORBIDDEN);//접근 금지 에러 403에러
		return;
	}

%>
<h1 style='color:blue'><%=userid %>님 환영합니다</h1>