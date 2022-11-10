<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!-- --------------------------------------------------------------->  
<link rel="stylesheet" type="text/css" href="../css/layout.css"> 
<script src="../js/userCheck.js"></script>
<!-- --------------------------------------------------------------->  

<%
	String method=request.getMethod();
	out.println("method: "+method+"<br>");
	//get방식일때는 입력 폼을 보여주고
	//post방식일떄는 아이디 사용 가능 여부 결과를 보여주자
	if(method.equalsIgnoreCase("get")){
%>

<div class="container m2" style="margin-top:2em">
	<form name="idf"action="idCheck.jsp" method="post">
		<label for="userid">아이디</label>
		<input type="text" name="userid" id="userid" placeholder="User ID" autofocus="autofocus">
		<button type="button" onclick="id_check()">확 인</button>
	</form>

</div>
<%
	}else{
		//post방식이라면 ==? userid값 받아서 사용가능 여부를 알려줌
		String userid=request.getParameter("userid");
		%>
<jsp:useBean id="userDao" class="user.model.UserDAO" scope="session"/>
		<%
		boolean isUse=userDao.idCheck(userid);
		if(isUse){
			out.println("사용 가능");
		}else{
			out.println("사용 불가능");
		}
	}
%>