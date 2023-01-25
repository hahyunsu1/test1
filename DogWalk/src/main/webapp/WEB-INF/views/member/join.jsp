<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js">
</script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>

<%@ include file="/WEB-INF/include/import.jsp"%>
<%@ include file="/WEB-INF/include/header.jsp"%>
<div class="container">
	<h1 class="text-center mt-1">Signup</h1>
	<form name="mf" id="join_form" method="post">

		<table class="table">
			<tr>
				<td width="20%" class="m1"><b>이름</b></td>
				<td width="80%" class="m2">
				<input type="text" name="name" id="name" placeholder="Name"> 
				<span class="final_name_ck">이름을 입력해주세요</span>
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>아이디</b></td>
				<td width="80%" class="m2">
				<input type="text" name="userid" id="userid" placeholder="userid"> 
				<span class="id_input_re_1">사용 가능한 아이디입니다.</span> 
				<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
				<span class="final_id_ck" style="display:none;">아이디를 입력해주세요</span>
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>비밀번호</b></td>
				<td width="80%" class="m2"><input type="password" name="pwd" id="pwd" placeholder="Password">
				<span class="final_pw_ck" style="display:none;">비밀번호를 입력해주세요</span>
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>비밀번호 확인</b></td>
				<td width="80%" class="m2"><input type="password" name="pwd2" id="pwd2" placeholder="Re Password">
				<span class="final_pwck_ck">비밀번호 확인을 입력해주세요</span>
				<span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
                <span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>연락처</b></td>
				<td width="80%" class="m2">
				<input type="text" name="hp1" id="hp1" placeholder="HP1" maxlength="3">- 
				<input type="text" name="hp2" id="hp2" placeholder="HP2" maxlength="4">-
				<input type="text" name="hp3" id="hp3" placeholder="HP3" maxlength="4"> <br> 
				<span></span>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>우편번호</b></td>
				<td width="80%" class="m2"><input type="text" name="post" id="post" placeholder="Post" maxlength="5" readonly="readonly">
				<button type="button" class="btn btn-success" onclick="execution_daum_address()">우편번호 찾기</button>
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>주소</b></td>
				<td width="80%" class="m2">
				<input style="width:70%;" type="text" name="addr1" id="addr1" placeholder="Address1" readonly="readonly"><br>
				<input style="width:70%;" type="text" name="addr2" id="addr2" placeholder="Address2" readonly="readonly"><br>
				<span class="final_addr_ck">주소를 입력해주세요</span>
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>닉네임</b></td>
				<td width="80%" class="m2">
				<input type="text" name="nick" id="nick" placeholder="NickName">
				<span class="final_nick_ck">닉네임을 입력해주세요.</span>
				<span class="nick_input_re_1">사용 가능한 닉네임입니다.</span>
				<span class="nick_input_re_2">닉네임이 이미 존재합니다.</span>	
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>이메일</b></td>
				<td width="80%" class="m2">
				<input type="text" name="mail" id="mail" placeholder="Mail">
				<button type="button" class="btn btn-success" id="mail_check_button">인증번호 전송</button>
				<br><span class="final_mail_ck">이메일을 입력해주세요</span>
				<span class="mail_input_box_warn"></span>
				</td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>인증번호</b></td>
				<td width="80%" class="m2" id="mail_check"><input type="text"
					name="mail_check" id="mail_check_false" placeholder="Mail-Check"
					disabled="disabled" class="mail_check_input"><br> <span
					id="mail_check_input_box_warn"></span></td>
			</tr>
			<tr>
				<td width="20%" class="m1"><b>주민번호</b></td>
				<td width="80%" class="m2"><input type="text" name="rrn1"
					id="rrn1" placeholder="RRN1" maxlength="6">- <input
					type="text" name="rrn2" id="rrn2" placeholder="RRN2" maxlength="7">
				</td>
			</tr>
			<tr>
				<td colspan="2" class="m3 text-center">
					<button class="btn btn-primary" id="join_button" type="button">회원가입</button>
					<button class="btn btn-danger" type="reset">다시쓰기</button>
				</td>
			</tr>
		</table>
	</form>

