<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=v16lw67don&submodules=geocoder"></script>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
</head>

<body>
<div class="search">
	<input id="address" type="text" placeholder="검색할 주소">
	<input id="submit" type="button" value="주소검색">
</div>
<div id="map" style="width:1000px;height:500px;"></div>
<div>
	<table>
		<thead>
			<tr>
				<th>병원이름</th>
				<th>주소</th>
				<th>연락처</th>
				<th>위도</th>
				<th>경도</th>	
			</tr>	
		</thead>
		<tbody id="mapList"></tbody>
	</table>
</div>
</body>
<script>
//지도를 그려주는 함수 실행
selectMapList();

//검색한 주소의 정보를 insertAddress 함수로 넘겨준다.
// ajax 로 데이터를 넘겨보고싶은데 안넘어 가네여
const getNaverList=function(findAddr){
	//alert('aaa'+findAddr)
	$.ajax({
		type:'get',
		url:'list?addr='+findAddr,		
		dataType:'json',
		cache:false,
		success:function(res){
			showAddrList(res);
		},
		error:function(err){
			//alert('err: '+err.status);
		}
	});
}//--------------------
const showAddrList=function(res){
	//alert(JSON.stringify(res));
	var areaArr = new Array();
	$.each(res,function(i, obj){
		//console.log(obj)
		let addr=obj.refine_LOTNO_ADDR;
		  // 지역을 담는 배열 ( 병원명 /위도경도 )
		areaArr.push({location : obj.bizplc_NM , lat : obj.refine_WGS84_LAT , lng : obj.refine_WGS84_LOGT})
		//searchAddressToCoordinate(addr);
		
		insertAddress(obj.bizplc_NM, obj.refine_LOTNO_ADDR,obj.locplc_FACLT_TELNO_DTLS, obj.refine_WGS84_LAT,obj.refine_WGS84_LOGT);
	})
	initMap(areaArr);//지도에 마커 표시
}


function searchAddressToCoordinate(address) {
    naver.maps.Service.geocode({
        query: address
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) {
            return alert('Something Wrong!');
        }
        if (response.v2.meta.totalCount === 0) {
            return alert('올바른 주소를 입력해주세요.');
        }
        var htmlAddresses = [],
            item = response.v2.addresses[0],
            point = new naver.maps.Point(item.x, item.y);
        if (item.roadAddress) {
            htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
        }
        if (item.jibunAddress) {
            htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
        }
		//alert(item.roadAddress+", "+item.x+", "+item.y);
        //insertAddress(item.roadAddress, item.x, item.y);
        
    });
}
function initMap(areaArr) { 
	//alert(areaArr.length)
	let markers = new Array(); // 마커 정보를 담는 배열
	let infoWindows = new Array(); // 정보창을 담는 배열
	
	var map = new naver.maps.Map('map', {
       		 center: new naver.maps.LatLng(areaArr[0].lat, areaArr[0].lng), //지도 시작 지점
       		 zoom: 15
   		 });
	
	
	
	
	for (var i = 0; i < areaArr.length; i++) {
		// 지역을 담은 배열의 길이만큼 for문으로 마커와 정보창을 채워주자 !

	    var marker = new naver.maps.Marker({
	        map: map,
	        title: areaArr[i].location, // 지역구 이름 
	        position: new naver.maps.LatLng(areaArr[i].lat , areaArr[i].lng) // 지역구의 위도 경도 넣기 
	    });
	    
	    /* 정보창 */
		 var infoWindow = new naver.maps.InfoWindow({
		     content: '<div style="width:200px;text-align:center;padding:10px;"><b>' + areaArr[i].location + '</b><br> - 동물병원 - </div>'
		 }); // 클릭했을 때 띄워줄 정보 HTML 작성
	    
		 markers.push(marker); // 생성한 마커를 배열에 담는다.
		 infoWindows.push(infoWindow); // 생성한 정보창을 배열에 담는다.
	}
    
	 
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
// 주소 검색의 이벤트

$('#address').on('keydown', function(e) {
    var keyCode = e.which;
    if (keyCode === 13) { // Enter Key
        //searchAddressToCoordinate($('#address').val());
    	$('#mapList').html("")
    	getNaverList($('#address').val())
    }
});
$('#submit').on('click', function(e) {
    e.preventDefault();
    //searchAddressToCoordinate($('#address').val());
    getNaverList($('#address').val())
});
naver.maps.Event.once(map, 'init_stylemap', initGeocoder);

function initGeocoder(){
	searchAddressToCoordinate('경기도 시흥시 은계번영길')
}
    
//검색정보를 테이블로 작성해주고, 지도에 마커를 찍어준다.
function insertAddress(name,address, tel, latitude, longitude) {
	var mapList = "";
	mapList += "<tr>"
	mapList += "	<td>" + name + "</td>"
	mapList += "	<td>" + address + "</td>"
	mapList += "	<td>" + tel + "</td>"
	mapList += "	<td>" + latitude + "</td>"
	mapList += "	<td>" + longitude + "</td>"
	mapList += "</tr>"

	$('#mapList').append(mapList);
	
	var map = new naver.maps.Map('map', {
	    center: new naver.maps.LatLng(longitude, latitude),
	    zoom: 14
	});
    var marker = new naver.maps.Marker({
        map: map,
        position: new naver.maps.LatLng(longitude, latitude)
    });
}


//지도를 그려주는 함수
function selectMapList() {
	
	var map = new naver.maps.Map('map', {
	    center: new naver.maps.LatLng(37.3595704, 127.105399),
	    zoom: 10
	});
}


// 지도를 이동하게 해주는 함수
function moveMap(len, lat) {
	var mapOptions = {
		    center: new naver.maps.LatLng(len, lat),
		    zoom: 15,
		    mapTypeControl: true
		};
    var map = new naver.maps.Map('map', mapOptions);
    var marker = new naver.maps.Marker({
        position: new naver.maps.LatLng(len, lat),
        map: map
    });
}///////////////////////////////////


</script>
</html>