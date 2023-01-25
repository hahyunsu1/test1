<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
<script
	src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin_user.css">
<title>어드민 회원관리</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"
	integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"
	integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>


<body>
	<%@include file="../admin_include/admin_header.jsp"%>

	<div class="member">
		<div class="member_title">
			<h2>회원관리</h2>
		</div>
		<br>
		<nav></nav>
		<div class="member_list">
			<table class="admin_board_wrap" id="user-admin">
				<thead class="admin_boardList">
					<th class="admin_board_head">이름</th>
					<th class="admin_board_head">아이디</th>
					<th class="admin_board_head">닉네임</th>
					<th class="admin_board_head">가입일</th>
					<th class="admin_board_head">게시글수</th>
					<th class="admin_board_head">회원상태</th>
					<th class="admin_board_head" colspan="2" >상태변경</th>
				</thead>
				<tbody>
					<c:forEach var="vo" items="${userinfo}">
						<tr class="admin_board_content">
							<td class="admin_board_content_nm">${vo.name}</td>
							<td class="admin_board_content_nm"><a
								class="mypageModal user_id" value="${vo.userid}">${vo.userid}</a>
							</td>
							<td class="admin_board_content_nm">${vo.nick}</td>
							<td class="admin_board_content_nm">${vo.indate}</td>
							<td class="admin_board_content_nm"><a href="#"
								class="modal_boardList_admin" data-userid="${vo.userid}">${vo.board_cnt}</a></td>
							<td class="admin_board_content_nm"><c:choose>
									<c:when test="${vo.status== 0}">일반회원</c:when>
									<c:when test="${vo.status== 1}">정지회원</c:when>
									<c:when test="${vo.status== 2}">추방회원</c:when>
									<c:when test="${vo.status== 3}">탈퇴회원</c:when>
									<c:when test="${vo.status== 99}">관리자</c:when>
								</c:choose></td>
							<c:choose>
								<c:when test="${vo.status == 0}">
									<td class="admin_board_content_nm">
										<button data-userid="${vo.userid}" type="button" value="승인"
											class="userDrop">회원 추방</button>
									</td>
									<td class="admin_board_content_nm">
										<button data-userid="${vo.userid}" type="button" value="승인"
											class="#">회원 정지</button>
									</td>
								</c:when>
								<c:when test="${vo.status == 1}">
								<td class="admin_board_content_nm">
										<button data-userid="${vo.userid}" type="button" value="승인"
											class="userDrop">회원 추방</button>
									</td>
									<td class="admin_board_content_nm">
										정지된 회원입니다.
									</td>
								</c:when>
								<c:when test="${vo.status == 2 || vo.status == 99 || vo.status == 3}">
								<td class="admin_board_content_nm" colspan="2" style="color:gray">
									추방이 불가능한 회원입니다.
									</td>
								</c:when>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<!-- 회원관리 모달 -->
	<div class="mypage_modal">
		<div class="service_box">
			<div class="mem_box_inner">
				<div class="mypage">

					<!-- <div class="service_title_outline"><span class="service_title">회원관리</span></div> -->
					<div class="mypage_form">
						<h3 class="memInfo"></h3>
						<div class="line"></div>
						<div class="insert">
							<!--이름-->
							<div class="name_box">
								&nbsp;&nbsp;
								<p>이름</p>
								<input type="text" name="name" readonly value="홍길동"><br>
							</div>
							<!--아이디-->
							<div class="id_box">
								&nbsp;&nbsp;
								<p>아이디</p>
								<input type="text" name="userid" readonly value="abc1234"><br>
							</div>
							<!--전화번호-->
							<div class="addr_box">
								&nbsp;
								<p>주소</p>
								<input type="text" name="post" readonly><br> <input
									type="text" class="addr addr2" name="addr1" readonly><br>
								<input type="text" class="addr addr3" name="addr2" readonly>
							</div>
							<!--주소-->
							<div class="tel_box">
								&nbsp;
								<p>닉네임</p>
								<input type="text" name="nick" readonly>

							</div>
							<!--현재 상태 구분-->
							<div class="job_box">
								&nbsp;
								<p>메일</p>
								<input type="text" name="post" readonly><br>
							</div>

						</div>
						<div class="close_btn">
							<button class="close">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal_list">
		<div class="modal_boradlist">
			<div class="reply_listWrap">

				<div class="modal_wrap">
					<h3 id="ListName"></h3>
					<p class="modallist">작성한 게시글 수 : 총 01개</p>
					<table class="admin_boardM_wrap" id="comment-admin">
						<thead class="admin_boardMList">
							<th class="admin_boardM_title">글 번호</th>
							<th class="admin_boardM_title">동물</th>
							<th class="admin_boardM_title boardleng">제목</th>
							<th class="admin_boardM_title">작성일</th>
							<th class="admin_boardM_title">조회수</th>
						</thead>
						</tbody>
						<tbody id="getBoardList">
							<!-- 게시글이 들어갈 공간 -->
						</tbody>
					</table>


					<div class="close_modal_btn">
						<button class="modal_list_end_btn">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script>
		// 마이페이지 모달
		$('.mypageModal').click(function() {
			$('.mypage_modal').fadeIn(500);
			var userid = $(this).attr('value');
			console.log(userid);
			// 아이디 값 불러옴 

			$.ajax({
				type : 'post',
				url : '<c:url value="/admin/getuserInfo" />',
				data : {
					userid : userid,
				},
				dataType : "json",
				success : function(data) {
					console.log(data.name);
					console.log(data.userid);
					$("input[name='name']").val(data.name);
					$("input[name='userid']").val(data.userid);
					$("input[name='post']").val(data.post);
					$("input[name='addr1']").val(data.addr1);
					$("input[name='addr2']").val(data.addr2);
					$("input[name='nick']").val(data.nick);
					$("input[name='mail']").val(data.mail);
					$(".memInfo").html(data.name + "님의 회원 정보");
				},
				error : function(status, error) {
					console.log('에러발생!!');

					console.log(status, error);
				}

			})//ajax 종료
		});

		// 게시판 모달
		$('.modal_boardList_admin').click(function() {
			var userid = $(this).data("userid");
			console.log(userid);

			getList(true, userid);
			$('.modal_list').fadeIn(500);
		}); // open modal end

		function getList(reset, userid) {

			if (reset) {
				str = '';
			}

			$.ajax({
				type : 'post',
				url : '<c:url value ="/admin/getUserBoardList"/>',
				data : {
					userid : userid,
				},
				dataType : "json",
				success : function(data) {
					alert(JSON.stringify(data))
					for ( var i = 1 in data) {
						console.log(data[i].title);
						str += "<tr class='admin_boardM_content'>"
						str += "<td class='admin_boardM_nm'><a href='#'>"
								+ data[i].cnum + "</a></td>"
						str += "<td class='admin_boardM_nm'><a href='#'>"
								+ data[i].pet + "</a></td>"
						str += "<td class='admin_boardM_nm'><a href='#'>"
								+ data[i].title + "</a></td>"
						str += "<td class='admin_boardM_nm'>" + data[i].wdate
								+ "</td>"
						str += "<td class='admin_boardM_nm'>" + data[i].cnt
								+ "</td>"
						str += "</tr>"
					}
					$('#ListName').html(userid + '님의 작성 게시물')
					$('#getBoardList').html(str);
					$("#comment-admin").DataTable();
				},
				error : function(status, error) {
					console.log('에러발생!!');
					console.log(status, error);
				}

			});//ajax 종료
		};
		$('.close').click(function() {
			$('.mypage_modal').fadeOut();
		});
		$('.modal_list_end_btn').click(function() {
			console.log('모달 닫기 이벤트 발생!');
			$('.modal_list').fadeOut();
		});
		
		  $('.userDrop').click(function() {
				
		    	  const userid = $(this).data("userid");
		        	console.log(userid);
		           	$.ajax({
		        		type : 'post',
		        		url : '<c:url value="/admin/dropId" />',
		        		data : {
		            		userid : userid
		            	},
		            	success : function(data){
		            	},error : function(status, error) {
		      				console.log('에러발생!!');
		      				
		      				console.log(status, error);
		      			}
		  }); //end ajax
		 });
	</script>