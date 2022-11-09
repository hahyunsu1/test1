<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//Context명을 동적으로 알아내자 "/MyWeb"==> Context
	//절대경로방식: 컨텍스트를 기준으로 경로잡는 방식 "/MyWeb/memo/list.jsp"
	//top.jsp,foot.jsp 는 공통모듈==> 절대경로로 경로를 잡아줘야 한다
	String myctx=request.getContextPath();
	//System.out.println("mxctx: "+myctx);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>홈페이지</title>
    <link rel="stylesheet"type="text/css" href="<%=myctx%>/css/layout.css">
</head>
<body>
    <div id="wrap" class="container">
        <header>
            <a href="<%=myctx%>/index.jsp" ><img src="<%=myctx%>/images/로고.png"></a>
        </header>
        <div class="clear"></div>
        <nav>
            <ul>
                <li><a href="<%=myctx%>/index.jsp">Home</a></li>
                <li><a href="<%=myctx%>/member/join.jsp">Signup</a></li>
                <li><a href="<%=myctx%>/login/login.jsp">Signin</a></li>
                <li><a href="#">Borard</a></li>
            </ul>
        </nav>
        <div class="clear"></div>
        <article>