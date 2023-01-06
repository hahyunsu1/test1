<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <c:import url="/animal/top"/>
<%
   String ctx = request.getContextPath();
%>


<title>돌봄서비스 신청</title>
<p>
      <a href="<%=ctx%>/comanimal/comanimalwrite">글쓰기</a>| <a
         href="<%=ctx%>/comanimal/animal_boardlist">글목록</a>
      <p>
<form name="bf" id="bf" role="form" action="comanimalwrite" method="POST" enctype="multipart/form-data">
   <input type="hidden" name="mode" value="write">
   <!-- 원본글쓰기mode는 write, 답변글쓰기 mode는 rewrite로 감  -->       
    <table class="table">
       <tr>
          <td style="width:20%"><b>제목</b></td>
          <td style="width:80%">
          <input type="text" name="title" id="title" class="form-control">
          </td>
       </tr>
        <tr>
          <td style="width:20%"><b>반려동물 종입력</b></td>
          <td style="width:80%">
          <input type="text" name="pet" id="pet" class="form-control">
          </td>
       </tr>
       <tr>
          <td style="width:20%"><b>돌봄비 입력</b></td>
          <td style="width:80%">
          <input type="text" name="price" id="price" class="form-control">
          </td>
       </tr>
       <tr>
          <td style="width:20%"><b>글쓴이</b></td>
          <td style="width:80%">
          <input type="text" name="nick_fk" id="nick_fk" class="form-control">
          </td>
       </tr>       
       <tr>
          <td style="width:20%"><b>글내용</b></td>
          <td style="width:80%">
          <textarea name="content" id="content" rows="10" cols="50"
                  class="form-control"></textarea>
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
         <input type="file" name="mfilename"
            id="filename" class="form-control"></td>
      </tr>
      <tr>
         <td colspan="2">
            <button type="submit" id="btnWrite" class="btn btn-success">글쓰기</button>
            <button type="reset" id="btnReset" class="btn btn-warning">다시쓰기</button>
         </td>
      </tr>
   
      </table>
   

</form>       

</div>

<c:import url="/animal/foot"/>