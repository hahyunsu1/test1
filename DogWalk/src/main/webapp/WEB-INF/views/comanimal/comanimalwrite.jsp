<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%
   String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-material-datetimepicker/2.7.1/css/bootstrap-material-datetimepicker.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<%@ include file="/WEB-INF/include/import.jsp"%>
<style>
div#content {
    width: 300px;
    height: 200px;
    border: 1px solid #dcdcdc;
    overflow-y: auto;
}
</style>
</head>

<title>돌봄매칭 글쓰기</title>

<form name="bf" id="bf" role="form" action="comanimalwrite" method="POST" enctype="multipart/form-data">
   <input type="hidden" name="mode" value="write">
   <!-- 원본글쓰기mode는 write, 답변글쓰기 mode는 rewrite로 감  -->       
    <table class="table">
       <tr>
          <td style="width:20%"><b>제목</b></td>
          <td style="width:50%">
          <input type="text" name="title" id="title" class="form-control">             
          <input type="hidden" name="userid" id="userid" class="form-control" value="${sessionScope.member.userid}" readonly>
          <input type="hidden" name="nick" id="nick" class="form-control" value="${sessionScope.member.nick}" readonly>
          </td>
       </tr>
        <tr>
          <td style="width:20%"><b>반려동물 종입력</b></td>
          <td style="width:50%">
          <input type="text" name="pet" id="pet" class="form-control">
          </td>
       </tr>
       <tr>
          <td style="width:20%"><b>돌봄비 입력</b></td>
          <td style="width:50%">
          <input type="text" name="price" id="price" class="form-control">
          </td>
       </tr>
           
       <tr>
          <td style="width:20%"><b>글내용</b></td>
          <td style="width:50%">
          <div contenteditable="true" name="content" id="content" class="form-control">
          
          </div>
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
         <td style="width: 20%"><b>반려견이미지 등록</b></td>
         <td style="width: 80%">
         <input type="file" name="mfilename" onchange="readURL(this);"
            id="filename" class="form-control">                
            </td>
            <td>
            <img id="img" name="petimg" src="../assets/images/pet_profile.jpg" alt="" width="150px"
										height="150px" style="border-radius: 10px;" />
            </td>
      </tr>
      <tr>
         <td colspan="2">
            <button type="submit" id="btnWrite" class="btn btn-success">글쓰기</button>
            <button type="reset" id="btnReset" class="btn btn-warning">다시쓰기</button>
         </td>
      </tr>
   
      </table>
   

</form>
<script>
$('#content').each(function(){
    this.contentEditable = true;
});

function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('#img').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
	$('#imgFileName').html(input.files[0].name);
};
</script>