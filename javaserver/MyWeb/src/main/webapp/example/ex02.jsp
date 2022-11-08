<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<h1>scripting element</h1>
<%--
[1] scriptlet  : <% %>  => 여기서 선언된 변수는 지역변수
[2] declaration: <%! %> => 여기서 선언된 변수는 멤버면수
[3] expression : <= %>
 --%>
<h1><%=new Date().toString() %></h1>
<%!
//여기서는 멤버변수를 선언하거나 사용자정의의 메서드를 구성할 수 있다.
	String global="인스턴스변수(맴버변수)";

	public String sum(int a, int b){
		return a+"+"+b+"="+(a+b);
	}
%>
<h2><%=global %></h2>
<!-- sum()호출해서 변환해주는 값 출력하기 -->
 <h2 style="color:tomato"><%=sum(10,20) %></h2>
 <%
 	String local="지역변수";
 %>