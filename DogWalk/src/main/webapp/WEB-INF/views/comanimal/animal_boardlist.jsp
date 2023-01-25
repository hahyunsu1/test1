<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-material-datetimepicker/2.7.1/css/bootstrap-material-datetimepicker.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<%@ include file="/WEB-INF/include/import.jsp"%>
<script>
	function check(){
		if(!searchF.findType.value){
			alert('검색 유형을 선택하세요');
			return false;
		}
		if(!searchF.findKeyword.value){
			alert('검색어를 입력하세요');
			searchF.findKeyword.focus();
			return false;
		}
		return true;
	}
</script>
</head>

<div class="container" style="text-align:center">
<%-- <%@ include file="/WEB-INF/views/top.jsp"%> --%>
<%@ include file="/WEB-INF/include/header.jsp"%>
	<c:if test="${paging.findType ne null and paging.findType ne ''}">
		<h3 class="text- center text-secondary">검색어: <c:out value="${paging.findKeyword}"/></h3>
	</c:if>
	<div class="row py-3">
		<div class="col-md-9 text-center">
			<form name="searchF" action="animal_boardlist" onsubmit="return check()">
				<!-- hidden data---------------------------------------------  -->
				<input type="hidden" name="pageSize" value="${pageSize}">
				<input type="hidden" name="cpage" value="${paging.cpage}">
				<!-- --------------------------------------------------------  -->
				<select name="findType" style="padding:7px;">
					<option value="">:::검색 유형:::</option>
					<option value="1" <c:if test="${paging.findType eq 1}">selected</c:if>>글제목</option>
					<option value="2" <c:if test="${paging.findType eq 2}">selected</c:if>>작성자</option>
					<option value="3" <c:if test="${paging.findType eq 3}">selected</c:if>>사례비</option>
				</select>
				<input type="text" name="findKeyword" placeholder="검색어를 입력하세요" autofocus="autofocus" 
				style="width:50%;padding:5px;">
				<button class="btn btn-outline-primary">검 색</button>		
			</form>
		</div>
		<div class="col-md-3 text-right">
			<form name="pageSizeF" action="animal_boardlist">
				<!-- hidden data---------------------------------------------  -->
				<input type="hidden" name="findType" value="${paging.findType}">
				<input type="hidden" name="findKeyword" value="${paging.findKeyword}">
				<input type="hidden" name="cpage" value="${paging.cpage}">
				<!-- --------------------------------------------------------  -->
				<select name="pageSize" style="padding:7px;" onchange="submit()">
					<option value="">::페이지 사이즈::</option>
					<c:forEach var="ps" begin="5" end="20" step="5">
						<option value="${ps}" <c:if test="${pageSize eq ps}">selected</c:if>>페이즈 사이즈${ps}</option>
					</c:forEach>
				</select>
			</form>
		</div>
	</div>
	
	 <c:set var="myctx" value="${pageContext.request.contextPath}"/>
		<div class="row">
        <div class="col-md-12">
           <h1 class="text-center m-4" style="margin:1em">::돌봄 매칭게시판:::</h1>
           
           <table class="table table-striped" id="Animal">
              <thead>
                 <tr> 
                 	<th>글번호</th>                   
                    <th>반려견품종</th>
                    <th data-sort="string">제목</th>
                    <th colspan="2">이미지</th>
                    
                    <th data-sort="string">사례비</th>
                    
                 </tr>
              </thead>
              <tbody>
              <!-- ------------------------ -->
              <c:if test="${ambArr eq null or empty ambArr}">
              	<tr>
              		<td colspan="6">등록된 상품이 없습니다</td>
              	</tr>
              	
             </c:if>
             <c:if test="${ambArr ne null and not empty ambArr}">
             	<c:forEach var="amb" items="${ambArr}">
	                 <tr>   
	                    <td>${amb.cnum}</td>
	                    <td>
	                    ${amb.pet}				
	                    </td>
	                    <td>${amb.title}</td>
	                    <td width="15%" colspan="2">
	                    <a href="view/<c:out value="${amb.cnum}"/>" target="_blank">
	                   		<img src="../resources/animal_board_images/${amb.filename}" 
	                   		style="width:90%;margin:auto" class="img=fluid">
	                    </a>
	                    </td>
	                                        
	                    <td>	                    
	                    <b class="text-primary">사례비 :
	                    	<fmt:formatNumber value="${amb.price}" pattern="###,###"/>
	                    원</b><br>	                    
	                    </td>
	                    
	                 </tr>
                 </c:forEach>
                </c:if>	
                 
            <!-- ------------------------ -->                 
              </tbody>
              <tfoot>
			<tr>
				<th><a href="${myctx}/comanimal/comanimalwrite">글쓰기</a><a href="${myctx}/comanimal/animal_boardlist">/검색리셋</a></th>
				<td colspan="3" class="text-center">
				${pageNavi}
				</td>				
				<td colspan="2" class="text-right">
					총 게시글수: <c:out value="${paging.totalCount}"/><br>
					<span class="text-danger"><c:out value="${paging.cpage}"/></span> / <c:out value="${paging.pageCount}"/>
				</td>
			</tr>
			
		</tfoot>
           </table>
        </div>
      </div>
		
	</div>
<%@ include file="/WEB-INF/include/footer.jsp"%>