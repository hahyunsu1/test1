<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="user.model.*"%>

<jsp:include page="/top.jsp"/>
<script type="text/javascript" src="../js/userCheck.js"></script>
<%
	UserVO user = (UserVO) session.getAttribute("loginUser");
	if(user==null){
		response.sendRedirect("../login/login.jsp");
		return;
	}
%>
<style>
	#ra1,#ra2,#ra3,#ra4{
		padding:3px;
		width:60px;
		border:1px solid red;
	}
</style>
<div class="container">
	<h1>회원정보 수정</h1>
	<form name="mf" action="modifyEnd.jsp" method="post">
		<!-- hidden field----------------------------------------------  -->
		<input type="hidden" name="idx" value="<%=user.getIdx()%>">
		<!-- ----------------------------------------------------------  -->
		<table border="1" style="width:90%;margin:auto;margin-top:2em">
			<tr>
				<td width="20%" class="m1"><b>이름</b></td>
				<td width="80%" class="m2">
				<input type="text" name="name" value="<%=user.getName()%>"id="name" placehoder="Name">
				<br><span class='ck'>*이름은 한글만 가능해요</span>
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>아이디</b></td>
				<td width="80%" class="m2">
				<input type="text" name="userid" value="<%=user.getUserid()%>" id="userid" readonly placehoder="User ID">
				<button type="button" onclick="open_idcheck()">아이디 중복 체크</button>
				<br><span class='ck'>*아이디는 영문자,숫자, _, !포함해서4~8자리 이내</span>
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>비밀번호</b></td>
				<td width="80%" class="m2">
				<input type="password" name="pwd" id="pwd" placehoder="Password">
				<br><span class='ck'>*비밀번호는 문자,숫자,!,. 포함해서4~12자리 이내</span>
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>비밀번호 확인</b></td>
				<td width="80%" class="m2">
				<input type="password" name="pwd2" id="pwd2" placehoder="Re Password">
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>연락처</b></td>
				<td width="80%" class="m2">
				<input type="text" name="hp1" value="<%=user.getHp1()%>" id="hp1" placehoder="HP1">-
				<input type="text" name="hp2" value="<%=user.getHp2()%>"id="hp2" placehoder="HP2">-
				<input type="text" name="hp3" value="<%=user.getHp3()%>"id="hp3" placehoder="HP3">
				<br><span class='ck'>*앞자리(010|011)중에 하나-(숫자3~4자리)-(숫자4자리) 가능해요</span>
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>우편번호</b></td>
				<td width="80%" class="m2">
				<input type="text" name="post" value="<%=user.getPost()%>" id="post" placehoder="Post">
				<button type="button">우편번호 찾기</button>
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>주소</b></td>
				<td width="80%" class="m2">
				<input type="text" name="addr1" value="<%=user.getAddr1()%>"id="addr1" placehoder="Address1"><br>
				<input type="text" name="addr2" value="<%=user.getAddr2()%>" id="addr2" placehoder="Address2">
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>마일리지</b></td>
				<td width="80%" class="m2">
				<b><%=user.getMileage() %>점</b>
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>회원상태</b></td>
				<td width="80%" class="m2">
				<b class="state<%=user.getStatus()%>"><%=user.getStatusStr() %></b>
				<br>
				<input type="radio" name="status" value="0" <%=(user.getStatus()==0)?"checked":"" %> id="ra1">활동회원
				<input type="radio" name="status" value="-1"<%=(user.getStatus()==-1)?"checked":"" %> id="ra2">정지회원
				<input type="radio" name="status" value="-2"<%=(user.getStatus()==-2)?"checked":"" %> id="ra3">탈퇴회원
				<!--<input type="radio" name="status" value="3" id="ra4">관리자회원-->
				
				</td>
			</tr>
			<tr>
				<td colspan="2" class="m3">
					<button type="button" onclick="member_check()">회원가입</button>
					<button type="reset">다시쓰기</button>
				</td>
			</tr>
		</table>	
	</form>
</div>
<jsp:include page="/foot.jsp"/>