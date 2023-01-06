<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
<!-- basic -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- mobile metas -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="initial-scale=1, maximum-scale=1">
<!-- site metas -->
<title>팀 사랑해요~</title>
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
							<li class="last"><a href="${myctx}/member/login">로그인</a>
							/ <a href="${myctx}/member/join">회원가입</a>
							</li>
						</c:if>
						<c:if test="${ member != null }">
					      	<li class="last">
					        	<a href="${myctx}/member/logout">로그아웃</a>
					     	 </li>
					     </c:if>
							<li class="last"><a href="#"><img src="images/search-icon.png"></a></li>
							<li class="active">
							 <div id="myNav" class="overlay">
                                <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
                             <div class="overlay-content">
                             	<a href="/index">Home</a>
                                <a href="${myctx}/naverMap">병원지도 API</a>
                                <a href="gallery.html">산책</a>
                                <a href="${myctx}/comanimal/animal_boardlist">돌봄</a>
                                <a href="${myctx}/management/main.bit">반려동물 등록</a>
								<a href="${myctx}/second-hand">중고 게시판</a>
								<a href="${myctx}/animal-care">양육 게시판</a>
								<a href="${myctx}/board/list">문의 게시판</a>
                              </div>
                            </div>
                             <span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; 메뉴</span>
                            </div>	
                            </li>
						</ul>
					</div>
			</div>
		</div>
		<div class="banner_main">
			<div class="container">
				<div class="ram">
					<div class="row">
					    <div class="col-sm-12">
						    <h1 class="taital">Team Love~ Project</h1>
						    <p class="consectetur_text">1인가구 반려동물 돌봄서비스 </p>
						    <div class="banner_bt">
						    	<button class="read_bt">Here we go.</button>
						    </div>
					    </div>
				    </div>
				</div>
				<div class="box">
					<h1 class="numbar_text">01</h1>
				</div>
			</div>
		</div>
	</div>
	<!-- section banner end -->
	<!-- section about start -->
	<div class="about_section">
		<div class="about_text">
			<div class="container">
				<h1 class="about_taital_1"><strong><span style="color: #f7941d;">About</span> Dogs</strong></h1>
				<p class="magna_text"> consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exer</p>
				<div class="about_bt">
					<button class="more_bt">Read More</button>
				</div>
				<div class="about">
					<h1 class="numbar_text">02</h1>
				</div>
			</div>
		</div>
	</div>
	<!-- section about end -->
	<!-- section gallery start -->
    <div class="gallery_main layout_padding">
    	<div class="container">
    		<div class="row">
    			<div class="col-sm-12">
    				<h1 class="about_taital"><strong><span style="color: #ffffff;">Our</span> Dogs</strong></h1>
				    <p class="sed_text"> consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exer</p>

    			</div>
    		</div>
    		<div class="gallery_images">
    			<div class="row">
    				<div class="col-sm-7">
						<div class="gallery_blog">
                           <img src="images/gallery-img1.jpg" style="max-width: 100%; height: 300px; width: 100%;">
                        <div class="overlay">
                            <div class="text"><strong>PuppyDogPetAnimal</strong></div>
                        </div>
					    </div>
    				</div>
    				<div class="col-sm-5">
						<div class="gallery_blog">
                           <img src="images/gallery-img2.jpg" style="max-width: 100%; height: 300px; width: 100%;">
                        <div class="overlay">
                            <div class="text"><strong>PuppyDogPetAnimal</strong></div>
                        </div>
					    </div>
    				</div>
    			</div>
    		</div>
    		<div class="gallery_images">
    			<div class="row">
    				<div class="col-sm-5">
						<div class="gallery_blog">
                           <img src="images/gallery-img3.jpg" style="max-width: 100%; width: 100%;">
                        <div class="overlay">
                            <div class="text"><strong>PuppyDogPetAnimal</strong></div>
                        </div>
					    </div>
    				</div>
    				<div class="col-sm-7">
						<div class="gallery_blog">
                           <img src="images/gallery-img4.jpg" style="max-width: 100%; height: 300px; width: 100%;">
                        <div class="overlay">
                            <div class="text"><strong>PuppyDogPetAnimal</strong></div>
                        </div>
					    </div>
						<div class="gallery_blog">
                           <img src="images/gallery-img5.jpg" style="max-width: 100%; height: 297px; width: 100%;">
                        <div class="overlay">
                            <div class="text"><strong>PuppyDogPetAnimal</strong></div>
                        </div>
					    </div>
    				</div>
    			</div>
    		</div>
    	</div>
    </div>
    <div class="gallery_section_2">
    	<div class="container">
    		<div class="row">
    			<div class="col-sm-8">
    				<h1 class="pet_taital">Pet adoption be part of something beautiful</h1>
    				<p class="lorem_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit </p>
    			<div class="banner_bt">
					<button class="dog_bt">Read More</button>
				</div>
				<div class="box_3">
					<h1 class="numbar">03</h1>
				</div>
    			</div>
    			<div class="col-sm-4">
    				<div class="dog_img"><img src="images/dog-img.png" style="max-width: 100%;"></div>
    			</div>
    		</div>
    	</div>
    </div>
	<!-- section gallery end -->
	<!-- section get in touch start -->
    <div class="touch_section">
    	<div class="container">
    		<div class="row">
    			<div class="col-sm-12">
				    <h1 class="get_taital"><strong><span style="color: #ffffff;">Contact</span>  Us</strong></h1>
    			</div>
    		</div>
    		<div class="email_box">
					<c:import url="/weather"/>
                       </div>                   
                    </div>
    		</div>
    	</div>
    </div>
    <div class="touch_section_2">
    	<div class="container">
    		<div class="row">
    			<div class="col-sm-12">
    				<h1 class="our_texts">Our Newsletter</h1>
    				<div class="input-group mb-3">
                        <input class="email_bt" type="text" class="form-control" placeholder="Enter your email">
                     <div class="input-group-append">
                        <button class="subscribe_bt" class="btn btn-primary" type="Subscribe">Subscribe</button>  
                     </div>
                    </div>
    			</div>
    		</div>
    	</div>
    </div>
    <!-- section get in touch end -->

	<!-- section footer start -->
    <div class="section_footer">
    	<div class="container">
    		<div class="mail_section">
    			<ul>
    				<li class="footer-logo"><img src="images/footer-logo.png"></li>
    				<li class="footer-logo"><img src="images/map-icon.png"><span class="map_text">Gb road 123 london Uk</span></li>
    				<li class="footer-logo"><img src="images/call-icon.png"><span class="map_text">(+71) 9876543210</span></li>
    				<li class="footer-logo"><img src="images/email-icon.png"><span class="map_text">Demo@gmail.com</span></li>
    			</ul>
    	    </div> 
    	    <div class="footer_section_2">
		        <div class="row">
    		        <div class="col-sm-6 col-md-6 col-lg-3">
    		        	<h2 class="shop_text">About Pet Shop</h2>
    		        	<p class="dummy_text">Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and </p>
    		        </div>
    		        <div class="col-sm-6 col-md-6 col-lg-3">
    		        	<h2 class="shop_text">Useful Links</h2>
    		        	<div class="image-icon"><img src="images/bulit-icon.png"><span class="pet_text">Pet Dictionary</span></div>
    				    <div class="image-icon"><img src="images/bulit-icon.png"><span class="pet_text">Help Links</span></div>
    				    <div class="image-icon"><img src="images/bulit-icon.png"><span class="pet_text">Pet Attitudes</span></div>
    				    <div class="image-icon"><img src="images/bulit-icon.png"><span class="pet_text">Call a Doctor</span></div>
    				    <div class="image-icon"><img src="images/bulit-icon.png"><span class="pet_text">Help a Pet</span></div>
    		        </div>
    		        <div class="col-sm-6 col-md-6 col-lg-3">
    				    <h2 class="shop_text">Overview</h2>
    				    <div class="image-icon"><img src="images/bulit-icon.png"><span class="pet_text">Bacerim Dictionary</span></div>
    				    <div class="image-icon"><img src="images/bulit-icon.png"><span class="pet_text">Help Links</span></div>
    				    <div class="image-icon"><img src="images/bulit-icon.png"><span class="pet_text">bacerim Attitudes</span></div>    				
    		        </div>
    			<div class="col-sm-6 col-md-6 col-lg-3">
    				<h2 class="adderess_text">Instagram</h2>
    				<div class="footer-img">
    					<div class="row">
    						<div class="col-sm-6">
    							<div class="footer-img"><img src="images/footer-img1.png" style="width: 100%;"></div>
    							<div class="footer-img"><img src="images/footer-img2.png" style="width: 100%;"></div>
    						</div>
    						<div class="col-sm-6">
    							<div class="footer-img"><img src="images/footer-img3.png" style="width: 100%;"></div>
    							<div class="footer-img"><img src="images/footer-img4.png" style="width: 100%;"></div>
    						</div>
    					</div>
    				</div>
    			</div>
    			</div>
    	        </div>
    	        <div class="social-icon">
	        	    <div class="row">
	        		    <div class="col-sm-12">
	        			    <div class="icons">
	        				    <ul>
	        					    <li><a href="#"><img src="images/fb-icon.png"></a></li>
	        					    <li><a href="#"><img src="images/twitter-icon.png"></a></li>
	        					    <li><a href="#"><img src="images/google-icon.png"></a></li>
	        					    <li><a href="#"><img src="images/linkedin-icon.png"></a></li>
	        				    </ul>
	        			    </div>
	        		    </div>
	        	    </div>
	            </div>
	            <div class="copyright">2019 All Rights Reserved. <a href="https://html.design">Free html Templates</a></div>
	        </div>
    	</div>
    </div>
	<!-- section footer end -->

    <!-- Javascript files-->
    <script src="js/jquery.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
      <script src="js/jquery-3.0.0.min.js"></script>
      <script src="js/plugin.js"></script>
      <!-- sidebar -->
      <script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
      <script src="js/custom.js"></script>
      <!-- javascript --> 
      <script src="js/owl.carousel.js"></script>
      <script src="https:cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js"></script>
      <script>
      $(document).ready(function(){
      $(".fancybox").fancybox({
         openEffect: "none",
         closeEffect: "none"
         });
         
         $(".zoom").hover(function(){
         
         $(this).addClass('transition');
         }, function(){
         
         $(this).removeClass('transition');
         });
         });
         </script> 


   <script>
    function openNav() {
    document.getElementById("myNav").style.width = "100%";
    }

    function closeNav() {
   document.getElementById("myNav").style.width = "0%";
   }
</script>
     
</body>
</html>