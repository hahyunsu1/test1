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
	if(user.getStatus()==-1){
		String str="정지회원 입니다. 활동회원으로 전환해야 서비스 이용 가능합니다.";
		%>
		<script>
			alert('<%=str%>');
			location.href="<%=request.getContextPath()%>/member/modify.jsp";
		</script>
		<%
		return;
	}
	
%>