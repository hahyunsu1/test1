<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<!-- isErrorPage="true" 을 주어야 한다. -->
<%
	//IE의 경우 브라우저가 자체적으로 에러를 처리할려고 한다. 그래서 에러가 발생한 것이 아니게끔 인식하도록 아래 코드를 기술하자.
	response.setStatus(200);//응답 성공=>200 OK
%>
<div class="container err">
	<h1>Server Error:<%= exception.getMessage() %></h1>
<%
	exception.printStackTrace();//디버깅용 => 톰캣 콘솔에 출력함
%>
	<a href="javascript:history.back()">이전 페이지로 돌아감</a>
	<!-- href=""에 자바스크립트 코드를 기술할려면 "javascript:" 프로토콜을 붙여야 한다.-->
	<button onclick="history.back()">이전페이지로 돌아감</button>
</div>