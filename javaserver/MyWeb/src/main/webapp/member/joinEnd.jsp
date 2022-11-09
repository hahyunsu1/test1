<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="user.model.*" errorPage="/example/myerror.jsp"%>
<%
	
	request.setCharacterEncoding("UTF-8");
//useBean액션을 이용해서 UserVO객체와 UserDAO객체를 생성해보자
	
%>
<jsp:useBean id="user" class="user.model.UserVO" scope="page" />
<%-- UserVO user=new UserVO();와 동일함 --%>
<jsp:setProperty property="*" name="user" />
<%--
	user.setName(request.getParameter("name");
	user.setName(request.getParameter("userid");
 --%>
 <%
 	if(user.getUserid()==null||user.getName()==null){
 		response.sendRedirect("join.jsp");
 		return;
 	}
 %>
 <jsp:useBean id="userDao" class="user.model.UserDAO" scope="session"/>
 <%
 	int n=userDao.insertUser(user);	
	String str=(n>0)?"회원가입 처리 완료":"회원가입 실패";
	String loc=(n>0)?"list.jsp":"javascript:history.go(-1)";
 %>
<script>
	alert('<%=str%>');
	location.href='<%=loc%>';
</script>