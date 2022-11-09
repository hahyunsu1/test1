<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	String myctx=request.getContextPath();
    %>
<jsp:include page="/top.jsp"/>
<div class="container">
	
	<h1 align="center">성적입력</h1>
	<table width="300" cellpadding="0" cellspacing="0" align="center" border="1px" solid="#444444">
	
	<form action="result.jsp" methood="post">
	<tr>
	<td colspan="2" id="idx">사번</td>
	
	<td>
	<input type="text" name="user" required pattern="[0-9]{4,12}">
	</td>
	</tr>
	<tr>
	<td rowspan="3">과목</td>
	
	<td>Java</td>
	<td><input type="text" name="Java" size="5" min="0" max="100"></td>
	</tr>
	<tr>
	<td>Database</td>
	<td><input type="text" name="Database" size="5" min="0" max="100"></td>
	</tr>
	<tr>
	<td>JSP</td>
	<td><input type="text" name="Jsp" size="5" min="0" max="100"></td>
	</tr>
	</tr>
	<tr>
	<td colspan="3" align="center">
	<button href="<%=myctx%>/result.jsp" >저장</button><br>
	</td>	
	</tr>
	
	</table>
	
	</form>
</div>
<jsp:include page="/foot.jsp"/>