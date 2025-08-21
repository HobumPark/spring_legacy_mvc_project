<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>movie search</title>
	<link href="${pageContext.request.contextPath}/resources/static/css/style.css" type="text/css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/static/css/movie/movie-detail.css" type="text/css" rel="stylesheet"/>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
	<script>
		const contextPath = '${pageContext.request.contextPath}';
	
		$(document).ready(function(){
			const urlParams = new URLSearchParams(window.location.search);
			const movieCd = urlParams.get('movieCd');
			console.log(movieCd); // 예: 20227979
			
			getMovieDetailData(movieCd)	
			menu()
		})


		function getMovieDetailData(movieCd){
		    console.log('getMovieDetailData')
		    const apiKey = '6446e4279ac4b8a7c13210bd72bb0c2b';
		    const targetDate = '20241111'; // 필요에 따라 변수로 빼서 동적으로 넣어도 됨
		    const url = 'http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?'
		    		+'key='+apiKey 
		    		+'&movieCd='+movieCd;
			console.log(url)
		    $.ajax({
		        type: 'get',
		        url: url,
		        async: true,
		        dataType: 'json',
		        success: function(result){
		            console.log(result);
		           	const movie = result.movieInfoResult.movieInfo;
		           	
		           	const year = movie.openDt.substring(0, 4);
		           	const month = movie.openDt.substring(4, 6);
		           	const day = movie.openDt.substring(6, 8);
		           	const formattedDate = year + "년 " + month + "월 " + day + "일";
		           	var movieOpenDt = '-';
		           	if (movie.openDt && movie.openDt.length === 8) {
		           	  const year = movie.openDt.substring(0, 4);
		           	  const month = movie.openDt.substring(4, 6);
		           	  const day = movie.openDt.substring(6, 8);
		           	  movieOpenDt = year + "년 " + month + "월 " + day + "일";
		           	}
		           	const nations = movie.nations && movie.nations.length > 0? movie.nations.map(n => n.nationNm).join(", "): '-';
		           	const movieCompany = movie.companys && movie.companys.length > 0? movie.companys[0].companyNm : '-';
		            const movieGrade = movie.audits && movie.audits.length > 0? movie.audits[0].watchGradeNm : '등급 미정';
		           	const color = getGradeColor(movieGrade);
		           	const genreList = movie.genres && movie.genres.length > 0? movie.genres.map(g => g.genreNm).join(", "): '-';
		           	const showType1 = movie.showTypes && movie.showTypes.length > 0? movie.showTypes[0].showTypeGroupNm : '-';
		           	const showType2 = movie.showTypes && movie.showTypes.length > 0? movie.showTypes[0].showTypeNm : '-';
		           	const movieActors = movie.actors;
		           			          
		           	$("#movie-title").text("🎬 " + movie.movieNm);
		            $("#movie-title-en").text("영문 제목: " + (movie.movieNmEn || "-"));
		            $("#movie-grade").html('관람등급: <b style="color:' + color + ';">' + movieGrade + '</b>');
		            $("#movie-genre").text("장르: " + genreList);
		            $('#movie-year-open').text("제작년도: " + movie.prdtYear + "년 / 개봉일: " + movieOpenDt);
		            $("#movie-nation").text("국가: " + nations);
		            $("#movie-showtm").text("상영 시간: " + (movie.showTm || '-') + "분");
		            $("#movie-status").text("제작 상태: " + movie.prdtStatNm);
		            $("#movie-maker").text("제작사: " + movieCompany);
		            $("#movie-show-type").text("상영형태: "+showType1+"/"+showType2);
		            
		            $("#movie-actor").empty(); // 기존 내용 비우기

		            movieActors.forEach(function(actor) {
		            	  const cast = actor.cast || "배역 미상";
		            	  const peopleNm = actor.peopleNm || "이름 미상";

		            	  var actorInfo =
		            		    '<div class="actor">' +
		            		      '<span>' + cast + ' 역</span>' +
		            		      '<span>' + peopleNm + '</span>' +
		            		    '</div>';

		                 $("#movie-actor").append(actorInfo);
		            	});
		            
		            getMoviePoster(movie); // TMDb에서 포스터 검색
     
		        },
		        error: function(request, status, error){
		            console.log(error);
		        }
		    })
		}
		
		function getMoviePoster(movieData) {
			const title = movieData.movieNm;
		    const TMDB_API_KEY = '23563aa555ef57d437fca235f2f582e9';
		    const tmdbUrl = 'https://api.themoviedb.org/3/search/movie?api_key=' + TMDB_API_KEY + '&query=' + encodeURIComponent(title) + '&language=ko-KR';
		    const defaultPosterUrl = contextPath + '/resources/static/images/movie/no-poster.png';
		    
		    $.ajax({
		        type: 'get',
		        url: tmdbUrl,
		        async: true,
		        dataType: 'json',
		        success: function (result) {
					console.log(result)
					const posterPath = result?.results?.[0]?.poster_path; // 안전하게 접근
					const defaultPosterUrl = contextPath + '/resources/static/images/movie/no-poster.png';
					
					const fullPosterUrl = (posterPath && posterPath.trim() !== '')
					  ? 'https://image.tmdb.org/t/p/w500' + posterPath
					  : defaultPosterUrl;
					
					console.log('fullPosterUrl:', fullPosterUrl);
					$("#movie-poster>img").attr("src", fullPosterUrl);
		        },
		        error: function (request, status, error) {
		            console.log('TMDB 오류:', error);
		        }
		    });
		}
		
		function getGradeColor(grade) {
		    if (grade.includes("전체")) return "green";
		    if (grade.includes("12")) return "blue";
		    if (grade.includes("15")) return "orange";
		    if (grade.includes("19") || grade.includes("청소년")) return "red";
		    return "black";
		}
		
		function menu(){
            $("#gnb>li").on({
                "mouseover":function(){
                    console.log("mouseover")
                    $(this).find('.lnb').stop().slideDown()
                },
                "mouseout":function(){
                    $(".lnb").stop().slideUp()
                }
            })
        }
	</script>
</head>
<body>
	<div id="movie-box-office-wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div id="movie-main">
			<h1>영화정보</h1>
			<div id="movie-detail">
				<div id="movie-poster">
					<img src=""/>
				</div>
				<div id="movie-info">
					<div id="movie-title" class="info-item"></div>
					<div id="movie-title-en" class="info-item"></div>
					<div id="movie-grade" class="info-item"></div>
					<div id="movie-genre" class="info-item"></div>
					<div id="movie-year-open" class="info-item"></div>
					<div id="movie-nation" class="info-item"></div>
					<div id="movie-showtm" class="info-item"></div>
					<div id="movie-status" class="info-item"></div>
					<div id="movie-maker" class="info-item"></div>
					<div id="movie-show-type" class="info-item"></div>
				</div>
			</div>
			<div id="movie-actor">
			
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>