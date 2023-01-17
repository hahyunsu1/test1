<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<html>
<head>

<title>쪽지</title>

<%@ include file="/WEB-INF/include/import.jsp"%>
<!-- socketjs/stomp참조-------------------------------------------------  -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<!-- -------------------------------------------------------------- -->

</head>
<script type="text/javascript">
 $(document).ready(function() {
	connect();
	 //console.log(webSocket);
	 $('#sendQna').click(function() { 
		 
		 sendQna(); });
 })

var socket=null;
	var webSocket=null;

function connect() {
	webSocket=new SockJS("http://localhost:9090/web/alarm");
	
	webSocket.onopen = onOpen;
	webSocket.onmessage = onMessage;
	webSocket.onclose = onClose;
}
function disconnect() {
	webSocket.close();
}

function onOpen(evt) {
	console.log("onOpen(evt)");
}

function onMessage(evt) {
	console.log("evt :" + evt);
	var data = evt.data;
	appendMessage(data);
}

function onClose(evt) {
}

function send() {
	
	
	webSocket.send("login");
	
}

function appendMessage(msg) {
	console.log(msg);
	alert("msg : " + msg);
}
 


function sendQna() {
	/* let qna_brd_title = $('#qna_brd_title').val();
	let qna_brd_content = $('#qna_brd_content').val();
	let user = "새로운 문의가 도착했습니다."; */
	
	var text = "새로운 문의가 도착했습니다.";
	var msg = {"type" : "member",
				"ruserid" : $('#ruserid').val(),
				"content" : $('#content').val(),
				"text" : text
				};
	
	/* 
	webSocket.send(qna_brd_title + "," + qna_brd_content + "," + user); */
	webSocket.send(JSON.stringify(msg));
	$('#ruserid').val('');
	$('#content').val('');

	alert("성공!", "등록 되었습니다.", "success");
	setTimeout(function() {
		  location.href="rPage.bit";
		}, 1000);

	
	
}


</script>
<body>

	


	<div class="side_overlay">
		<div class="container">


			<button class="btn btn-primary btn-round"
				onclick="location.href='rPage.bit'">쪽지</button>


			
			<div class="card card-nav-tabs">
				<div class="card-header card-header-primary">
					<!-- colors: "header-primary", "header-info", "header-success", "header-warning", "header-danger" -->
					<div class="nav-tabs-navigation">
						<div class="nav-tabs-wrapper">
							<ul class="nav nav-tabs" data-tabs="tabs">
								<li class="nav-item"><a class="nav-link"
									onclick="location.href='rPage.bit'" data-toggle="tab"> <!-- <i class="material-icons">face</i> -->
										<i class="material-icons">email</i> 받은 쪽지함
										</a></li>
								<li class="nav-item"><a class="nav-link" onclick="location.href='sPage.bit'"
									data-toggle="tab"> <!-- <i class="material-icons">chat</i> -->
										<i class="material-icons">email</i> 보낸 쪽지함
										</a></li>
								<li class="nav-item"><a class="nav-link active show" onclick="location.href='write.bit'"
									data-toggle="tab"> <!-- <i class="material-icons">build</i> -->
										<i class="material-icons">email</i> 쪽지 쓰기
										</a></li>
							</ul>
						</div>
					</div>
				</div>

				<div class="card-body">
				
					<div class="tab-content text-center">
					<div class="row justify-content-center">
						<!---------- 쪽지쓰기 ------------------>
						<div class="tab-pane active show" >

							<!--  <form action="write.bit" method="post"> -->
								<div class="form-group bmd-form-group">
									<label for="bmd-label-static">받는 사람</label> 
									<input type="text" name="ruserid" id="ruserid" class="form-control" placeholder="받는사람 닉네임(아이디)"> 
								</div>
								
									   <textarea name="content" id="content" class="form-control"  rows="10" placeholder="여기에 쪽지 내용을 입력합니다"></textarea>
								
							<div class="border-top">
									<div class="card-body" style="text-align: center;">
										<button type="submit" id="sendQna" class="btn btn-primary"><b>쪽지보내기</b></button>
										<button type="reset" class="btn btn-primary">취소</button>
								</div>
							</div>
					<!-- </form> -->



						</div>


						<!-------------- 끝 ---------------->
						</div>

					</div>
				</div>
			</div>

		</div>
		<!-- container end -->
	</div>
	<!-- side_overlay end -->
	<%@ include file="/WEB-INF/include/footer.jsp"%>

</body>
</html>

