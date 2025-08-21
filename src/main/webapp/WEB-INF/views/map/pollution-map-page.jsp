<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pollution Map</title>

<!-- Leaflet.js CSS -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css"/>

<link href="${pageContext.request.contextPath}/resources/static/css/style.css" type="text/css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/static/css/map/pollution-map-page.css" type="text/css" rel="stylesheet"/>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>

<!-- Leaflet.js JS -->
<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>

<script>
	$(document).ready(function() {
		initLeafletMap()
	});
	
	function initLeafletMap(){
		// 지도 표시할 div 선택
		var mapContainer = document.getElementById('pollution-map-page-wrap');

		// 지도 초기화
		var map = L.map(mapContainer).setView([37.5665, 126.9780], 13); // 서울 중심 좌표, 확대 레벨 13

		// OpenStreetMap 타일 레이어 추가
		L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
			attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
		}).addTo(map);

		// 예시 마커 추가
		L.marker([37.5665, 126.9780]).addTo(map)
			.bindPopup("<b>Seoul</b><br/>This is the center of Seoul.")
			.openPopup();
		
		// GeoJSON 데이터 로드
		loadSeoulGeoJSONData(map);
		loadSeoulCenterJSONData(map);
	}
	
	// GeoJSON 데이터를 로드하여 지도에 추가하는 함수
	function loadSeoulGeoJSONData(map) {
    	// Ajax로 JSON 파일 로드
	    $.ajax({
	        url: '${pageContext.request.contextPath}/resources/static/json/seoul_municipalities_geo_simple.json',  // JSON 파일 경로
	        dataType: 'json',
	        success: function(data) {
	            console.log('GeoJSON Data Loaded:');
	            console.log(data);
	            
	            // GeoJSON의 features 배열을 가져오기
	            var features = data.features;
	            
	            // 경로를 그릴 좌표 배열
	            var pathCoordinates = [];
	            
	            // 각 feature에서 좌표를 추출하여 마커를 추가하고, 선을 그을 좌표를 저장
	            features.forEach(function(feature) {
	                var coordinates = feature.geometry.coordinates[0];  // GeoJSON의 좌표 배열
	                
	                coordinates.forEach(function(coord) {
	                    var lat = coord[1];  // 위도
	                    var lng = coord[0];  // 경도
	                    
	                    // 경로를 위한 좌표 배열에 추가
	                    pathCoordinates.push([lat, lng]);
	                });
	             	// 선을 그리기 (경로를 이어서 선을 그린다)
		            L.polygon(pathCoordinates, { color: 'blue' }).addTo(map);
		            pathCoordinates=[]
	            });
	            
	            
	        },
	        error: function(xhr, status, error) {
	            console.log('JSON 파일 로드 오류:', error);
	        }
	    });
	}
	
	function loadSeoulCenterJSONData(map){
	    $.ajax({
	        url: '${pageContext.request.contextPath}/resources/static/json/seoul_district_center.json',  // JSON 파일 경로
	        dataType: 'json',
	        success: function(data) {
	            console.log('Center Data Loaded:');
	            console.log(data);
	            
	            // GeoJSON의 features 배열을 가져오기
	            var features = data.features;

	            // 각 feature에서 좌표를 추출하여 마커를 추가
	            features.forEach(function(feature) {
	                var coordinates = feature.geometry.coordinates;  // GeoJSON의 좌표 배열
	                var lat = coordinates[1];  // 위도
	                var lng = coordinates[0];  // 경도
	                var name = feature.properties.name;  // 구 이름

	                // 마커를 지도에 추가하고, 구 이름을 팝업으로 표시
	                L.marker([lat, lng]).addTo(map)
	                    .bindPopup("<b>" + name + "</b><br/>This is " + name)
	                    .openPopup();
	            });
	        },
	        error: function(xhr, status, error) {
	            console.log('JSON 파일 로드 오류:', error);
	        }
	    });
	}

</script>
</head>
<body>
	<div id="pollution-map-page-wrap">
	
	</div>
</body>
</html>
