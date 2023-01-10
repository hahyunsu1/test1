<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html>
<head>

<title>쪽지</title>

<%@ include file="/WEB-INF/include/import.jsp"%>
<!-- socketjs/stomp참조-------------------------------------------------  -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<!-- -------------------------------------------------------------- -->
<script type="text/javascript">



 </script>
</head>
<script type="text/javascript">

 $(document).ready(function() {
	connect();
	$('#sendQna').click(function() { 
		 
		 sendQna(); });
	 console.log('알유저아이디: '+$('#ruserid').val());
 });
 var socket=null;
	var webSocket=null;

function connect() {
	webSocket=new SockJS("http://localhost:9090/web/alarm");
	
	webSocket.onopen = onOpen;
	webSocket.onmessage = onMessage;
	webSocket.onclose = onClose;
	//webSocket.send=
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
	
	var text = "새로운 문의가 도착했습니다.";
	var msg = {"type" : "user",
				"ruserid" : $('#ruserid').val(),
				"content" : $('#content').val(),
				"text" : text
				};
	console.log('여기타니니니니니니닝');
	
	webSocket.send(JSON.stringify(msg));
	$('#ruserid').val('');
	$('#content').val('');

	alert("성공!", "등록 되었습니다.", "success");
	setTimeout(function() {
		location.href="popmain.bit";
		}, 1000);

	
	
}
 </script>


 
 
<body>


	<div class="side_overlay">
		<div class="container">
			<div class="card card-nav-tabs">
				<div class="card">
					<!-- colors: "header-primary", "header-info", "header-success", "header-warning", "header-danger" -->
					<div class="nav-tabs-navigation">
						<div class="nav-tabs-wrapper">
	
						</div>
					</div>
				</div>

				<div class="card-body">
				
					<div class="tab-content text-center">
					<div class="row justify-content-center">
						<!---------- 쪽지쓰기 ------------------>
						<div class="tab-pane active show" id="write">
							 <form action="popmain.bit" method="post">
								<div class="form-group bmd-form-group">
									<label for="bmd-label-static">받는 사람</label> 

									<input type="hidden" name="ruserid" id="ruserid" class="form-control" placeholder="받는사람 닉네임(아이디)" value="${param.ruserid }">									
									<input type="text" name="nick" class="form-control" placeholder="받는사람 닉네임(아이디)" value="${param.ruserid }" readonly>

								</div>
								
							  <textarea name="content" id="content" class="form-control"  rows="10" placeholder="여기에 쪽지 내용을 입력합니다"></textarea>
								
								<div class="border-top">
										<div class="card-body" style="text-align: center;">
											<button type="reset" class="btn btn">취소</button>
											<button type="submit" id="sendQna" class="btn btn-primary" onclick="sendQna()"><b>쪽지보내기</b></button>
											
									</div>
								</div>
							</form>
							
							
							
							
						</div>
			<!-------------- 끝 ---------------->
			</div>
					</div>
					
				</div>
			</div>
			
			
			
		</div>
		<!-- container end -->
	</div>
	
	
<!-- Modal -->
<script> 
function btn(){ 
	alert('쪽지를 보냈습니다.');
	
	//window.close();
} 
</script>

</body>
<%-- <script src="${pageContext.request.contextPath}/assets/js_2sotto/headerAndNavi.js"></script> --%>
</html>

