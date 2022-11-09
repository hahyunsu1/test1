<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ex08request.jsp</title>
</head>

<body style="padding-left:5em">
    <!-- form태그의 속성
	1) name, id : 폼을 식별할 수 있는 이름
	2) action : 폼 양식을 처리해줄 서버 페이지를 기술한다.
	3) method : 데이터 전송방식을 기술한다. 주로 get아니면 post를 기술한다. put, delete,..
			get방식은 간단한 데이터 전송시 사용한다.=> 사용자가 입력한 값이 url부분에 노출됨
			post방식은 대용량의 데이터 전송시 사용 => 데이터가 노출되지 않는다.
    4) enctype : 인코딩 방식을 지정한다.
				파일 업로드시는 multipart/form-data를 지정해야 한다.
                application/x-www-form-urlencoded==>디폴트 (파일첨부시 파일명만 전송됨)

        http://localhost:8080/join.jsp?name=test&userid=aaa&pwd=1111&photo=&gender=Male
		&hobby=sports&hobby=movie

        http://127.0.0.1:5500/join?userid=sdfsdfs&pwd=123 =>GET방식의 요청일 때
        get방식 요청일 때는 입력 데이터를 query string으로 url부분에 포함시켜서 서버에 전송한다.
        ?userid=sdfsdfs&pwd=123 => Query String

        http://127.0.0.1:5500/join ===> POST 방식 요청일 때
	-->

    <h1>form양식</h1>
    <p>
        form태그는 사용자가 입력한 값들을 웹서버에 전달하고자 할 떄 사용한다
        <br>
        form태그 안에는 다양한 입력 양식들이 올 수 있는데 이를 form control이라고 한다
    </p>
    <hr color="red">
    <!-- method: get(디폴트), post(비밀적으로 보낼때 사용,첨부파일,로그인정보등),
         put, delete, options 
        enctype="application/x-www-form-urlencoded"-->
    <form name="frm" id="frm" action="ex08_requestResult.jsp" method="get">
         <!-- enctype="multipart/form-data">--파일 업로드 필요할때 -->
        아이디:<input type="text" name="userid"> <br>
        비밀번호:<input type="password" name="password"> <br>
        회원사진:<input type="file" name="photo"><br>
        성별:<input type="radio" name="gender"value="M">남자
             <input type="radio" name="gender"value="F" checked="checked">여자<br>
             <!-- 단일 선택: radio 이떄 동일한 name일 경우 그 중에 1개만 선택함
                  다중 선택: checkbox -->
             취미
             <input type="checkbox" name="hobby"value="Sprots">운동
             <input type="checkbox" name="hobby"value="books">독서
             <input type="checkbox" name="hobby"value="musics">음악감상
             <input type="checkbox" name="hobby"value="movies">영화감상<br>
             <!-- select : 기본은 단일선택
                    -multiple 속성을 주면 다중선택이 가능함
                    -size 속성을 주면 편친형태가 된다
             -->
             드롭다운리스트:
             <select name="job">
                <option value="">::직업을 선택하세요::</option>
                <option value="Developer"selected>개발자</option>
                <option value="Designer">디자이너</option>
                <option value="Manager">매니저</option>
                
             </select><br>
             <select name="lang" multiple size="6">
                <option value="">::사용가능 언어::</option>
                <option value="Java">Java</option>
                <option value="JavaScript">JavaScript</option>
                <option value="SQL">SQL</option>
             </select><br>
             자기소개
             <textarea name="intro" rows="5" cols="70"
             placeholder="자기소개를 100자이내로 하세요"></textarea><br>
             히든필드:
             <input type="hidden" name="secret" value="TopSecret"><br>
        <input type="submit" value="회원가입"><!--전송버튼-->
        <input type="button" value="일반버튼"onclick="alert('안녕하세요')"><!-- 일반버튼 -->
        <input type="reset" value="다시쓰기"><!-- 다시쓰기 -->
        <input type="image" src="../images/네이버 로고.png">
        <!-- 이미지버튼은 기본적으로 submit기능을 갖는다.-->
        <img src="../images/네이버 로고.png" onclick="alert('잘가세요')">

    </form>
</body>
</html>
