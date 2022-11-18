<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String myctx = request.getContextPath();
%>
<style>
	.mydiv{
		width:80%;
		margin:auto;
		padding:1em;
		height:120px;
		background-color: #efefef;
		display:table;
	}
	.mycell{
		text-align: center;
		width: 100%;
		height: 100%;
		display: table-cell;
		vertical-align: middle;
		font-size: 13px;
	}
</style>
</article>
<!-- 사이드 영역---------------------------- -->
<aside>
	<!-- 사이드
		request에 저장한 값=> requestScope.key
		session에 저장한 값=> sessionScope.key
		${key}
	 -->
	<nav>
		<c:if test="${sessionScope.loginUser!=null}">
			<div class="mydiv">
				<div class="mycell">
					<h3>${loginUser.name}[${loginUser.userid}]</h3>
					<h3>로그인 중...</h3>
					<h4><a href="${pageContext.request.contextPath}/logout.do">로그아웃</a></h4>
				</div>
			</div>
		</c:if>
	</nav>
</aside>
<div class="clear"></div>

<footer> &copyCopyrigh/회사소개 </footer>
</div>
<!--  div#wrap. container end -->
</body>
</html>