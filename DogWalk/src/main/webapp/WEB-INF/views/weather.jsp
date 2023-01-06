<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Weather API</title>
</head>

<body>
	<h2>날씨정보</h2>
	<div style="width:1000px; margin-top:40px; text-align:center">
		<input type=text name="city" id="city" value="" style="width:180px; height:24px; 
		vertical-align:top" placeholder="도시를 입력하세요">
		<button conclick="javascript:goSearch();">날씨 검색</button>
	</div>
	
	<div style="margin-left:50px; margin-top:15px; color:blue; font-weight:bold">
		검색결과
	</div>
	<div id="weather_result" style="margin-left:50px;width:90%; min-height:250px; display:inline-block;
	 margin-top:10px; margin-left:50px; padding:6px; padding-right:75px; border:1px solid #bbbbbb">
	 </div>
	<h3 class="time">현재 시간: </h3> 
	<h3 class="ctemp">현재 온도: </h3>
	<h3 class="lowtemp">최저 온도: </h3>
	<h3 class="hightemp">최고 온도: </h3>
	<h3 class="icon"></h3>

	<script src="https://code.jquery.com/jquery-3.6.3.min.js" 
	integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
	crossorigin="anonymous"></script>
	
	<script>
		$.getJSON('http://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=13f0a9efc5b888e8d8deca6186a35df1&units=metric',
			function(result){
			
			$('.ctemp').append(result.main.temp);
			$('.lowtemp').append(result.main.temp_min);
			$('.hightemp').append(result.main.temp_max);
			//result.weather[0].icon;
			var wiconUrl= '<img sec="http://openweathermap.org/img/wn/'+result.weather[0].icon+
				'.png" alt="'+result.weather[0].description+'">'
			$('.icon').html(wiconUrl);
			
			
		});
		
	</script>
</body>

</html>