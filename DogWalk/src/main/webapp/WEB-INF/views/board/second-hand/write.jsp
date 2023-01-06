<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>중고거래 글쓰기</title>
</head>

<body>


<table width="500" cellpadding="0" cellspacing="0" border="1">
    <form action="" method="post" enctype="multipart/form-data">
        <tr>
            <td> 제목</td>
            <td><input type="text" name="title" size="50"></td>
        </tr>
        <tr>
            <td> 내용</td>
            <td><textarea name="content" rows="10"></textarea></td>
        </tr>
        <tr>
            <td> 카테고리</td>
            <td><input type="text" name="category" size="50"></td>
        </tr>
        <tr>
            <td> 작성자 이름</td>
            <td><input type="text" name="nickFk" size="50"></td>
        </tr>
        <tr>
            <td>가격</td>
            <td><input type="text" name="price" size="50"></td>
        </tr>
        <tr>
            <td> 비밀번호</td>
            <td><input type="text" name="cpss" size="50"></td>
        </tr>
        <tr>
            <td>
                <input type="file" name="file">
            </td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="제출"> &nbsp;&nbsp; <a href="/second-hand">목록보기</a></td>
        </tr>
    </form>
</table>


</body>

</html>

