<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:import url="/top"/>

<script>
	$(function(){
		$('#bt1').click(function(){
			let url="ajaxVO";
			$.ajax({
				url:url,
				type:'get',
				data:'num=100&name='+encodeURIComponent('홍길동'),
				dateType:'json',
				cache:false,
				success:function(res){
					//alert(res);
					let str='<h3>Num: '+res.idx+"</h3>";
					str+='<h3>Name: '+res.name+"</h3>";
					$('#resultView').html(str);
				},
				error:function(err){
					alert('err')
				}
			})
		});
		$('#bt2').click(function(){
			let url="ajaxList";
			$.ajax({
				url:url,
				type:'get',
				data:'idx=33&name='+encodeURIComponent("김철수"),
				dateType:'json',
				cache:false,
				
			})
			.done(function(res){
				//alert(JSON.stringify(res));
				let str='<ul>';
					$.each(res,function(i,vo){
						str+='<li>'+vo.idx+", "+vo.name+", "+vo.msg+"</li>";
					})
					str+='</ul>';
					$('#resultView').html(str);
			})
			.fail(function(err){
				alert('err')
			})
		});
		$('#bt3').click(function(){
			let jsonData={
					idx:111,
					name:'King',
					msg:'How are you?',
					wdate:'2022-11-28'
			};
			//json데이터를 파라미터로 보내고,응답도 json으로 반아보자
			$.ajax({
				type:'post',
				url:'ajaxRestJson',
				contentType:'application/json',
				data: JSON.stringify(jsonData),
				dataType:'json',
				chche:false,
				success:function(res){
					//alert(JSON.stringify(res));
					let wdate=new Date(res.memo1.wdate);
					//getMonth():1월:0을 반환,2월:1,....11월10,12월:11
					let dateStr=wdate.getFullYear()+"-"+(wdate.getMonth()+1)+"-"+wdate.getDate();
					let str='<h3>작성자명: ';
						str+=res.memo1.name+"</h3>";
						str+='<h3>메모내용: '+res.memo1.msg+"</h3>";
						str+='<h3>작성일: '+dateStr+"</h3>";
						$('#resultView').html(str);
				},
				error:function(err){
					alert('err: '+err.status);
				}
			})
		})////
	})
</script>

<div class="container mt-3" style="height: 600px;overFlow:auto;">
	<h1 class="text-center">Ajax Test Page</h1>
	<button id="bt1" class="btn-outline-success">ajax(VO)</button>
	<button id="bt2" class="btn-outline-danger">ajax(List)</button>
	<button id="bt3" class="btn-outline-primary">ajax(json파라미터전달)</button>
	<hr>
	<div id="resultView"></div>
</div>

<c:import url="/foot"/>