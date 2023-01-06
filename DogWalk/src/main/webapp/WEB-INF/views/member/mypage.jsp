<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<title>회원정보 수정</title>
</head>
<body>

<h1 align="center">회원정보수정</h1>
	<div class="">
		<form action="/web/member/mypage" method="post">
			<table>
				<tr>
					<td>* 아이디</td>
					<td><input type="text" id="userid" name="userid" value="${member.userid}" readonly>
					</td>
				</tr>
				<tr>
					<td>* 비밀번호</td>
					<td><input type="pwd" name="pwd" value="${member.pwd}"></td>
				</tr>
				<tr>
					<td>* 이름</td>
					<td><input type="text" name="name" value="${member.name}" readonly></td>
				</tr>

				<tr>
					<td>* 이메일</td>
					<td><input type="text" name="memberEmail" value="${member.mail}"></td>
				</tr>
				<tr>
					<td>* 전화번호</td>
					<td>
					<input type="text" name="hp1" id="hp1" maxlength="3" value="${member.hp1}">- 
					<input type="text" name="hp2" id="hp2" maxlength="4" value="${member.hp2}">-
					<input type="text" name="hp3" id="hp3" maxlength="4" value="${member.hp3}">
				</td>
				</tr>
				<tr>
					<td>* 우편번호</td>
					<td><input type="text" name="post" value="${member.post}" ></td>
				</tr>
				<tr>
					<td>* 주소</td>
					<td><input type="text" name="address1" value="${member.addr1}">
					<input type="text" name="address2" value="${member.addr2}">
					</td>
				</tr>				
				<tr>
				<td colspan="2" align="center">
			<input type="submit" value="수정하기">
			<button type="button" onclick="removeMember();"> 탈퇴하기 </button>
			<!-- //type을 button으로 꼭 적어줘야! submit이 되지 않는다!! 꼭 기억하기!
				 -->
				</td>
				</tr>
				
			</table>
			
		</form>
	</div>
	
			
<script>
function removeMember() {
	if(window.confirm("탈퇴하시겠습니까?")){
	location.href="/web/member/remove";
	}
	
}
</script>
</body>
</html>