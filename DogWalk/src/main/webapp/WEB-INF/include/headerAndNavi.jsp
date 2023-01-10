<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

 
	<!-- pageContext.request.userPrincipal.name -->
	
	<c:set var="user" value="${sessionScope.user}" />
	
	

<!-- 알람테스트 세션에 저장된 유저 이메일 저장 시작 -->
<se:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN')">
<input type="hidden" id="userid" value="${session.member.userid}">
</se:authorize>
	<!-- 알람테스트 세션에 저장된 유저 이메일 저장 끝 -->
	<!-- 알람테스트 세션에 저장된 유저 이메일 저장 시작 -->
			<!-- <th:block th:if="${session.currentUser != null}">
				<input type="hidden" th:value="${session.currentUser.user_email}" id="user_email">
				</th:block> -->
	<!-- 알람테스트 세션에 저장된 유저 이메일 저장 끝 -->

<script src="${pageContext.request.contextPath}/assets/js_2sotto/headerAndNavi.js"></script>
<script>
//알람테스트 

function popupchatList(){
	
	var popupX = (window.screen.width / 2) - (1000 / 2);  
	//만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음

	var popupY= (window.screen.height /2) - (1000 / 2); 
	//만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	
	window.open('${pageContext.request.contextPath}/chatList.bit','_blank',
			'width=580, height=700, left='+ popupX + ', top='+ popupY+'');
	
	}
</script>