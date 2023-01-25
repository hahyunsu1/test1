<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    


<head>

<title>팀 4랑해요~</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-material-datetimepicker/2.7.1/css/bootstrap-material-datetimepicker.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<%@ include file="/WEB-INF/include/import.jsp"%>
</head>
<%@ include file="/WEB-INF/include/header.jsp"%>

<style>
	body{
		background-image: url('./file/강아지14.jpg');
		background-repeat: no-repeat;
		background-size: cover;
		height: 100%
	}
		footer {
		background-color: #000000;
		height: 280px;
		position: relative;
   		transform: translatY(-100%);
	}
	.about_section {
    min-height: 100%;
    position: relative;
    padding-bottom: 60px;
	}
	
	.footer-content {
		color: #FFFFFF;
		margin: 0 auto;
		padding: 40px 0;
		font-size: 12px;
	}
	
	.hr {
    border: 0;
    height: 2px;
    background: #FFFFFF;
  }
</style>
<body>
	<c:set var="myctx" value="${pageContext.request.contextPath}"/>
	
	<div class="about_section">
	
		<div class="about_text">
			<div class="container">
				<h1 class="about_taital_1"><strong><span style="color: #f7941d;">반려견</span> 매칭플랫폼</strong></h1>
				<p class="magna_text"> 회원가입을 하시면 새로운 친구,시간이 없을때 돌봐줄 사람을 구할수 있습니다.</p>
				<!-- <div class="about_bt">
					<button class="more_bt">Read More</button>
				</div>
				<div class="about">
					<h1 class="numbar_text">02</h1>
				</div>
				 -->
			</div>
		</div>
		
	</div>     

</body>

<footer>

	<div class="footer-content text-center">
	</div>

	<div class="footer-content text-center">
		
		<br>
		Copyright ⓒ animal
		<br>
		This homepage is powered by animal
		<br>
		Designed by animal
	</div>
	
	<div class="footer-content text-center">
		
		
	</div>
	
	
	<div class="footer-content text-center">
		<br>
		모든 생명은 보호받을 권리가 있습니다.
		<br>
		작은 도움이 모여 큰 사랑이 됨을 확인하세요.
		<br>
		
		<br>
		
	</div>
		<div class="footer-content text-center">		
	</div>
</footer>


