<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>movie search</title>
	<link href="${pageContext.request.contextPath}/resources/static/css/style.css" type="text/css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/static/css/movie/movie-actor-detail.css" type="text/css" rel="stylesheet"/>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
	<script>
		const contextPath = '${pageContext.request.contextPath}';
	
		$(document).ready(function(){
			const urlParams = new URLSearchParams(window.location.search);
			const peopleCd = urlParams.get('peopleCd');//영화진흥 API 코드
			const personId = urlParams.get('personId');//TMDB용 ID
			console.log(peopleCd,personId); // 예: 20227979
			
			getMovieDetailData(peopleCd,personId)	
			menu()
		})


		function getMovieDetailData(peopleCd,personId){
		    console.log('getMovieDetailData')
		    const apiKey = '6446e4279ac4b8a7c13210bd72bb0c2b';
		    const targetDate = '20241111'; // 필요에 따라 변수로 빼서 동적으로 넣어도 됨
		    const url = 'http://www.kobis.or.kr/kobisopenapi/webservice/rest/people/searchPeopleInfo.json?'
		    		+'key='+apiKey 
		    		+'&peopleCd='+peopleCd;
			console.log(url)
		    $.ajax({
		        type: 'get',
		        url: url,
		        async: true,
		        dataType: 'json',
		        success: function(result){
		            console.log(result);
		           	const peopleData = result.peopleInfoResult.peopleInfo;
		           	const peopleNm = peopleData.peopleNm;
		           	const peopleNmEn = peopleData.peopleNmEn;
		           	const repRoleNm = peopleData.repRoleNm;
		           	const sex = peopleData.sex;
		           	const filmos = peopleData.filmos;
	          
		           	$("#movie-actor-kor-name").text("한글 이름 " + peopleNm);
		            $("#movie-actor-eng-name").text("영어 이름: " + peopleNmEn);
		            $("#movie-actor-sex").text("성별: " + sex);
		            $("#movie-actor-role").text("역할: " + repRoleNm);

		         	// 필모그래피 영역에 영화 목록 추가
		            let filmListHtml = '<ul>';  // 목록 시작
		            filmos.forEach(function(film) {
		                filmListHtml += 
		                	'<div class="movie-filmo-item">'+
		                		'<span class="movie-title">'+film.movieNm+'-</span>'+
		                		'<span class="movie-role">' +film.moviePartNm +'</span>'+
		                	'</div>';  // 영화 제목과 역할을 span으로 감싸서 가로 배치
		            });
		            filmListHtml += '</ul>';  // 목록 끝

		            $("#movie-actor-filmos").html(filmListHtml);  // HTML 영역에 목록 삽입
		            
		            $("#movie-actor").empty(); // 기존 내용 비우기
					
		            getMoviePoster(peopleData,personId); // TMDb에서 포스터 검색
		            getActorImageList(peopleData,personId);
		        },
		        error: function(request, status, error){
		            console.log(error);
		        }
		    })
		}
		
		function getMovieDetailData(peopleCd, personId) {
		    console.log('getMovieDetailData');
		    const apiKey = '6446e4279ac4b8a7c13210bd72bb0c2b';
		    const targetDate = '20241111'; // 필요에 따라 변수로 빼서 동적으로 넣어도 됨
		    const url = 'http://www.kobis.or.kr/kobisopenapi/webservice/rest/people/searchPeopleInfo.json?'
		        + 'key=' + apiKey
		        + '&peopleCd=' + peopleCd;
		    console.log(url);

		    $.ajax({
		        type: 'get',
		        url: url,
		        async: true,
		        dataType: 'json',
		        success: function (result) {
		            console.log(result);
		            if (result.peopleInfoResult && result.peopleInfoResult.peopleInfo) {
		                const peopleData = result.peopleInfoResult.peopleInfo;
		                const peopleNm = peopleData.peopleNm;
		                const peopleNmEn = peopleData.peopleNmEn;
		                const repRoleNm = peopleData.repRoleNm;
		                const sex = peopleData.sex;
		                const filmos = peopleData.filmos;

		                $("#movie-actor-kor-name").text("한글 이름 " + peopleNm);
		                $("#movie-actor-eng-name").text("영어 이름: " + peopleNmEn);
		                $("#movie-actor-sex").text("성별: " + sex);
		                $("#movie-actor-role").text("역할: " + repRoleNm);

		                // 필모그래피 영역에 영화 목록 추가
		                let filmListHtml = '<ul>';  // 목록 시작
		                filmos.forEach(function (film) {
		                    filmListHtml +=
		                        '<div class="movie-filmo-item">' +
		                        '<span class="movie-title">' + film.movieNm + '-</span>' +
		                        '<span class="movie-role">' + film.moviePartNm + '</span>' +
		                        '</div>';  // 영화 제목과 역할을 span으로 감싸서 가로 배치
		                });
		                filmListHtml += '</ul>';  // 목록 끝

		                $("#movie-actor-filmos").html(filmListHtml);  // HTML 영역에 목록 삽입

		                $("#movie-actor").empty(); // 기존 내용 비우기

		                getMoviePoster(peopleData, personId); // TMDb에서 포스터 검색
		                getActorImageList(peopleData, personId);
		            } else {
		                console.log('API 데이터가 없습니다.');
		                // 데이터가 없으면 UI를 업데이트하지 않거나, 이전 데이터 그대로 유지
		            }
		        },
		        error: function (request, status, error) {
		            console.log('API 호출 실패:', error);
		            // 오류가 발생하면 UI를 변경하지 않고, 오류 로그만 출력
		            // 필요한 경우, 오류 메시지나 대체 데이터를 화면에 표시할 수 있음.
		        }
		    });
		}

		
		function getActorImageList(peopleData,personId) {
			const peopleNm = peopleData.peopleNm;
		    const TMDB_API_KEY = '23563aa555ef57d437fca235f2f582e9';
		    const tmdbUrl = 'https://api.themoviedb.org/3/person/'+personId+'/images?api_key=' + TMDB_API_KEY + '&language=ko-KR';
		    const defaultPosterUrl = contextPath + '/resources/static/images/movie/no-poster.png';
		    
		    $.ajax({
		        type: 'get',
		        url: tmdbUrl,
		        async: true,
		        dataType: 'json',
		        success: function (result) {
		        	console.log('getActorImages result')
					console.log(result)
					const profiles=result.profiles
					let fullImg = '';  // 목록 시작
					
					profiles.forEach(function(profile) {
						const fullImgSrc='https://image.tmdb.org/t/p/w500' + profile.file_path
		                fullImg += 
		                	'<img src="'+fullImgSrc+'"/>'
		            });
 
					$("#movie-actor-image-list").append(fullImg)
					
					changeProfileImageByHover()
		        },
		        error: function (request, status, error) {
		            console.log('TMDB 오류:', error);
		        }
		    });
		}
		
		function changeProfileImageByHover(){
			$("#movie-actor-image-list>img").on("mouseover",function(){
				const imgSrc=$(this).attr('src')
				console.log('imgSrc:'+imgSrc)
				$("#movie-actor-poster>img").attr('src',imgSrc)
			})
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
		<div id="movie-actor-main">
			<h1>영화인 정보</h1>
			<div id="movie-actor-detail">
				<div id="movie-actor-poster">
					<img src=""/>
					<div id="movie-actor-image-list">
					
					</div>
				</div>
				<div id="movie-actor-info">
					<div id="movie-actor-kor-name" class="info-item"></div>
					<div id="movie-actor-eng-name" class="info-item"></div>
					<div id="movie-actor-birthday" class="info-item"></div>
					<div id="movie-actor-deathday" class="info-item"></div>
					<div id="movie-actor-popularity" class="info-item"></div>
					<div id="movie-actor-sex" class="info-item"></div>
					<div id="movie-actor-role" class="info-item"></div>
					<section id="movie-actor-filmos" class="filmo-item">	
					</section>
				</div>
			</div>
			<div id="movie-actor">
			
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>