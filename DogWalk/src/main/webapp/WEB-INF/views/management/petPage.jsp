<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>

<title>동물관리 홈</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-material-datetimepicker/2.7.1/css/bootstrap-material-datetimepicker.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<%@ include file="/WEB-INF/include/import.jsp"%>

<style>
	.fc-toolbar-title, a.fc-col-header-cell-cushion, th {
		color: black;
	}
	
	.icons {
		font-size: 15px;
		color: orange;
	}
	
	#wrapper {
		display: inline-block;
		/* margin: 0 auto; */
	}
	
	.card-img-top {
		margin-top: 16px;
	}
	
	.card {
		margin-left: 10px;
		margin-right: 10px;
	}
	
	#tab-list {
		margin: 0 auto;
	}
	
	#tab-row {
		margin-bottom: 100px;
		margin-top: 73px;
	}
	
	.form-check {
		margin-left: 5px;
		margin-top: 8px;
	}
	
	.main-card {
			background-color: #ffffff;
 			box-shadow: rgba(0, 0, 0, 0.08) 0px 20px 40px 0px;
			padding: 30px;
			border-radius: 6px;	
	}
	

</style>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css_2sotto/blog_main.css">
</head>
<body>

	
	
	 
	<c:set value="${petInfoList2}" var="petInfo" />

	<div class="container">
		<div class="side_overlay">
			<div class="row main-card">
				<div class="col-3 text-center">
							<img class="card-img-top rounded-circle img-fluid img" style='width:150px; height:150px'
								src="${pageContext.request.contextPath}/assets/images/${petInfo.petimg}"
								rel="nofollow" alt="card image">
				</div>
				<div class="col-9">
					<h3>${petInfo.petname}</h3>
					<p class="card-text" id="petInfo">
						<fmt:parseNumber var="age" value="${petInfo.age/12}"
							integerOnly="true" />
						${petInfo.scaname} | ${petInfo.petsize == 'small' ? '소형':petInfo.petsize == 'medium'? '중형':'대형'}${petInfo.mcategory == '1' ? '견':'묘'}
						| ${petInfo.weight}kg | <br> ${age}년
						${petInfo.age%12}개월 | ${petInfo.sex == 'female' ? '암컷':'수컷' }
						| ${petInfo.nstate == 'n' ? '중성화X':'중성화O'} | <br>
						${petInfo.memo}
					</p>
					<c:if test="${sessionScope.member.userid eq petInfo.userid}">
						<div>
							
							<a href="../management/edit.bit?petindex=${petInfo.petindex}" class="btn btn-primary">수정</a>
							&nbsp;&nbsp;&nbsp;
						</div>
					</c:if>
				</div>
				<c:if test="${sessionScope.member.userid != petInfo.userid}">
				<div class="col-3 text-center" style="margin-top:20px;">
							<button class="btn btn-primary" id="unFollowBtn"> 언팔로우 </button>
							<button class="btn btn-primary" id="followBtn">	팔로우 </button>
				</div>
				<div class="col-9" style="margin-top:20px;">
							<span onclick='popupMessage("${petInfo.userid }")'
							style="cursor:pointer;">
								<i class="far fa-envelope"></i>
								<strong>${petInfo.petname}의 ${petInfo.mcategory eq "1"? "주인":"집사"} ${petInfo.nick}에게 쪽지보내기</strong>
							</span>
				</div>
				</c:if>
			</div>			

			<hr>
				

			
			<!-- 페이징 -->
			<div class="pagination justify-content-center">
			<!-- <nav aria-label="Page navigation example" style="display: none;" id="pagingNav"> -->
					<ul class="pagination" id="pagingview">
						<c:if test="${cpage > 1}">
							<li class="page-item">
								<a class="page-link" href="main.bit?cp=${cpage-1}&ps=${pageSize}" cp="${cpage-1}" ps="${pageSize}" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
									<span class="sr-only">Previous</span>
								</a>
							</li>
						</c:if>

						<c:forEach var="i" begin="1" end="${pageCount}" step="1">
							<c:choose>
								<c:when test="${cpage==i }">
									<li class="page-item active"><a class="page-link"
										href="main.bit?cp=${i}&ps=${pageSize}" cp="${i}"
										ps="${pageSize}">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link"
										href="main.bit?cp=${i}&ps=${pageSize}" cp="${i}"
										ps="${pageSize}">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${cpage < pageCount}">

							<li class="page-item">
								<a class="page-link" href="main.bit?cp=${cpage+1}&ps=${pageSize}"
									cp="${cpage+1}" ps="${pageSize}" aria-label="Next"> 
									<span aria-hidden="true">&raquo;</span>
									<span class="sr-only">Next</span>
								</a>
							</li>
						</c:if>
					</ul>
			
			</div>
		
		
		
		</div> <!-- side_overlay end -->
	</div>
	<!-- container end -->

