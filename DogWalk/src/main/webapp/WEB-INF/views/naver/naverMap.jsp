<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>Insert title here</title>
<script type="text/javascript"src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=v16lw67don"></script>
</head>
<body>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
  <!-- 네이버 지도가 뿌려질 곳 -->
<div id="map" style="width:100%;height:75vh; margin: 0 auto; float : left"></div>
  

<script type="text/javascript">
	$(function() {
	
	initMap();
	
	});

function initMap() {
	
	let markers = new Array();//마커 정보를 담는 배열
	let infoWindows = new Array();//정보창을 담는 배열 

	var map = new naver.maps.Map('map', {
        center: new naver.maps.LatLng(37.552758094502494, 126.98732600494576),
        zoom: 15
    });
	
    var marker = new naver.maps.Marker({
        map: map,
        title: "남산서울타워",
        position: new naver.maps.LatLng(37.552758094502494, 126.98732600494576),
        icon: {
            content: '<img src="<c:url value="/resources/img/chu.png"/>" alt="" style="margin: 0px; padding: 0px; border: 0px solid transparent; display: block; max-width: none; max-height: none; -webkit-user-select: none; position: absolute; width: 32px; height: 32px; left: 0px; top: 0px;">',
            size: new naver.maps.Size(32, 32),
            anchor: new naver.maps.Point(16, 32)
        }
    });
    
    /* 정보창 */
	 var infoWindow = new naver.maps.InfoWindow({
	        content: '<div style="width:200px;text-align:center;padding:10px;"><b>서울남산타워</b><br> - 네이버 지도 - </div>'
	 }); // 클릭했을 때 띄워줄 정보 입력
   
	 markers.push(marker); // 생성한 마커를 담는다.
	 infoWindows.push(infoWindow); // 생성한 정보창을 담는다.
   
   
   function getClickHandler(seq) {
		
           return function(e) {  // 마커를 클릭하는 부분
               var marker = markers[seq], // 클릭한 마커의 시퀀스로 찾는다.
                   infoWindow = infoWindows[seq]; // 클릭한 마커의 시퀀스로 찾는다

               if (infoWindow.getMap()) {
                   infoWindow.close();
               } else {
                   infoWindow.open(map, marker); // 표출
               }
   		}
   	}
   
   for (var i=0, ii=markers.length; i<ii; i++) {
   	console.log(markers[i] , getClickHandler(i));
       naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i)); // 클릭한 마커 핸들러
   }
}

</script>
</body>
</html>  