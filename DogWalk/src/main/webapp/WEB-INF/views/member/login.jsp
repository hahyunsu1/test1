<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>	

    <title>로그인</title>
    <%@ include file="/WEB-INF/include/import.jsp"%>
     
    <style type="text/css">

		#area {
			/* box-shadow: rgba(0, 0, 0, 0.08) 0px 20px 40px 0px; */
			padding-top: 30px;
			padding-bottom: 40px;
			text-align: center;
			/* background-color: #fafafa; */
		}
		 
		ul {
			list-style: none;
			padding: 0;
		}
		
		#signUpList li {
			width: 300px;
			height: 50px;
			margin-bottom: 6px;
			border: 1px solid #e0e0e0;
			border-radius: 3px;
			font-size: 14px;
		}

		
		.span {
			box-sizing: border-box;
			width: 200px;
			height: 40px;
			padding-top: 3px;
			display: inline-block;
			padding-top: 13px;
		}
		
		#signUpList-wrapper {
			/* margin: 0 auto; */
			display: inline-block;
			margin-top: 16px;
		}

		#login-btn {
			padding: 19px 0 26px 19px;
		}

		#socialLoginBox {
			text-align: center;
		}

		
	</style> 
    <script
	  src="https://code.jquery.com/jquery-3.4.1.js"
	  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	  crossorigin="anonymous">
	 </script>
     
</head>

<body>

	<%@ include file="/WEB-INF/include/header.jsp"%>

	<div class="container">
		<div class="side_overlay">
			<div class="row">
				<div class="col-4"></div>
				<div class="col-4" style="margin-top: 50px;">
					<div class="card card-login">
						<form id="login_form" method="post">
							<div class="card-header card-header-primary text-center" style="margin-bottom: 52px;">
								<h4 class="card-title">Login</h4>
							</div>
							<div class="card-body">
								<span class="bmd-form-group">
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text">
												<i class="material-icons">mail</i>
											</span>
										</div>
										<input type="text" id="userid" class="form-control" placeholder="아이디" name="userid">
									</div>
								</span>
								<span class="bmd-form-group">
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text">
												<i class="material-icons">lock_outline</i>
											</span>
										</div>
					                  	<input type="password" id="pwd"" class="form-control" placeholder="비밀번호" name="pwd"/>
					                </div>
								</span>
								
								<c:if test = "${result == 0 }">
									<div class = "login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
								</c:if>
								<div class="text-center" id="login-btn">
									<input type="button" class="btn btn-primary" name="login_button" id="login_button" value="로그인">
								</div>
							</div>
							<div id="socialLoginBox">
								<h6>또는</h6>
								<!-- <div id="area" class=""> -->
									<div id="signUpList-wrapper">
										<ul id="signUpList">
											<a href="${naver_url}"><li style="border: 1px solid #19ce60"><span class="span">네이버 아이디로 로그인</span></li></a>
										</ul>
										<br>
									</div>
								
							</div>
							
						</form>
									
					</div>
				</div>
				<div class="col-4"></div>
			</div> <!-- /.row -->
		</div> <!-- /.side_overlay -->
	</div> <!-- /.container -->


	<%@ include file="/WEB-INF/include/footer.jsp"%>
	<script>
 
//로그인 버튼 클릭
$("#login_button").click(function() {
	const userid = $('#userid').val();
    const pwd = $('#pwd').val();
	const userinfo={
		"userid" : userid,
		"pwd" : pwd
	};
	console.log("userinfo"+JSON.stringify(userinfo));
	$.ajax({
		type : 'post',
		url : '<c:url value="/member/login" />',
		data : "userid="+userid+"&pwd="+pwd,
		dataType : "text",					
		success : function(data) {
			if (data == "drop") {
				alert(userid + '님은 추방된 회원입니다. 관리자에게 문의 해주세요.')
			}else if(data=="pwdError"||data=="idError"){
				//로그인 메서드 서버 요청
				alert("아이디 또는 비밀번호를 확인하세요");
				
				$('#userid').val('');
				$('#pwd').val('');
				$('#userid').focus();
			}else if(data=='ok'){
				alert(userid+"님 반갑습니다");
				location.href="/web/index"
			}
		},
		error:function(err){
			alert(err.responseText)
		}
	});

	
	
});
 
</script>
</body>
</html>