<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js" integrity="sha256-HwWONEZrpuoh951cQD1ov2HUK5zA5DwJ1DNUXaM6FsY=" crossorigin="anonymous"></script>

<html>
<head>
    <meta charset="UTF-8">
    <title>중고 거래 게시판</title>
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
            <li><a class="menuLink" href="/animal-care">양육정보</a></li>
            <li><a class="menuLink" href="/second-hand" style="font-weight: bold">중고거래</a></li>
        </ul>
    </nav>
</div>

<section id="container">
    <table>
        <tr>
            <th>번호</th>
            <th>카테고리</th>
            <th>제목</th>
            <th>글쓴이</th>
            <th>날짜</th>
            <th>조회수</th>
        </tr>

        <c:forEach var="item" items="${list}" >
            <tr>
                <td><c:out value="${item.cnum}"/></td>
                <td><c:out value="${item.category}"/></td>
                <td><a href="/second-hand/${item.cnum}"><c:out value="${item.title}"/></a></td>
                <td><c:out value="${item.nick_fk}"/></td>
                <td><c:out value="${item.wdate}" /></td>
                <td><c:out value="${item.cnt}"/></td>
            </tr>
        </c:forEach>

    </table>
</section>
<div>
    <ul>
        <c:forEach begin="1" end="${end}" var="idx">
            <li><a href="second-hand?page=${idx}&search=${search}">${idx}</a></li>
        </c:forEach>
    </ul>
</div>
<div>
    <div>
        <a href="second-hand/write">글 작성</a>
    </div>
    <div class="search">
        <select name="searchType">
            <option value="t"<c:out value="${searchType eq 't' ? 'selected' : ''}"/>>제목</option>
            <option value="w"<c:out value="${searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
            <option value="tc"<c:out value="${searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
        </select>

        <input type="text" name="keyword" id="keywordInput" value="${keyword}"/>

        <button id="searchBtn" type="button">검색</button>
        <script>
            $(function(){
                $('#searchBtn').click(function() {
                    self.location = "second-hand?page=${page}" + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
                });
            });
        </script>
    </div>
</div>

</body>
</html>