</div>
<%@ include file="/WEB-INF/include/footer.jsp"%>
<script>
	var code = ""; //이메일전송 인증번호 저장위한 코드

	 /* 유효성 검사 통과유무 변수 */
	 var idCheck = false;            // 아이디
	 var idckCheck = false;            // 아이디 중복 검사
	 var pwCheck = false;            // 비번
	 var pwckCheck = false;            // 비번 확인
	 var pwckcorCheck = false;        // 비번 확인 일치 확인
	 var nameCheck = false;            // 이름
	 var mailCheck = false;            // 이메일
	 var mailnumCheck = false;        // 이메일 인증번호 확인
	 var addressCheck = false         // 주소
	 var rrnCheck = false;			 //주민번호 확인
	 var nickCheck = false;			//닉네임 체크
	
	$(document).ready(function() {
		//회원가입
		$("#join_button").click(function() {
			var id = $('#userid').val();            // id 입력란
	        var pw = $('#pwd').val();               // 비밀번호 입력란
	        var pwck = $('#pwd2').val();            // 비밀번호 확인 입력란
	        var name = $('#name').val();            // 이름 입력란
	        var mail = $('#mail').val();            // 이메일 입력란
	        var addr = $('#addr2').val();        	// 주소 입력란
			var nick = $('#nick').val();			// 닉네임 입력란

	        /* 닉네임 유효성검사 */
	        if(nick == ""){
	            $('.final_nick_ck').css('display','block');
	            nickCheck = false;
	        }else{
	            $('.final_nick_ck').css('display', 'none');
	            nickCheck = true;
	        }
	        
	        /* 아이디 유효성검사 */
	        if(id == ""){
	            $('.final_id_ck').css('display','block');
	            idCheck = false;
	        }else{
	            $('.final_id_ck').css('display', 'none');
	            idCheck = true;
	        }
	        
	        /* 비밀번호 유효성검사 */
	        if(pw == ""){
	            $('.final_pw_ck').css('display','block');
	            pwCheck = false;
	        }else{
	            $('.final_pw_ck').css('display', 'none');
	            pwCheck = true;
	        }

	        /* 비밀번호 확인 유효성 검사 */
	        if(pwck == ""){
	            $('.final_pwck_ck').css('display','block');
	            pwckCheck = false;
	        }else{
	            $('.final_pwck_ck').css('display', 'none');
	            pwckCheck = true;
	        }
	 
	        /* 이름 유효성 검사 */
	        if(name == ""){
	            $('.final_name_ck').css('display','block');
	            nameCheck = false;
	        }else{
	            $('.final_name_ck').css('display', 'none');
	            nameCheck = true;
	        }
	 
	        /* 이메일 유효성 검사 */
	        if(mail == ""){
	            $('.final_mail_ck').css('display','block');
	            mailCheck = false;
	        }else{
	            $('.final_mail_ck').css('display', 'none');
	            mailCheck = true;
	        }
	        
	        /* 주소 유효성 검사 */
	        if(addr == ""){
	            $('.final_addr_ck').css('display','block');
	            addressCheck = false;
	        }else{
	            $('.final_addr_ck').css('display', 'none');
	            addressCheck = true;
	        }
	        
	        
	        /* 최종 유효성 검사 */
	        if(idCheck&&idckCheck&&pwCheck&&pwckCheck&&pwckcorCheck&&nameCheck&&
	        		mailCheck&&mailnumCheck&&addressCheck&&nickCheck){
	        	$("#join_form").attr("action", "/web/member/join");
				$("#join_form").submit();
	        }  
	        
	        return false;    
		});
	});//$()------------------------------------

	$("#userid").on("propertychange change keyup paste input", function() {
		var userid = $('#userid').val();
		var data = {
			userid : userid
		}
		//아이디 중복 확인
		$.ajax({
			type : "post",
			url : "/web/member/memberIdCheck",
			data : data,
			success : function(result) {
				//console.log("성공 여부"+result);
				if (result != 'fail') {
					$('.id_input_re_1').css("display", "inline-block");
					$('.id_input_re_2').css("display", "none");
					idckCheck=true;
				} else {
					$('.id_input_re_2').css("display", "inline-block");
					$('.id_input_re_1').css("display", "none");
					idckCheck=false;
				}
			}
		});
	});//$()---------------------------------------------
	
	//닉네임 중복검사
	$('#nick').on("propertychange change keyup paste input", function(){

		//console.log("keyup 테스트");	
		
		var nick = $('#nick').val();			
		var data = {nick : nick}				
		
		$.ajax({
			type : "post",
			url : "/web/member/nickCheck",
			data : data,
			success : function(result){
				if(result != 'fail'){
					$('.nick_input_re_1').css("display","inline-block");
					$('.nick_input_re_2').css("display", "none");				
				} else {
					$('.nick_input_re_2').css("display","inline-block");
					$('.nick_input_re_1').css("display", "none");				
				}
			}
		
		});

	});//------------------------------------

	$("#mail_check_button").click(function() {
		var email = $("#mail").val(); //입력한 이메일
		var checkBox = $(".mail_check_input"); //인증번호 입력란
		var warnMsg =$(".mail_input_box_warn"); //이메일 입력 경고글
		
		 /* 이메일 형식 유효성 검사 */
	    if(mailFormCheck(email)){
	        warnMsg.html("이메일이 전송 되었습니다. 이메일을 확인해주세요.");
	        warnMsg.css("display", "inline-block");
	    } else {
	        warnMsg.html("올바르지 못한 이메일 형식입니다.");
	        warnMsg.css("display", "inline-block");
	        return false;
	    }    
		
		$.ajax({
			type : "GET",
			url : "mailCheck?email=" + email,
			success : function(data) {
				//console.log("data : "+data);
				checkBox.attr("disabled", false);
				checkBox.attr("id", "mail_check_true");
				code = data;
			}
		});
	});//$()-------------------------------------------------

	//인증번호 비교
	$(".mail_check_input").blur(function() {

		var inputCode = $(".mail_check_input").val(); //입력코드
		var checkResult = $("#mail_check_input_box_warn"); //비교결과

		if (inputCode == code) {
			checkResult.html("인증번호가 일치합니다");
			checkResult.css("color", "green");
			mailnumCheck = true;     // 일치할 경우
		} else {
			checkResult.html("인증번호를 다시 확인해주세요.");
			checkResult.css("color", "red");
			mailnumCheck = false;    // 일치하지 않을 경우

		}
	});

	function execution_daum_address() {

		new daum.Postcode({
			oncomplete : function(data) {
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}

					addr += extraAddr;

				} else {
					addr += ' ';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				$("#post").val(data.zonecode);
				// 커서를 상세주소 필드로 이동한다.
				$("#addr1").val(addr);
				$("#addr2").attr("readonly", false);
				$("#addr2").focus();

			}
		}).open();

	}
	
	/* 비밀번호 확인 일치 유효성 검사 */
	 
	$('#pwd2').on("propertychange change keyup paste input", function(){
		var pw = $('#pwd').val();
	    var pwck = $('#pwd2').val();
	    $('.final_pwck_ck').css('display', 'none');
	    
	    if(pw == pwck){
	        $('.pwck_input_re_1').css('display','block');
	        $('.pwck_input_re_2').css('display','none');
	        pwckcorCheck = true;
	    }else{
	        $('.pwck_input_re_1').css('display','none');
	        $('.pwck_input_re_2').css('display','block');
	        pwckcorCheck = false;
	    }        
	});    
	
	/* 입력 이메일 형식 유효성 검사 */
	 function mailFormCheck(email){
		 var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		 return form.test(email);
	}
	 

</script>