<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/static/css/style.css" type="text/css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/static/css/fun-contents/open-weather-api-page.css" type="text/css" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
<script>
	$(document).ready(function() {
		searchBtnClick()
	})
	
	function getWeatherData(city,apiKey){
		$.ajax({
	        method: 'get',
	        url: "https://api.openweathermap.org/data/2.5/weather?q=" + city + ",kor&APPID=" + apiKey,
	        dataType: 'json'
	    }).done(function(response) {
	        console.log(response); // Object
	        console.log(response.main.temp); // e.g., 283
	        const celsius = response.main.temp - 273.1;
	        $("#temp-div").text(celsius);
	    });
	}
	function searchBtnClick(){
		$("#search-btn").on('click', function() {
		    const apiKey = "a0cd335023e5654308fd81198ce68f9c";
		    var city = $("#city-input").val();
		    getWeatherData(city,apiKey)
		});
	}
</script>
</head>
<body>
	<div id="open-weather-wrap">
		<div id="input-wrap">
			<input type="text" value=""/>
			<button id="search-btn">검색</button>
		</div>
		<div id="contents-wrap">
			<div id="weather-result">
				<div id="weather-row-01">
				
				</div>
				<div id="weather-row-02">
					<span></span>
					<span></span>
					<span></span>
				</div>
			</div>
		</div>
	</div>
</body>
</html>