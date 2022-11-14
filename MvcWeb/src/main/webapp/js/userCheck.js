 let win=null;
 function open_idcheck(){
	win=window.open("idCheck.jsp","idCheck","width=400,height=400,left=200,top=200");
}
function setId(uid){
	//alert(uid);
	//uid값을 부모창(window)의 userid의 value값에 전달하자
	//부모창(opener==> window객체)
	//window>document>forms
	opener.document.mf.userid.value=uid;
	//팝업창 닫기==>self(window객체)
	self.close();
}
function id_check(){
	if(!idf.userid.value){
		alert('아이디를 입력해야 해요');
		idf.userid.focus();
		return;
	}if(!isUserid(idf.userid)){
		alert('아이디는 영문자,숫자, _ , ! 로 4~8자까지 가능해요')
		idf.userid.select();
		return;
	}
	
	idf.submit();
}
 
 function member_check(){
	/*if(!isDate(mf.birth)){
		alert('날짜 형식에 맞게 입력하세요 yyyy-mm-dd  or yyyy/mm/dd 가능해요');
		mf.birth.select();
		return;
	}
	if(!isEmail(mf.email)){
		alert('이메일 형식에 맞게 입력하세요[aaa@naver.com] 이메일은 알파벳문자,숫자,하이픈(-)@naver.com');
		mf.email.select();
		return;
	}*/
	if(!isKor(mf.name)){
		alert('이름은 한글이름만 가능합니다');
		mf.name.focus();
		return;
	}
	if(!isUserid(mf.userid)){
		alert('아이디는 영문자,숫자, _ , ! 로 4~8자까지 가능해요')
		mf.userid.select();
		return;
	}
	if(!isPasswd(mf.pwd)){
		alert('비밀번호는 문자,숫자,!,. 포함해서4~12자리까지 가능해요')
		mf.pwd.select();
		return;
	}
	if(mf.pwd.value!=mf.pwd2.value){
		alert('비밀번호와 비밀번호 확인이 다릅니다')
		mf.pwd2.select();
		return;
	}
	if(!isMobile(mf.hp1,mf.hp2,mf.hp3)){
		alert('핸드폰 형식에 맞지 않아요.(010|011)-(숫자3~4자리)-(숫자4자리) 가능해요')
		mf.hp1.select();
		return;
	}
	mf.submit();
}//------------------------
/*function isEmail(input){
	let val=input.value;
	let pattern=/^[\w-_]+(\.[\w]+)*@([a-zA-Z]+\.)+[a-z]{2,3}$/;
	let b=pattern.test(val);
	aler('email '+b);
	return b;
}
function isDate(input){
	let val=input.value;
	let pattern=/^\d{4}[-\/](0[1-9]|1[012])[-\/](0[1-9]|[12][0-9]|3[01])$/;
	let b=pattern.test(val);
	alert(b);
	return b;
}*/
	
/**
	\b:단어의 경계를 나타내며,해당 패턴이 정확하게 일치해야 함을 의미
	(010|011) : 010또는 011이 와야 함을 의미
	\d{3,4} : 숫자가 3개이상  4개 이하 나와야 함을 의미
	\d{4} : 숫자가 4자 나와야 함을 의미

 */	


function isMobile(input1,input2,input3){
	let val=input1.value+"-"+input2.value+"-"+input3.value;
	//alert(val);
	let pattern=/^\b(010|011)[-]\d{3,4}[-]\d{4}\b$/;
	let b=pattern.test(val);
	//alert('hp '+b);
	return b;
}

function isPasswd(input){
	let val=input.value;
	let pattern=/^[\w!\.]{4,12}$/;
	let b=pattern.test(val);	
	return b;
}

function isUserid(input){
	let val=input.value;
	let pattern=/^[a-zA-Z0-9_!]{4,8}$/;
	let b=pattern.test(val);
	return b;
}

/**
^ : 시작을 의미
$ : 끝을 의미
가-힣 : 한글을 의미
+ : 패턴이 한 번 이상 반복된다는 의미
 */

function isKor(input){
	let val=input.value;
	//let pattern=new RegExp(/multi/g);//multi문자열이 있는지 여부를 체크하는 패턴
	//let pattern=/multi/g
	let pattern=/^[가-힣]+$/;
	let b=pattern.test(val);//정규식 패턴에 맞으면 true를 반환하고, 틀리면 false를 반환한다.
	//alert(b);	
	return b;
}