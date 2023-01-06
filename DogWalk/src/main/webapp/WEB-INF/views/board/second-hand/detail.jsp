<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>중고 거래 게시판</title>
    <link href="/style.css" rel="stylesheet" type="text/css">
</head>
<body>
    <h1>
        <div class="header">
            <a href="">헤더</a>
        </div>
    </h1>
    <div class="page">
        <nav id="menu">
            <ul>
                <li><a class="menuLink" href="/animal-care">양육정보</a></li>
                <li><a class="menuLink" href="/second-hand" style="font-weight: bold">중고거래</a></li>
            </ul>
        </nav>
    </div>
    <h3>게시글 목록</h3>
    <div class="product">
        <div class="product-left">
            <img src="<spring:url value='/image/${item.filename}'/>" width="200px" alt="" />
        </div>
        <div class="product-right">
            <p>${item.title}</p>
            <p>${item.price}</p>
            <p>배송비 무료(판매자 부담)</p>
            <p>${item.wdate} ${item.cnt}</p>
            <p><button>1:1 대화</button><button>신고하기</button><button>바로 구매</button></p>
        </div>
    </div>
    <div class="clearfix"></div>
    <section id="container">
        <table border="1">
            <tr>
                <th>글내용</th>
                <th>판매자정보</th>
            </tr>
            <tr>
                <td><c:out value="${item.content}"/></td>
                <td><c:out value="${item.nick_fk}"/></td>
            </tr>
        </table>
    </section>
</body>
</html>
