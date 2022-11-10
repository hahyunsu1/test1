<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="user.model.*"%>
<%
	UserVO user = (UserVO) session.getAttribute("loginUser");
	if(user==null){
		%>
		<script>
			alert('로그인 해야 이용 가능합니다');
			location.href="<%=request.getContextPath()%>/login/login.jsp";
		</script> 
		<%
		return;
	}
	
%>