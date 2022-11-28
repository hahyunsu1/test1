<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/top"/>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

<head>

</head>
<body>


<div class="container">
<c:if test="${userArr eq null or empty userArr}">
	<script>
		alert('없는 회원입니다');
		history.back();
	</script>
</c:if>
<c:if test="${userArr ne null and not empty userArr}"> 
<form name="frm" action="/admin/userEdit" method="post">
	
	<h2>회원정보 수정(일단 세개만)</h2>
	<table class="table table-bordered mt-3">
	
		<tr>
			<td>${userArr.idx}</td>
			<td>${userArr.name}</td>
			<td>${userArr.hp1}</td>
			<td>${userArr.hp2}</td>
			<td>${userArr.hp3}</td>
			<td>${userArr.post}</td>
			<td>${userArr.addr1}</td>
			<td>${userArr.addr2}</td>
			
		</tr>
			
	
	</table>
	
	</form>
	</c:if>
</div>
</body>
<c:import url="/foot"/>