<!-- Modal -->
	
<div class="modal" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">반려동물삭제</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        반려동물을 정말 삭제하시는건가요?
      </div>
      <div class="modal-footer">
  		<button onclick="Delete()" type="button" class="btn btn-primary">삭제하기</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
       	
      </div>
    </div>

  </div>
</div>
<!-- Modal -->	



	<%@ include file="/WEB-INF/include/footer.jsp"%>
</body>

<script>
<!-- Modal에서 삭제 -->
// 삭제 전 확인 창 띄우기
function Delete() {
    location.replace("../management/delete.bit?petindex=${petInfoList2.petindex}"); 
  }
<!-- Modal에서 삭제 --> 

$(function(){
	

	//팔로우/언팔로우 버튼 토글
	if(${petLike.petindex eq petInfoList2.petindex}){
		$('#followBtn').hide();
		console.log('팔로우');
	}else{
		$('#unFollowBtn').hide();
		console.log('언팔로우');
	}

});




//반려동물 팔로우 
$('#followBtn').click(function() {

	//비로그인으로 접근 시
	if(${empty sessionScope.member}){
		swal('회원가입을 하고 ${petInfoList2.petname}의 친구가 되어 보세요^^');
	}

	$.ajax({
		type : "POST",
		url : 'followPet.bit',
		datatype : 'json',
		data : {
			petindex: ${petInfoList2.petindex}
		},		
		cache:false,
		success : function(data) {
			console.log("data==="+JSON.stringify(data));
			if (data == 1) {

				$('#followBtn').hide();
				$('#unFollowBtn').show();
								
				return;
			} else {
				alert("문제가 생겨 팔로우 요청이 취소되었습니다.");

				return;
			}
		}
	});
});

//반려동물 언팔로우 
$('#unFollowBtn').click(function() {
	
	$.ajax({
		type : "POST",
		url : 'unFollowPet.bit',
		datatype : 'json',
		data : {
			petindex: ${petInfoList2.petindex} 
		},
		cache:false,
		success : function(data) {
			console.log("data==="+JSON.stringify(data));
			if (data == 1) {

				$('#unFollowBtn').hide();
				$('#followBtn').show();
								
				return;
			} else {
				alert("문제가 생겨 언팔로우 요청이 취소되었습니다.");

				return;
			}
		}
	});
	
});

function popupMessage(ruserid){

	//비로그인으로 접근 시
	if(${empty sessionScope.member}){
		swal('회원가입을 하고 ${petInfo.nick}에게 쪽지를 보내 보세요^^');
	}else{
	
		var popupX = (document.body.offsetWidth / 2) - (580 / 2);
		//만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	
		var popupY= (window.screen.height / 2) - (700 / 2);
		//만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	
		//window.open('${pageContext.request.contextPath}/message/write.bit','_blank',
		window.open('${pageContext.request.contextPath}/message/popmain.bit?ruserid='+ruserid+'&nick=${pet.nick}','_blank',
		'width=580, height=700, left='+ popupX + ', top='+ popupY);
	}
	
}


</script>
</html>