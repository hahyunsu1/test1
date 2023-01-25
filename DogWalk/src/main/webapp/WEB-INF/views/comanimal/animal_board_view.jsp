<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-material-datetimepicker/2.7.1/css/bootstrap-material-datetimepicker.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<%@ include file="/WEB-INF/include/import.jsp"%>

<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js">
</script>
<style>
div#content {
    width: 300px;
    height: 200px;
    border: 1px solid #dcdcdc;
    overflow-y: auto;
}
</style>
</head>
<script src ="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>

<div class="container" style="text-align:center">
<%@ include file="/WEB-INF/include/header.jsp"%>
	<div class="row">
        <div class="col-md-12">
	<c:if test="${amb eq null}">
		<div class="alert alert-danger my-5 text-center">
			<h4>존재 하지 않는 글입니다.</h4>
		</div>	
	</c:if>
	
	<c:if test="${amb ne null}">
		<table class="table mt-4">
            <tr>
               <td width="20%">글번호</td>
               <td width="30%"><c:out value="${amb.cnum}"/></td>
               <td width="20%">작성일</td>
               <td width="30%">
               <fmt:formatDate value="${amb.wdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
               </td>
            </tr>
            <tr>
               <td width="20%">글쓴이</td>
               <td width="30%"><c:out value="${amb.nick}"/></td>
               <td width="20%">조회수</td>
               <td width="30%"><c:out value="${amb.cnt}"/></td>
            </tr>

            <tr>
               <td width="20%">제목</td>
               <td colspan="3" align="left">
               <c:out value="${amb.title}"/>
               </td>
            </tr>
            <tr height="60">
               <td width="20%">글내용</td>
               <td colspan="3" align="left">
               <textarea name="content" id="content" rows="10" cols="50"
                  class="form-control" style="float:left;  width:49%;">${amb.content}</textarea>  
               
          		<c:if test="${amb.filename eq null}">
                <img id="img" name="petimg" src="../assets/images/pet_profile.jpg" alt="" width="200px"
										height="200px" style="border-radius: 10px; float:left;margin: 2px" />
				</c:if>
				<c:if test="${amb.filename ne null}">
                <img id="img" name="petimg"  src="${pageContext.request.contextPath}/resources/animal_board_images/${amb.filename}" alt="" width="200px"
										height="200px" style="border-radius: 10px; float:left;margin: 2px" />
				</c:if>
               </td>
            </tr>
            <tr height="60">
               <td width="20%">반려동물</td>
               <td colspan="3" align="left">
               ${amb.pet}
               </td>
            </tr>
            <tr height="60">
               <td width="20%">사례비</td>
               <td colspan="3" align="left">
               ${amb.price}
               </td>
            </tr>            
            <tr>
               <td width="20%">첨부파일</td>
               <td colspan="3">&nbsp; 
                     <!--  첨부파일이 있다면 -->
                     <c:if test="${amb.filename ne null}">
                    
                     <a href='#' onclick="down()">
                     ${amb.originFilename}
                     </a> [ <c:out value="${amb.filesize}"/> bytes]  
            		 </c:if>
            		<c:set var="fname" value="${fn:toLowerCase(amb.filename)}"/>            		
            		<c:if test="${fn:endsWith(fname,'.jpg') or fn:endsWith(fname,'.png') or fn:endsWith(fname,'.gif') }">
                        <img width="80px" class="img img-thumbnail"
                           src="${pageContext.request.contextPath}/resources/animal_board_images/${amb.filename}">
                    </c:if>
               </td>
            </tr>
            <tr>
               <td colspan="4" align=center>
				<c:if test="${sessionScope.member.userid != amb.userid}">
				
				<div class="col-9" style="margin-top:20px;">
							<span onclick='popupMessage("${amb.userid}")'
							style="cursor:pointer;">
								<i class="far fa-envelope"></i>
								<strong>${amb.nick}에게 쪽지보내기</strong>
							</span>
				</div>
				<div class ="btns">
					<input type="button" id="check1" value="사례비">						
				</div>
				</c:if>
               | <a href="../animal_boardlist">목록</a>| <a href="#" onclick="go(1)">편집</a>| <a
                  href="#" onclick="go(2)">삭제</a>|</td>
            </tr>
       	   
         </table>
	</c:if>
	<!-- 파일 다운로드를 위한 form------------------------------------------ -->
	<form name="fileF" id="fileF" method="post" action="../../fileDown">
		<input type="hidden" name="fname" value="<c:out value="${amb.filename}"/>">
		<input type="hidden" name="origin_fname" value="<c:out value="${amb.originFilename}"/>">
	</form>
	<!-- 편집 또는 삭제를 위한 form----------------------------------------- -->
	<form name="frm" id="frm">
		<input type="hidden" name="cnum" value="<c:out value="${amb.cnum}"/>">
		<input type="hidden" name="mode">
		<div class="row mt-4" id="divCpass" style="display: none">
			<div class="col-md-3 offset-md-1 text-right mr-2">
				<label for="cpass">글 비밀번호</label>
			</div>
			<div class="col-md-4">
				<input type="password" name="cpass" id="cpass" class="form-control" placeholder="Password" required>
			</div>
			<div class="col-md-3 text-left mr-2">
				<button id="btn" class="btn btn-outline-primary"></button>
			</div>
		</div>
	</form>
	<!-- 답변달기 form시작 ---------------------------------------------------->
	<form name="ref" id="reF" action="../rewrite" method="post">
		<!-- hidden으로 부모글의 글번호(num)와 제목(subject)를 넘기자  -->
		<input type="hidden" name="cnum" value="<c:out value="${amb.cnum}"/>">
		<input type="hidden" name="title" value="<c:out value="${amb.title}"/>">
	</form>
	<!-- ------------------------------------------------------------------- -->
	</div>
      </div>
