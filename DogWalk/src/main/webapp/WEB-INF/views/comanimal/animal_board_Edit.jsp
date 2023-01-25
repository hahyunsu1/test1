<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-material-datetimepicker/2.7.1/css/bootstrap-material-datetimepicker.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<%@ include file="/WEB-INF/include/import.jsp"%>
</head>  
<%
   String ctx = request.getContextPath();
%>

<%@ include file="/WEB-INF/include/header.jsp"%>
<title>돌봄매칭 글수정</title>
<div class="container" style="text-align:center">
<p>
      <a href="<%=ctx%>/comanimal/comanimalwrite">글쓰기</a>| <a
         href="<%=ctx%>/comanimal/animal_boardlist">글목록</a>
      <p>
<form name="bf" id="bf" role="form" action="comanimalwrite" method="POST" enctype="multipart/form-data">
   <input type="hidden" name="mode" value="edit">
   <input type="hidden" name="cnum" value="<c:out value="${amb.cnum}"/>">
   <!-- 원본글쓰기mode는 write, 답변글쓰기 mode는 rewrite로 감  -->       
    <table class="table">
       <tr>
          <td style="width:20%"><b>제목</b></td>
          <td style="width:80%">
          <input type="text" name="title" id="title" value='<c:out value="${amb.title}"/>' class="form-control">
          </td>
       </tr>
        <tr>
          <td style="width:20%"><b>반려동물 종입력</b></td>
          <td style="width:80%">
          <input type="text" name="pet" id="pet" value='<c:out value="${amb.pet}"/>' class="form-control">
          </td>
       </tr>
       <tr>
          <td style="width:20%"><b>돌봄비 입력</b></td>
          <td style="width:80%">
          <input type="text" name="price" id="price" value='<c:out value="${amb.price}"/>' class="form-control">
           <input type="hidden" name="nick" id="nick" value='<c:out value="${amb.nick}"/>' class="form-control">
          </td>
       </tr>
          
       <tr>
          <td style="width:20%"><b>글내용</b></td>
          <td style="width:80%">
          <textarea name="content" id="content" rows="10" cols="50"
                  class="form-control">${amb.content}</textarea>
          </td>
       </tr>
       <tr>
          <td style="width:20%"><b>비밀번호</b></td>
          <td style="width:80%">
          <div class="col-md-5">
          <input type="password" name="cpass" id="cpass" class="form-control">
          </div>
          </td>
      </tr>
      <tr>
         <td style="width: 20%"><b>첨부파일</b></td>
         <td style="width: 80%">
         <c:set var="fname" value="${fn:toLowerCase(amb.filename)}"/>
            	<!-- 파일명의 확장자를 검사하기 위해 모두 소문자로 바꾼다 -->
         <c:if test="${fn:endsWith(fname,'.jpg') or fn:endsWith(fname,'.png') or fn:endsWith(fname,'.gif') }">
              <img width="80px" class="img img-thumbnail"
                   src="${pageContext.request.contextPath}/resources/animal_board_images/${amb.filename}">
         </c:if>
        <c:out value="${amb.originFilename}"/>[<c:out value="${amb.filesize}"/> bytes]<br>
         <input type="file" name="mfilename" id="filename" class="form-control">
         <!-- 예전에 업로드한 파일명을 hidden으로 보내자 -->
         <input type="hidden" name="old_filename" value="<c:out value="${amb.filename}"/>">
         </td>
      </tr>
      <tr>
         <td colspan="2">
            <button type="submit" id="btnWrite" class="btn btn-success">글수정</button>
            <button type="reset" id="btnReset" class="btn btn-warning">다시쓰기</button>
         </td>
      </tr>
   
      </table>
   

</form>       
</div>
<%@ include file="/WEB-INF/include/footer.jsp"%>
