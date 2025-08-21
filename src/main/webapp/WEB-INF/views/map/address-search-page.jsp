<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대구 동성로 지도</title>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>

</head>
<body>
	<!-- 지도가 표시될 div -->
	<div id="address-search-page-wrap" style="width:100%; height:500px;"></div>

	<!-- 카카오 지도 API (비동기 로딩을 확실히 처리) -->
	<script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=3a56e34811149329c6c86d9f12089fa6&autoload=true"></script>

	<script>
		$(document).ready(function() {
			// 카카오 지도 API가 로드되면 실행
			kakao.maps.load(function() {
				var mapContainer = document.getElementById('address-search-page-wrap'), // 지도를 표시할 div
					mapOption = { 
						center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심 좌표
						level: 3 // 지도의 확대 레벨
					};
				
				// 지도를 표시할 div와 지도 옵션으로 지도를 생성합니다.
				var map = new kakao.maps.Map(mapContainer, mapOption); 
			});
		});
	</script>
</body>
</html>