</div>

<script>
//파일 다운로드 처리
	function goRe(){
		reF.submit();
	}
	function down(){
		fileF.submit();
	}
	function go(flag){
		if(flag==1){
			frm.mode.value='edit';
			$('btn').text('글수정');
			$('#cpass').focus();
			frm.action='../edit';
			frm.method='post';
		}else if(flag==2){
			frm.mode.value='delete';
			$('btn').text('글삭제');
			$('#cpass').focus();
			frm.action='../delete';
			frm.method='post';
		}
		$('#divCpass').show(500);
	}
	function popupMessage(ruserid){

		//비로그인으로 접근 시
		if(${empty sessionScope.member}){
			swal('회원가입을 하고 ${pet.nick}에게 쪽지를 보내 보세요^^');
		}else{
		
			var popupX = (document.body.offsetWidth / 2) - (580 / 2);
			//만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
		
			var popupY= (window.screen.height / 2) - (700 / 2);
			//만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
		
			//window.open('${pageContext.request.contextPath}/message/write.bit','_blank',
			window.open('${pageContext.request.contextPath}/message/popmain.bit?ruserid='+ruserid+'&nick=${amb.nick}','_blank',
			'width=580, height=700, left='+ popupX + ', top='+ popupY);
		}
		
	}
	$('#content').each(function(){
	    this.contentEditable = false;
	});

	$(document).ready(function(){
		   
		  
		   	  
			var IMP = window.IMP;			
			IMP.init('imp27573152');
			
			$("#check1").click(function(e){
				IMP.request_pay({ // param
		            pg: "kakaopay.TC0ONETIME",
		            pay_method: "card",
		            merchant_uid: 'cart_' + new Date().getTime(),
		            name: '${amb.title}',
		            amount: '${amb.price}',
		            buyer_email: '${member.mail}',
		            buyer_name: '${member.name}',

		        }, function (rsp) { // callback

		            /** 결제 검증 **/
		            $.ajax({
		                type: 'POST',
		                url: '/verifyIamport/'+rsp.imp_uid,
		                beforeSend: function(xhr){
		                    xhr.setRequestHeader(header, token);
		                }
		            }).done(function(result){

		                // rsp.paid_amount와 result.response.amount(서버 검증) 비교 후 로직 실행
		                if(rsp.paid_amount === result.response.amount){
		                    alert("결제가 완료되었습니다.");
		                    $.ajax({
		                        type:'POST',
		                        url:'/lecture/payment',
		                        beforeSend: function(xhr){
		                            xhr.setRequestHeader(header, token);
		                        }
		                    }).done(function() {
		                        window.location.reload();
		                    }).fail(function(error){
		                            alert(JSON.stringify(error));
		                    })
		                } else{
		                    alert("결제에 실패했습니다."+"에러코드 : "+rsp.error_code+"에러 메시지 : "+rsp.error_message);

		                }
		            })
		        });
				
			}); //check1 클릭 이벤트
			
		}); //doc.ready

	</script>
<%@ include file="/WEB-INF/include/footer.jsp"%>