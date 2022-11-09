<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.text.*" %>
<!-- page directive(page지시어) -->
<!-- html주석 -->
<h1>처음 해보는 JSP</h1>
<%//scriptlet 태그 : 이 안에서는 자바코드를 기술한다
 /*2.자바 주석*/
 //자바 주석
	Date today=new Date();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	String str=sdf.format(today);
	//out: JspWriter타입
	out.println("<h2>"+str+"</h2>");
%>
<%-- JSP 주석
	<%= %> : 출력식(expression) =>out.println(변수) 과 동일하다.
 --%>
 <h2 style="color:tomato"><%=str %></h2>
 <h2>ex07페이지에서 넘어온 파라미터 psge: <%=request.getParameter("page") %></h2>