<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>양육정보 글쓰기</title>
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
            <td> 작성자 이름</td>
            <td><input type="text" name="nickFk" size="50"></td>
        </tr>
        <tr>
            <td> 비밀번호</td>
            <td><input type="text" name="cpss" size="50"></td>
        </tr>
        <tr>
            <td>태그</td>
            <td>
                <select name="tags">
                    <option value="전체보기">전체보기</option>
                    <option value="건강">건강</option>
                    <option value="음식">음식</option>
                    <option value="행동">행동</option>
                    <option value="훈련">훈련</option>
                    <option value="백과사전">백과사전</option>
                </select>
            </td>
        </tr>
        <tr>
            <td> 종류</td>
            <td>
                <select name="kinds">
                    <option value="강아지">강아지</option>
                    <option value="고양이">고양이</option>
                    <option value="열대어">열대어</option>
                    <option value="햄스터">햄스터</option>
                    <option value="토끼">토끼</option>
                    <option value="새">새</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>
                <input type="file" name="file">
            </td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="제출"> &nbsp;&nbsp; <a href="/web/animal-care">목록보기</a></td>
        </tr>
    </form>
</table>


</body>

</html>

