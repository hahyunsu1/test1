<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js">
</script>

<div class="container mt-3" style="height: 600px;overFlow:auto;">
	<h1 class="text-center">animal_Board  내용 보기</h1>
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
               <td width="30%"><c:out value="${amb.nick_fk}"/></td>
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
               ${amb.content}
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
                     <%-- <a href="${pageContext.request.contextPath}/resources/spring_board_images/${board.filename}" download> --%> 
                     <a href='#' onclick="down()">
                     ${amb.originFilename}
                     </a> [ <c:out value="${amb.filesize}"/> bytes]  
            		 </c:if>
            		<c:set var="fname" value="${fn:toLowerCase(amb.filename)}"/>
            		<!-- 파일명의 확장자를 검사하기 위해 모두 소문자로 바꾼다 -->
            		<c:if test="${fn:endsWith(fname,'.jpg') or fn:endsWith(fname,'.png') or fn:endsWith(fname,'.gif') }">
                        <img width="80px" class="img img-thumbnail"
                           src="${pageContext.request.contextPath}/resources/animal_board_images/${amb.filename}">
                    </c:if>
               </td>
            </tr>
            <tr>
               <td colspan="4" align=center><a href="../write">글쓰기</a>| <a
                  href="../list">목록</a>| <a href="#" onclick="go(1)">편집</a>| <a
                  href="#" onclick="go(2)">삭제</a>|</td>
            </tr>
       	    <%--  <div class="buy_chat">
				<form:form id="chatSubmit_form" action="/chatMessage" method="GET" modelAttribute="chatRoom">
					<a href="javascript:{}" onclick="chatSubmit()">
						<form:input type="hidden" path="sellerName" value="${nick_fk}"/>
						<form:input type="hidden" path="cnum" value="${amb.cnum}"/>
						<form:input type="hidden" path="sellerId" value="${amb.mail_fk}"/>
						<form:input type="hidden" path="pr_title" value="${amb.title}"/>
						<button id="btn_chat">
							채팅으로 거래하기
						</button>
					</a>
				</form:form>
			</div> --%>
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
</script>

<c:import url="/foot"/>