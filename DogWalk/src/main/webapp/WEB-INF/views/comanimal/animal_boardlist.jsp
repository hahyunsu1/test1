<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<div class="container" style="text-align:center">
	 <c:set var="myctx" value="${pageContext.request.contextPath}"/>
		<div class="row">
        <div class="col-md-12">
           <h1 class="text-center m-4" style="margin:1em">::Animal List:::</h1>
           
           <table class="table table-striped" id="Animal">
              <thead>
                 <tr>                    
                    <th>동물</th>
                    <th data-sort="string">제목</th>
                    <th>이미지</th>
                    <th data-sort="string">사례비</th>
                    <th><a href="${myctx}/comanimal/comanimalwrite">글쓰기</a>|삭제</th>
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
	                    <td>${amb.nick_fk}</td>
	                    <td width="15%">
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
	                    <td>
	                    <a href="javascript:edit('${amb.cnum}')">수정</a>|
	                    <a href="#" onclick="remove('${amb.cnum}')">삭제</a>
	                    </td>
	                 </tr>
                 </c:forEach>
                </c:if>	
                 
            <!-- ------------------------ -->                 
              </tbody>
              <tfoot>
			<tr>
				<td colspan="4" class="text-center">
				<c:forEach var="i" begin="1" end="${pageCount}">
					<a href='animal_boardlist?cpage=<c:out value="${i}"/>'><c:out value="${i}"/></a>
				</c:forEach>
				</td>
				<td colspan="2" class="text-right">
				총 게시글수: <c:out value="${totalCount}"/><br>
				cpage/pageCount				
				</td>
			</tr>
			
		</tfoot>
           </table>
        </div>
      </div>
		
	</div>
