<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

$(function(){
	show_reviews();//전체 리뷰 목록 가져오기
	review_count();
	//파일 업로드 처리시 ==> FormData객체에 form data를 담아 보내야 한다 (업로드)
	
	$('#rf').submit(function(evt){
		evt.preventDefault();
		//첨부파일
		const file=$('#mfilename')[0]
		//console.dir(file);
		//첨부파일명 얻기
		const fname=file.files[0];
		//alert(fname);
		const userid=$('#userid').val();
		const content=$('#content').val();
		const score=$('input[name="score"]:checked').val();
		const pnum_fk=$('#pnum_fk').val();
		
		console.log(userid+"/"+content+"/"+score+"/"+pnum_fk+"/"+fname);
		
		let fd=new FormData();
		fd.append('mfilename',fname);
		fd.append('userid',userid);
		fd.append('content',content);
		fd.append('score',score);
		fd.append('pnum_fk',pnum_fk);
		
		/*
			processData:false, ==> 기본값: true ==>true면 enctype="application/x-www-form-urlencod" 타입으로 전송한다.
			contentType:false, ==> 기본값: true enctype="application/x-www-form-urlencod"
			파일 업로드시는 enctype="multipart/form-data" 로 가야 하므로, false,false로 설정하자
		*/
		let url="user/reviews";
		$.ajax({
			type:'post',
			url:url,
			data:fd,//FormData객체 전달
			dataType:'xml',
			processData:false,
			contentType:false,
			cache:false,
			beforeSend:function(xhr){
				xhr.setRequestHeader("Ajax","true");
			},
			success:function(res){
				//alert(res);
				let result=$(res).find('result').text();
				if(result>0){
					
					show_reviews();//전체 리뷰 목록 가져오기
				}else{
					alert('등록 실패');
				}
			},
			error:function(err){
				//alert('err: '+err.status);
				if(err.status==400){
					alert('로그인 해야 이용가능 합니다');
				}
			}
		});
	})
	$('#rf2').submit(function(evt){
		evt.preventDefault();
		//사용자가 수정한 값 얻기
		let uid=rf2.userid.value;
		let pnum=rf2.pnum_fk.value;
		let num=rf2.num.value;
		let score=rf2.score.value;
		let content=rf2.content.value;
		
		let jsonData={
			userid:uid,
			pnum_fk:pnum,
			num:num,
			score:score,
			content:content
		}
		let data=JSON.stringify(jsonData);
		let url="user/reviews/"+num;
		$.ajax({
			type:'put',
			url:url,
			data:data,
			contentType:'application/json; charset=UTF-8',
			dataType:'json',
			cache:false,
			beforeSend:function(xhr){
				xhr.setRequestHeader("Ajax","true");
			},
			success:function(res){
				//alert(JSON.stringify(res));
				
				if(res.result>0){	
					$('#reviewModal').modal('hide');				
					show_reviews();//전체 리뷰 목록 가져오기
					
				}else{
					alert('등록 실패');
				}
			},
			error:function(err){
				//alert(err);
				if(err.status==400){
					alert('로그인 해야 이용가능 합니다');
				}else{
					alert('err');
				}
			}
		});
	});//rf2
	
})//$() end----
const review_count=function(){
	let url='reviewCnt';
	$.ajax({
		type:'get',
		url:url,
		dataType:'json',
		cache:false,
		success:function(res){
			//alert(res.count);
			$('#review_cnt').html(res.count);
		},
		error:function(err){
			alert(err);
		}
	});
}
//리뷰목록 가져오기
const show_reviews=function(){
	let url="reviews";
	$.ajax({
		type:'get',
		url:url,
		dataType:'json',
		cache:false,
		success:function(res){
			//alert(JSON.stringify(res));
			showTable(res);
		},
		error:function(err){
			alert('err: '+err.status);
		}
	});
	
}///show

const showTable=function(res){
	let str='<table class="table table-striped">';
		$.each(res,function(i,rvo){
			let d=new Date(rvo.wdate);
			
			let dstr=d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
			
			str+='<tr><td width="15%">';
			if(rvo.filename==null){
				str+='<img src="resources/product_images/noimage.png"class="img-thumbnail" style="width:80%;margin:auto">';
			}else{
				str+='<img src="resources/review_images/'+rvo.filename+'"class="img-thumbnail" style="width:80%;margin:auto">';
			}
			str+='</td><td width="60%" class="text-left">';
			str+=rvo.content+" <span class='float-right'>"+rvo.userid+"[ "+dstr+" ]</span>";
			str+='</td>';
			str+='<td width="25%" class="text-left">';
			for(let k=0;k<rvo.score;k++){
			str+='<img src="resources/review_images/star.jpg">';
			}
			str+='<div class="mt-4">';
			
			if(rvo.userid =="${loginUser.userid}"){
			str+='<a href="#reviewList" onclick="reviewEdit('+rvo.num+')">Edit</a> | ';
			str+='<a href="#reviewList" onclick="reviewDel('+rvo.num+')">Del</a>';
			}
			if("${loginUser.status}"==9 ){		
			str+='<a href="#reviewList" onclick="reviewEdit('+rvo.num+')">Edit</a> | ';
			str+='<a href="#reviewList" onclick="reviewDel('+rvo.num+')">Del</a>';
			}
			str+='</div>';
			str+='</td>';
			str+='</tr>';
			});
			
		str+='</table>';
		
		$('#reviewList').html(str);
}//---------------------

const reviewEdit=function(num){
	//console.log(num);
	let url="user/reviews/"+num;
	$.ajax({
		type:'get',
		url:url,
		dataType:'json',		
		cache:false,
		beforeSend:function(xhr){
				xhr.setRequestHeader("Ajax","true");
			},		
		success:function(res){
			//alert(JSON.stringify(res));
			rf2.num.value=res.num;//리뷰글번호
			rf2.content.value=res.content;
			let str='';
			for(let i=0;i<res.score;i++){
				str+='<img src="resources/review_images/star.jpg">';
			}	
			$('#star').html(str);
			let imgSrc;	
			if(res.filename==null){
				imgSrc='noimage.png';
			}else{
				imgSrc=res.filename;
			}
			str='<img src="resources/review_images/'+imgSrc+'" class="img-fluid" style="width:50%;margin:auto">'
			$('#prodImage').html(str);
			$('#reviewModal').modal();
			
		},
		error:function(err){
			//alert('err');
			if(err.status==400){
					alert('로그인 해야 이용가능 합니다');
				}
		}
	});
}


const reviewDel = function(num){
	//alert(num)
	let url="user/reviews/"+num;
	$.ajax({
		type:'delete',
		url:url,
		dataType:'json',
		cache:false,
		beforeSend:function(xhr){
				xhr.setRequestHeader("Ajax","true");
			},
		success:function(res){
			//alert(JSON.stringify(res));
			if(res.result>0){
				show_reviews();//전체리뷰목록 가져오기;
			}
		},
		error:function(err){
			//alert('err: '+err.status);
			if(err.status==400){
					alert('로그인 해야 이용가능 합니다');
			}
		}
	});
}

//파일 업로드 없는 일반적 form data 전송시
const send=function(){
	//alert('send');
	let params=$('#rf').serialize();
	//alert(params);
	let url="user/reviews";
	
	$.ajax({
		type:'post',
		url:url,
		data:params,
		cache:false,
		dataType:'xml',
		success:function(res){
			//alert(res);//XMLDocument
			let result=$(res).find('result').text();
			alert(result);
		},
		error:function(err){
			alert('err'+err.status);
		}
	});
	
}

</script>