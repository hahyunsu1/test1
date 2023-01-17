<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script>
$(function(){
	$('#uploadForm').submit(function(e){
		e.preventDefault();
		//파일 첨부 안했을 경우
		let image=$('#image')[0];
		if(image.files.length==0){
			alert('이미지 파일을 첨부하세요');
			return;
		}
		
		//파일 업로드시에는 FormData객체에 form객체를 인자로 전달하면 된다.
		let form=$('#uploadForm')[0];//form객체
		//alert(form)
		let data=new FormData(form);
		let url="objdtc";
		$.ajax({
			type:'post',
			url:url,
			dataType:'json',
			data:data, //FormData를 전달
			processData:false,//일반적으로 서버에 전달되는 데이터는 query string 형태이다 이걸 사용 안하겟단 의미
			contentType:false,//"multipart/form-data"로 전송되도록 false 설정. 명시적으로 "multipart/form-data"으로 설정해주면 boundary string이 안 들어가 제대로 동작하지 않는다.
			success:function(res){
				console.log(JSON.stringify(res));
				$('#txt').val(res.result);
				//alert(typeof res.result);
				let json=JSON.parse(res.result);//string유형을 파싱하여 json객체로 변환해준다.				
				//alert(JSON.stringify(json.predictions))
				$('#result').html("");
				$.each(json.predictions,function(i, cel){
					alert(cel.detection_classes);
					$('#result').append("<h2>"+cel.detection_classes+"</h2>")
				})										
			},
			error:function(err){
				alert('error: '+err.status);
				console.log(err.responseText);
			}
		})
		
	})
})
</script>
<div id="wrap">
	<h1>objdtc</h1>
	<p>
		사진으로부터 객체 조사
		
	</p>
	<form method="post" enctype="multipart/form-data" id="uploadForm">
		<label for="image">이미지 선택</label>
		<input type="file" name="image" id="image">
		<button>확 인</button>
	</form>
	<hr>
	<div id="result">
	
	</div>
	
	<textarea id="txt" rows="7" cols="60"></textarea>
</div>