<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=네이버 클라이언트 API ID 값"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
function sendGps(lat, lng) { 
	var path = '/' + location.pathname.split('/')[1];
   	var postUrl = path + "/GpsToAddress";
    $.post(postUrl,
    	    { lat: lat,	lng: lng },
    	    function(data, status){
    	    	console.log("status" + status);
    	    	console.log("data" + data);
    	    	alert(data);
    	    });
}
</script>
<body>
        <button id="getLocation" type="button">위치 정보 수집</button>
        <div id="map" style="width: 500px; height: 500px; display: block;"></div>
        
        <script>
        var map = new naver.maps.Map('map', {
            center: new naver.maps.LatLng(37.5666805, 126.9784147),
            zoom: 5,
            mapTypeId: naver.maps.MapTypeId.NORMAL
        });

        var infowindow = new naver.maps.InfoWindow();

        function onSuccessGeolocation(position) {
            var location = new naver.maps.LatLng(position.coords.latitude,
                                                 position.coords.longitude);

            map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
            map.setZoom(10); // 지도의 줌 레벨을 변경합니다.

            infowindow.setContent('<div style="padding:20px;">' +
                '위도: '+ location.lat() +'<br />' +
                '경도: '+ location.lng() +'</div>');
            sendGps(location.lat(), location.lng());
            infowindow.open(map, location);
        }

        function onErrorGeolocation() {
            var center = map.getCenter();

            infowindow.setContent('<div style="padding:20px;">' +
                '<h5 style="margin-bottom:5px;color:#f00;">Geolocation failed!</h5>'+ "위도: "+ center.lat() +"<br />경도: "+ center.lng() +'</div>');

            infowindow.open(map, center);
        }

        document.getElementById("getLocation").onclick = function() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
            } else {
                var center = map.getCenter();

                infowindow.setContent('<div style="padding:20px;"><h5 style="margin-bottom:5px;color:#f00;">Geolocation not supported</h5>'+ ": "+ center.lat() +"<br />longitude: "+ center.lng() +'</div>');
                infowindow.open(map, center);
            }
        };
        </script>
 
</body>
</html>