<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- CDN 참조-------------------------------------- -->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<!-- ------------------------------------------------- -->
<script>
	//응답이 배열로 올 경우 =>반복문 이용해야 한다.
	//$.each(배열, function(index, obj){ .... })  : 
		//jquery함수, 배열의 요소만큼 반복문 돌면서 배열에 저장된 요소를 obj에 할당한다

	function showList(data){
		//alert(data.length)
		let str='<table class="table">';
			$.each(data,function(i,book){
				str+='<tr>';
				str+='<td><img src="../book/images/'+book.bimage+'"></td>';
				str+='<td>'+book.isbn+'</td>';
				str+='<td>'+book.title+'</td>';
				str+='<td>'+book.price+'</td>';
				str+='<td>'+book.publish+'</td>';
				str+='<td>'+book.published+'</td>';
				str+='</tr>';
			})
			str+='</table>';
			$('#msg').html(str);
	}
	function showList2(data){
		//alert(data.length)
		let str='<table class="table">';
			$.each(data,function(i,book){
				let date=(book.published.year+1900)+"-"+(book.published.month+1)+"-"+book.published.date;
				str+='<tr>';
				str+='<td><img src="../book/images/'+book.bimage+'"></td>';
				str+='<td>'+book.isbn+'</td>';
				str+='<td>'+book.title+'</td>';
				str+='<td>'+book.price+'</td>';
				str+='<td>'+book.publish+'</td>';
				str+='<td>'+date+'</td>';
				str+='</tr>';
			})
			str+='</table>';
			$('#msg').html(str);
	}
	function showData(data){
		let str='<table class="table">';
		
			str+='<tr>';			
			str+='<td>도서명</td><td>';
			str+=data.title;
			str+='</td>';
			str+='</tr>';
			
			str+='<tr>';
			str+='<td>출판사</td><td>';
			str+=data.publish;
			str+='</td>';
			str+='</tr>';
			
			str+='<tr>';
			str+='<td>가격</td><td>';
			str+=data.price;
			str+='</td>';
			str+='</tr>';
			
			str+='<tr>';
			str+='<td>출판일</td><td>';
			str+=data.published;
			str+='</td>';
			str+='</tr>';
			
			str+='<tr>';
			str+='<td>도서이미지</td><td>';
			str+='<img src="../book/images/'+data.bimage+'">';
			str+='</td>';
			str+='</tr>';
			
			str+='</table>';
			$('#msg').html(str);
	}
	$(function(){
		$('#bt1').on('click',function(){
			$.ajax({
				type:'get',
				url:'jsonData.jsp',
				dataType:'text',
				//dataType:'json',
				cache:false,
				success:function(res){
					//alert(res);
					let obj=JSON.parse(res);//json형식의 텍스트 문자열을 파싱해서 json객체로 만들어서 반환해준다.
					//JSON.parse()<==>JSON.stringify()
					//alert(obj.title);
					showData(obj);
					
				},
				error:function(err){
					alert('error: '+err.status+", "+err.responseText);
					console.dir(err);
				}
			})
		})//#bt1--------------------
		$('#bt2').on('click',function(){
			$.ajax({
				type:'get',
				url:'jsonData2.jsp',
				//dataType:'text',
				dataType:'json',
				cache:false,
				success:function(res){
					//alert(res);
					showList(res);
					
					
				},
				error:function(err){
					alert('error: '+err.status+", "+err.responseText);
					
				}
			})
		})//#bt2--------------------
		$('#bt3').on('click',function(){
			$.ajax({
				type:'get',
				url:'jsonData3.jsp',
				//dataType:'text',
				dataType:'json',
				cache:false,
				success:function(res){
					//alert(res);
					showList(res.books);
					
					
				},
				error:function(err){
					alert('error: '+err.status+", "+err.responseText);
					
				}
			})
		})//#bt3--------------------
		$('#bt4').on('click',function(){
			$.ajax({
				type:'get',
				url:'jsonData4.jsp',
				//dataType:'text',
				dataType:'json',
				cache:false,
				success:function(res){
					//alert(res);
					showList(res.books);
					
					
				},
				error:function(err){
					alert('error: '+err.status+", "+err.responseText);
					
				}
			})
		})//#bt4--------------------
		$('#bt5').on('click',function(){
			$.ajax({
				type:'get',
				url:'jsonData5.jsp',
				//dataType:'text',
				dataType:'json',
				cache:false,
				success:function(res){
					//alert(res);
					showData(res);					
				},
				error:function(err){
					alert('error: '+err.status+", "+err.responseText);
					
				}
			})
		})//#bt5--------------------
		$('#bt6').on('click',function(){
			$.ajax({
				type:'get',
				url:'jsonData6.jsp',
				//dataType:'text',
				dataType:'json',
				cache:false,
				success:function(res){
					//alert(JSON.stringify(res));
					showList2(res);
										
				},
				error:function(err){
					alert('error: '+err.status+", "+err.responseText);
					
				}
			})
		})//#bt6--------------------
		/*
	      자바스크립트 보안 정책
	      : 자바스크립트는 같은 도메인일 경우마 통신 가능함
	      - Ajax 통신은 같은 도메인일 경우만 통신할 수 있기 때문에
	      - java를 이용해 통신할 수 있다.            
	      즉, 아래에 있는 코드로는 수행이 안됨
	   */

		/*$('#bt7').click(function(){
			let keyword=prompt('검색어를 입력하세요','Ajax');
			if(!keyword) return;
			let url="https://openapi.naver.com/v1/search/book.json?query="+encodeURIComponent(keyword);
			$.ajax({
				type:'get',
				url:url,
				headers:{
					'X-Naver-Client-Id':'GcZw1zeUbcrNYan_iuzT',
					'X-Naver-Client-Secret':'22wThOnaUO'
				},
				dataType:'json',
				cache:false,
				success:function(res){
					
				},
				error:function(err){
					alert('error: '+err.status);
					console.log(err.responseText);
				}
			})
		})//----------bt7*/
		$('#bt7').click(function(){
			let keyword=prompt('검색어를 입력하세요','Ajax');
			if(!keyword) return;
			let url="jsonDate7.jsp?query="+encodeURIComponent(keyword);
			$.ajax({
				type:'get',
				url:url,
				dataType:'json',
				cache:false,
				success:function(res){
					//alert(res);
					let books=res.items;//도서정보=>배열
					let str='<h1>네이버 도서 정보 검색 결과 ['+keyword+']</h1>';
					$.each(books, function(i, book){
						if(i<5){
						str+='<div>';
						str+='<a href="'+book.link+'" target="_blank">';
						str+='<img src="'+book.image+'" style="width:120px">';
						str+='<h3>'+book.title+'</h3>';
						str+='</a>';
						str+='</div>';
						}
					})
					$('#msg').html(str);
					console.log(res);
				},
				error:function(err){
					alert('error: '+err.status);
					console.log(err.responseText);
				}
			})
		})//bt7	
	})
</script>
<div class="container">
<h1>JSON형태로 데이터를 받아봅시다</h1>
<h2>JSON이란? - JavaScript Object Notation</h2>
<h2>자바스크립트에서 이용하는 객체 형태로 데이터를 표현하는 방식</h2>
<h2>JSON객체에는 문자열,숫자,배열,boolean,null값만 들어갈 수 있다.</h2>
<hr color="blue">
	<button id="bt1" class="btn btn-primary">JSON형태로 받기1</button>
   <button id="bt2" class="btn btn-danger">JSON형태로 받기2</button>
   <button id="bt3" class="btn btn-success">JSON형태로 받기3</button>
   <button id="bt4" class="btn btn-info">JSON형태로 받기4-DB에서 가져오기</button>
   <br><br>
   <button id="bt5" class="btn btn-warning">JSON형태로 받기5-라이브러리 사용하기</button>
   <button id="bt6" class="btn btn-default">JSON형태로 받기6-라이브러리 사용하기</button>
   <button id="bt7" class="btn btn-link">Naver OpenApi에서 도서정보 받아오기</button>
   <hr color="red">
<div id="msg" style="margin-top:20px">
</div>

</div>
