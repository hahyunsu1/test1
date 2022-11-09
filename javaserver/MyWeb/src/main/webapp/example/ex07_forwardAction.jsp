<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>ex07_forwardAction페이지 입니다.</h1>
<h2>forward액션을 통해 이동할 예정입니다.</h2>
<h3>서버 내부에서 페이지 이동이 일어난다.</h3>
<h3>브라우저(client)의 url에는 이전 페이지 url이 나타난다.</h3>

<hr color='red'>
<jsp:forward page="ex01.jsp">
	<jsp:param value="7" name="page"/>
</jsp:forward>