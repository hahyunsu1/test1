
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>양육 정보 게시판</title>
    <link href="style.css" rel="stylesheet" type="text/css">
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
                <li><a class="menuLink" href="/animal-care" style="font-weight: bold">양육정보</a></li>
                <li><a class="menuLink" href="/second-hand">중고거래</a></li>
            </ul>
        </nav>
    </div>
    <div>
        <nav id="kinds">
            <ul>
                <li><a class="menuLink" href="/animal-care?kinds=강아지">강아지</a></li>
                <li><a class="menuLink" href="/animal-care?kinds=고양이">고양이</a></li>
                <li><a class="menuLink" href="/animal-care?kinds=열대어">열대어</a></li>
                <li><a class="menuLink" href="/animal-care?kinds=햄스터">햄스터</a></li>
                <li><a class="menuLink" href="/animal-care?kinds=토끼">토끼</a></li>
                <li><a class="menuLink" href="/animal-care?kinds=새">새</a></li>
            </ul>
        </nav>
    </div>
    <div>
        <nav id="tags">
            <ul>
                <li><a class="menuLink" href="/animal-care?tag=전체보기">${kinds}/전체보기</a></li>
                <li><a class="menuLink" href="/animal-care?tag=건강">${kinds}/건강</a></li>
                <li><a class="menuLink" href="/animal-care?tag=음식">${kinds}/음식</a></li>
                <li><a class="menuLink" href="/animal-care?tag=행동">${kinds}/행동</a></li>
                <li><a class="menuLink" href="/animal-care?tag=훈련">${kinds}/훈련</a></li>
                <li><a class="menuLink" href="/animal-care?tag=백과사전">${kinds}/백과사전</a></li>
            </ul>
        </nav>
    </div>


    <div class="products">
        <h3>게시글 목록</h3>

        <div class="product-list">
            <c:forEach var="item" items="${list}" >
                <a href="#" class="product">
                    <div class="product-left">
                        <img src="<spring:url value='/image/${item.filename}'/>" width="200px" alt="" />
                    </div>
                    <div class="product-right">
                        <p>${item.title}</p>
                        <p>${item.wdate} ${item.cnt}</p>
                        <p>${item.tags}</p>
                    </div>
                </a>
            </c:forEach>
        </div>
        <div class="clearfix"></div>
    </div>

    <div>
        <ul>
            <c:forEach begin="1" end="${end}" var="idx">
                <li><a href="animal-care?page=${idx}&kinds=${kinds}">${idx}</a></li>
            </c:forEach>
        </ul>
    </div>
    <div>
        <div>
            <a href="animal-care/write">글 작성</a>
        </div>
    </div>



</body>
</html>
