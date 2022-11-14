<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
	String myctx=request.getContextPath();
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
            <a href="<%=myctx%>/index.do" ><img src="<%=myctx%>/images/로고.png"></a>
        </header>
        <div class="clear"></div>
        <nav>
            <ul>
                <li><a href="<%=myctx%>/index.do">Home</a></li>
                <li><a href="<%=myctx%>/boardWrite.do">Board 글쓰기</a></li>
                <li><a href="<%=myctx%>/boardList.do">Board 목록</a></li>
               
            </ul>
        </nav>
        <div class="clear"></div>
        <article>