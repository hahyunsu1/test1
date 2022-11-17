<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="user" class="user.model.UserVO" scope="page"/>
<jsp:setProperty property="*" name="user"/>
<%
	if(user.getIdx()==0||user.getName()==null||user.getUserid()==null){
		response.sendRedirect("../index.jsp");
		return;
	}

%>
<jsp:useBean id="userDao" class="user.model.UserDAO" scope="session"/>
<%
	int n=userDao.updateUser(user); 
	String str=(n>0)?"수정 처리 완료":"수정 실패";
	String loc=(n>0)?"modify.jsp":"javascript:history.back()";
%>
<script>
	alert('<%=str%>');
	location.href='<%=loc%>';
</script>
