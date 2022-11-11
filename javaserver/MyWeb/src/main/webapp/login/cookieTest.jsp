<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, java.text.*"%>
<jsp:include page="/top.jsp" />
<div class="container">
<%
/*사용자의 간단한 정보들은 쿠키에 저장할 수 있다.
이 때 쿠키는 클라이언트 쪽 메모리나 파일로 저장된다.
1. 쿠키 저장 단계
	[1] 쿠키 생성 단계 (key, value)
	[2] 쿠키 속성 설정 단계 (유효시간, 도메인, 경로 등...)
	[3] 쿠키 전송 단계 => response에 쿠키를 포함시켜서 클라이언트 쪽으로 전송한다.
2. 쿠키 꺼내는 단계
	=> request에 포함되어 있는 쿠키를 꺼내 활용한다.
*/
	//[1] ㅋ키 생성 단계 (key,value)
	//쿠키에 저장할 key,value 값에는 특수문자,한글, 공백,-,;,콤마(,) 등은 저장할 수 없다.
	Cookie ck1=new Cookie("visitId","swan");
	Date d=new Date();
	SimpleDateFormat sdf=new SimpleDateFormat("yyymmdd_hh:mm:ss");
	String visitTime=sdf.format(d);
	Cookie ck2=new Cookie("visitTime", visitTime);
	//[2] 쿠키 속성 설정 단계(유효시간,도메인,경로 등...)
	ck1.setMaxAge(60*60*24*3);//3일간 유효
	ck2.setMaxAge(60*60*24*7);//7일간 유효
	//setMaxAge()로 expiry(유효기간)을 설정한다.0갑을 주면 쿠키는 자동으로 삭제된다.=>ck1.setMaxAge(0)
	ck1.setPath("/");//경로설정
	//[3] 쿠키 전송 단계
	response.addCookie(ck1);
	response.addCookie(ck2);
%>
<h2>쿠키 저장 완료!!</h2>
<h2><a href="cookieList.jsp">쿠키 목록 보러 가기</a></h2>
</div>
<jsp:include page="/foot.jsp" />