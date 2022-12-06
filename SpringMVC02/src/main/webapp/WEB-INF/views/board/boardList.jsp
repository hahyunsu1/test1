<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:import url="/top"/>
<style>
#boardBody>tr>td:nth-child(2n+2){
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
</style>
<div class="container mt-3" style="height: 600px;overFlow:auto;">
	<h1 class="text-center">Spring Board</h1>
	<p class="text-center my-4">
		<a href="write">글쓰기</a><a href="list">글목록</a>
	</p>

<!-- 검색 폼 시작----------------------------- -->
	
	<!-- -------------------------------------- -->
	<!--c:out테그를 꼭 쓰자  -->
	<table class="table table-condensed table-striped">
		<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>글쓴이</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody id="boardBody">
		<c:if test="${boardArr eq null or empty boardArr}">
			<tr>
				<td colspan="3"><b>데이터가 없습니다.</b></td>
			</tr>
		</c:if>
		
		<c:if test="${boardArr ne null and not empty boardArr}">
			<c:forEach var="board" items="${boardArr}">
			<tr>
			
				<td>
					<c:out value="${board.num}"/><!--c:out테그를 꼭 쓰자  -->
					
				</td>
				<td class="sub">				
					<a href="view/<c:out value="${board.num}"/>">
					<c:if test="${fn:length(board.subject)>20 }">
						<c:out value="${fn:substring(board.subject,0,20)}"/>
					</c:if>
					<c:if test="${fn:length(board.subject)<=20 }">
						<c:out value="${board.subject}"/>
					</c:if>
					
					</a>
					<c:if test="${board.filesize>0}">
						<span class="float-right">
						<img src="../images/attach.jsp"  style='width:26px'
						title="<c:out value="${board.originFilename}"/>">
						</span>
					</c:if>
				</td>
				<td>
					<c:out value="${board.name}"/>
				</td>
				<td>
					<c:out value="${board.wdate}"/>
				</td>
				<td>
					<c:out value="${board.readnum}"/>
				</td>
			</tr>
			</c:forEach>
		</c:if>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="3" class="text-center">pageNavi</td>
				<td colspan="2" class="text-right">cpage/pageCount</td>
			</tr>
			
		</tfoot>
	</table>
</div>
<c:import url="/foot"/>