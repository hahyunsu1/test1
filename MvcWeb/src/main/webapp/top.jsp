<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
               
                <!-- el표현식 연산자: eq(==와 동일함),ne(!=와 동일 -->
                
                <li><a href="<%=myctx%>/user/boardWrite.do">Board 글쓰기</a></li>
                <li><a href="<%=myctx%>/boardList.do">Board 목록</a></li>
               	<li><a href="<%=myctx%>/user/myPage.do">MyPage</a></li>
               	<c:choose>                
                	<c:when test="${loginUser==null}">
                		 <li><a href="<%=myctx%>/joinForm.do">회원가입</a></li>
               		 	<li><a href="<%=myctx%>/login.do">로그인</a></li>
              		</c:when>
              		 <c:otherwise>
                		<li><a href="<%=myctx%>/logout.do">로그아웃</a></li>
               		 </c:otherwise>
                </c:choose>
            </ul>
        </nav>
        <div class="clear"></div>
        <article>