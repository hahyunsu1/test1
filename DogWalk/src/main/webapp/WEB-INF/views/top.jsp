<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<!-- basic -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- mobile metas -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="initial-scale=1, maximum-scale=1">
<!-- site metas -->
<title>Team Love~ Project</title>
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="author" content="">	
<!-- bootstrap css -->
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<!-- style css -->
<link rel="stylesheet" type="text/css" href="css/style.css">
<!-- Responsive-->
<link rel="stylesheet" href="css/responsive.css">
<!-- fevicon -->
<link rel="icon" href="images/fevicon.png" type="image/gif" />
<!-- Scrollbar Custom CSS -->
<link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
<!-- Tweaks for older IEs-->
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
<!-- owl stylesheets --> 
<link rel="stylesheet" href="css/owl.carousel.min.css">
<link rel="stylesheet" href="css/owl.theme.default.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">


</head>
<body>
	<c:set var="myctx" value="${pageContext.request.contextPath}"/>	
	<!-- section banner start -->
	<div class="header_section">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-4">
					<div><a href="index.html"><img src="images/logo.png"></a></div>
				</div>
				<div class="col-md-8">
					<div class="menu_text">
						<ul>
						<c:if test = "${member == null }">
							<li class="last"><a href="${myctx}/member/login">로그인</a> /
                                <a href="${myctx}/member/register">회원가입</a>
                        </c:if>
                        <c:if test="${ member ne null }">
                            <li class="last"><a href="${myctx}/member/logout">로그아웃</a>
                                / <a href="${myctx}/member/memberUpdate">마이페이지</a> / <a
                                href="${myctx}/message/msgRePage.bit">나의 메세지함</a> 
                        </c:if>
                                <c:if test="${ member.status eq 99 }">
                            / <a href="${myctx}/admin/main">관리자 페이지</a>
                             </c:if>
							<li class="last"><img src="images/search-icon.png"></li>
							<li class="active">
							<div id="myNav" class="overlay">
                               <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
                            <div class="overlay-content">
                                <a href="/index">Home</a> <a href="${myctx}/NewFile1">병원지도</a> 
                                <!-- <a href="gallery.html">산책</a> -->
                                    <a href="${myctx}/comanimal/animal_boardlist">돌봄</a> <a
                                    href="${myctx}/management/main.bit">반려동물 등록</a> <a
                                    href="${myctx}/chatList.bit">채팅</a> <a
                                    href="${myctx}/qna/main">QNA</a> 
                                    
                            </div>
                        </div> <span style="font-size: 30px; cursor: pointer"
                        onclick="openNav()">&#9776; 메뉴</span>
                           </div>	
                           </li>
						</ul>
					</div>
			</div>
		</div>
    </div>
 
      <script src="https:cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js"></script>
    <script>
   
        function openNav() {
        document.getElementById("myNav").style.width = "100%";
        }
    
        function closeNav() {
       document.getElementById("myNav").style.width = "0%";
       }
    </script>
 