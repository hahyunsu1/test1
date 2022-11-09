<%@ page language="Java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<Jsp:include page="/top.Jsp"/>
<%
//	request.setCharacterEncoding("UTF-8");
	String numStr=request.getParameter("user");
	String JavaStr=request.getParameter("Java");
	String DatabaseStr=request.getParameter("Database");
	String JspStr=request.getParameter("Jsp");
	
	int user=0, Java=0, Database=0, Jsp=0;
	
	if(numStr==null || numStr.trim().isEmpty()){
		response.sendRedirect("ex06.Jsp");
		return;
	}else{
		user=Integer.parseInt(numStr.trim());
	}
	if(JavaStr.trim()==""){
		Java=0;
	}else{
		Java=Integer.parseInt(JavaStr.trim());
	}
	if(DatabaseStr.trim()==""){
		Database=0;
	}else{
		Database=Integer.parseInt(DatabaseStr.trim());
	}
	if(JspStr.trim()==""){
		Jsp=0;
	}else{
		Jsp=Integer.parseInt(JspStr.trim());
	}
	
	float favg=(Java+Database+Jsp)/(float)3;
	String avg=String.format("%.2f",favg);

%>
<style>
	input{
		width:98%;
		margin:auto 3px;
	}
	table{
		text-align:center;
		margin:auto;
	}
</style>
<div class="container">
	<h1>처리 결과</h1>
	<form name="frm" action="result.Jsp" method="post">
	<table border="1">
		<tr>
			<td colspan="2">사 번</td>
			<td><%=user %></td>
		</tr>
		<tr>
			<td rowspan="3">과 목</td>
			<td>Java</td>
			<td><%=Java %></td>
		</tr>
		<tr>
			<td>Database</td>
			<td><%=Database %></td>
		</tr>
		<tr>
			<td>Jsp</td>
			<td><%=Jsp %></td>
		</tr>
		<tr>
			<td colspan="2">평 균</td>
			<td><%=avg %></td>
		</tr>
		<tr>
			<td colspan="3"><button onclick="location.href='ex06.Jsp'">입력화면</button></td>
		</tr>
	</table>
	</form>
</div>
<Jsp:include page="/foot.Jsp"/>