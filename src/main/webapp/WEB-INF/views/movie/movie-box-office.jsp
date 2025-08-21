<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>movie search</title>
	<link href="${pageContext.request.contextPath}/resources/static/css/style.css" type="text/css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/static/css/movie/movie-box-office.css" type="text/css" rel="stylesheet"/>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
	<script>
	
		const kbisApiKey = '${kbisApiKey}';
	  	console.log("kbisApiKey:", kbisApiKey);
	  	
	  	const tmdbApiKey = '${tmdbApiKey}';
	  	console.log("tmdbApiKey:", tmdbApiKey);
	  	
		$(document).ready(function(){
			menu()
			getMovieBoxOfficeData()	
		})
		
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


		function getMovieBoxOfficeData(){
		    console.log('getMovieBoxOfficeData')
		    const apiKey = '6446e4279ac4b8a7c13210bd72bb0c2b';
		    
		    const today = new Date();
		    const year = today.getFullYear();
		    const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작
		    const day = String(today.getDate()-1).padStart(2, '0');
		    const targetDate = year + month + day; // "YYYYMMDD"
		    const formattedDate = year + '년 ' + month + '월 ' + day + '일';
		    $('h1').append(' (' + formattedDate + ')');
		    
		    const url = 'http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=' + apiKey + '&targetDt=' + targetDate;
		
		    $.ajax({
		        type: 'get',
		        url: url,
		        async: true,
		        dataType: 'json',
		        success: function(result){
		            console.log(result);
		            const movieList = result.boxOfficeResult.dailyBoxOfficeList;
		            console.log('영화 목록:', movieList);
		            
		         	// 순차적으로 실행할 Promise 체이닝
		            let promise = Promise.resolve(); // 시작은 이미 해결된 Promise로 설정

		            movieList.forEach(movie => {
		                promise = promise.then(() => searchAndMakeMoviePoster(movie)); // 이전 Promise가 완료되면 다음을 실행
		            });
		            //$("#movie-main").bxSlider()
		            
		        },
		        error: function(request, status, error){
		            console.log(error);
		        }
		    })
		}
		
		function searchAndMakeMoviePoster(movieData) {
			const title = movieData.movieNm;
		    const TMDB_API_KEY = '23563aa555ef57d437fca235f2f582e9';
		    const tmdbUrl = 'https://api.themoviedb.org/3/search/movie?api_key=' + TMDB_API_KEY + '&query=' + encodeURIComponent(title) + '&language=ko-KR';

		    $.ajax({
		        type: 'get',
		        url: tmdbUrl,
		        async: true,
		        dataType: 'json',
		        success: function (result) {
		            if (result.results && result.results.length > 0) {
		                const movie = result.results[0];
		                const posterPath = movie.poster_path;
		                const fullPosterUrl = 'https://image.tmdb.org/t/p/w500' + posterPath;
		                console.log('fullPosterUrl')
						console.log(fullPosterUrl)
		                // DOM에 이미지 출력
						$('#movie-main').append(
							    '<a href="/cms/movie-detail?movieCd=' + movieData.movieCd + '" class="movie-item" style="position: relative; display: inline-block; margin: 10px; text-decoration: none; color: inherit;">' +
							        // 랭킹 박스 (좌상단)
							        '<div style="position: absolute; top: 0; left: 0; background: rgba(255,0,0,0.8); color: white; padding: 4px 8px; font-weight: bold; font-size: 14px; border-bottom-right-radius: 8px;">' +
							            movieData.rank +
							        '</div>' +

							        // 영화 포스터
							        '<img src="' + fullPosterUrl + '" alt="' + movie.title + '" style="width: 200px; height: auto; display: block;">' +

							        // 영화 제목
							        '<p style="margin: 6px 0 2px; font-weight: bold; font-size: 16px;">' + movie.title + '</p>' +

							        // 개봉일
							        '<p style="margin: 0; color: gray; font-size: 14px;">개봉일: ' + movieData.openDt + '</p>' +
							    '</a>'
						);
		                
		            } else {
		                $('#movie-main').append(`<p>${title} - 이미지 없음</p>`);
		            }
		        },
		        error: function (request, status, error) {
		            console.log('TMDB 오류:', error);
		        }
		    });
		}
	</script>
</head>
<body>
	<div id="movie-box-office-wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<h1>박스오피스 순위</h1>
		<div id="movie-main" class="movie-slider">
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>