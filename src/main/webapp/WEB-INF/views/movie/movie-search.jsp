<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>movie search</title>
	<link href="${pageContext.request.contextPath}/resources/static/css/style.css" type="text/css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/static/css/movie/movie-search.css" type="text/css" rel="stylesheet"/>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		const apiKey = '6446e4279ac4b8a7c13210bd72bb0c2b';
		const contextPath = '${pageContext.request.contextPath}';
		var currentPage = 1; // 현재 페이지 전역 변수
		console.log(contextPath)
		$(document).ready(function(){
			
			
			searchBtnClick()
			menu()
		})
		
		 function menu(){
        	alert('menu!')
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
		
		function searchBtnClick(){
			$('#search-btn').click(function(){
				const movieNm = $('#movieNm').val().trim();
				const directorNm = $('#directorNm').val().trim();
				const openStartDt = $('#openStartDt').val().trim();

				// 최소한 한 가지는 입력해야 요청
				if(!movieNm && !directorNm && !openStartDt){
					alert('영화명, 감독명, 개봉연도 중 하나 이상 입력해주세요.');
					return;
				}

				getMovieSearchData(currentPage, movieNm, directorNm, openStartDt);
			});
		}
		
		function getMovieSearchData(currentPage,movieNm, directorNm, openStartDt){
			let url = 'http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?itemPerPage=20&key=' + apiKey;
			
			if(currentPage) url += '&curPage=' + encodeURIComponent(currentPage);
			if(movieNm) url += '&movieNm=' + encodeURIComponent(movieNm);
			if(directorNm) url += '&directorNm=' + encodeURIComponent(directorNm);
			if(openStartDt) url += '&openStartDt=' + encodeURIComponent(openStartDt);

			console.log('Request URL:', url);

			$.ajax({
			    type : 'get',  
			    url : url,
			    async : true,  
			    dataType : 'json', 
			    success : function(result) {
			        console.log(result);
			        const movieList = result.movieListResult.movieList;
			        const totalCnt = result.movieListResult.totCnt
		            console.log('영화 목록:', movieList);
		            $('#movie-search-result').empty()
		            movieList.forEach(movie => {
		                searchAndMakeMoviePoster(movie); // TMDb에서 포스터 검색
		            });
		            
		            renderPagination(totalCnt, 20, currentPage)
			    },
			    error : function(request, status, error) { 
			        console.log(error);
			    }
			})
		}

		
		function searchAndMakeMoviePoster(movieData) {
			const title = movieData.movieNm;
		    const TMDB_API_KEY = '23563aa555ef57d437fca235f2f582e9';
		    const tmdbUrl = 'https://api.themoviedb.org/3/search/movie?api_key=' + TMDB_API_KEY + '&query=' + encodeURIComponent(title) + '&language=ko-KR';
		    const defaultPosterUrl = contextPath + '/resources/static/images/movie/no-poster.png';
		    const openDt = movieData.openDt;
            var openDtFormatted = '개봉일 정보 없음';

            if (openDt && openDt.length === 8) {
              openDtFormatted =
                openDt.slice(0, 4) + '년 ' +
                openDt.slice(4, 6) + '월 ' +
                openDt.slice(6, 8) + '일';
            }
            
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
						console.log('defaultPosterUrl')
						console.log(defaultPosterUrl)
						
						
						
		                // DOM에 이미지 출력
						$('#movie-search-result').append(
							    '<a href="/cms/movie/movie-detail?movieCd=' + movieData.movieCd + '" class="movie-item">' +
							        // 영화 포스터
							        '<img src="' + fullPosterUrl + '" alt="' + movieData.movieNm + '">' +

							        // 영화 제목
							        '<p title="'+movieData.movieNm+'">' + movieData.movieNm + '</p>' +

							        // 개봉일
							        '<p>개봉일: ' + openDtFormatted + '</p>' +
							    '</a>'
						);
		                
		            } else {
		            	$('#movie-search-result').append(
							    '<a href="/cms/movie-detail?movieCd=' + movieData.movieCd + '" class="movie-item">' +
							        // 영화 포스터
							        '<img src="' + defaultPosterUrl + '" alt="' + movieData.movieNm + '">' +

							        // 영화 제목
							        '<p title="'+movieData.movieNm+'">' + movieData.movieNm + '</p>' +

							        // 개봉일
							        '<p>개봉일: ' + openDtFormatted + '</p>' +
							    '</a>'
						);
		            }
		        },
		        error: function (request, status, error) {
		            console.log('TMDB 오류:', error);
		        }
		    });
		}
		
		function renderPagination(totalCnt, itemsPerPage, currentPage) {
		    const totalPages = Math.ceil(totalCnt / itemsPerPage);
		    const pageBlockSize = 10;

		    const currentBlock = Math.floor((currentPage - 1) / pageBlockSize);
		    const startPage = currentBlock * pageBlockSize + 1;
		    const endPage = Math.min(startPage + pageBlockSize - 1, totalPages);

		    let html = '';
		    $('#pagination').html(html);
		    // 이전 블록
		    if (startPage > 1) {
		        html += '<button class="page-btn" data-page="prev-block">&lt;&lt;</button>';
		    }
		    if (currentPage > 1){
		    	html += '<button class="page-btn" data-page="prev">&lt;</button>';
		    }

		    // 페이지 버튼
		    for (let i = startPage; i <= endPage; i++) {
		        const activeClass = (i === currentPage) ? 'active' : '';
		        html += '<button class="page-btn ' + activeClass + '" data-page="' + i + '">' + i + '</button>';
		    }

		    // 다음 블록
		    if (endPage < totalPages) {
		    	html += '<button class="page-btn" data-page="next">&gt;</button>';
		        html += '<button class="page-btn" data-page="next-block">&gt;&gt;</button>';
		    }

		    $('#pagination').html(html);

		    setupPaginationClickHandler(totalCnt, itemsPerPage);
		}
		
		function setupPaginationClickHandler(totalCnt, itemsPerPage) {
			//이벤트 중복제거하고 또 등록함
			$('#pagination').off('click').on('click', '.page-btn', function () {
			    const page = $(this).data('page');
			    const totalPages = Math.ceil(totalCnt / itemsPerPage);

			    if (page === 'prev') {
			      if (currentPage > 1) {
			        currentPage--;
			        renderPagination(totalCnt, itemsPerPage, currentPage);
			        
			        const movieNm = $('#movieNm').val().trim();
					const directorNm = $('#directorNm').val().trim();
					const openStartDt = $('#openStartDt').val().trim();

					// 최소한 한 가지는 입력해야 요청
					if(!movieNm && !directorNm && !openStartDt){
						alert('영화명, 감독명, 개봉연도 중 하나 이상 입력해주세요.');
						return false;
					}
					
					getMovieSearchData(currentPage, movieNm, directorNm, openStartDt);
			      }
			    } else if (page === 'prev-block') {
			      if (currentPage < totalPages) {
			    	const pageBlockSize = 10; // 페이지 블록 크기

			    	// 현재 블록 번호 계산 (0부터 시작)
			    	const currentBlock = Math.floor((currentPage - 1) / pageBlockSize);

			    	// 이전 블록이 있으면 그 블록의 첫 페이지
			    	if (currentBlock > 0) {
			    	  currentPage = (currentBlock - 1) * pageBlockSize + 1;
			    	} else {
			    	  // 이미 첫 블록이면 첫 페이지로 유지
			    	  currentPage = 1;
			    	}
			    	
			        renderPagination(totalCnt, itemsPerPage, currentPage);
			        
			        const movieNm = $('#movieNm').val().trim();
					const directorNm = $('#directorNm').val().trim();
					const openStartDt = $('#openStartDt').val().trim();

					// 최소한 한 가지는 입력해야 요청
					if(!movieNm && !directorNm && !openStartDt){
						alert('영화명, 감독명, 개봉연도 중 하나 이상 입력해주세요.');
						return false;
					}

					getMovieSearchData(currentPage, movieNm, directorNm, openStartDt);
			      }
				}
			    else if (page === 'next') {
			      if (currentPage < totalPages) {
			        currentPage++;
			        renderPagination(totalCnt, itemsPerPage, currentPage);
			        
			        const movieNm = $('#movieNm').val().trim();
					const directorNm = $('#directorNm').val().trim();
					const openStartDt = $('#openStartDt').val().trim();

					// 최소한 한 가지는 입력해야 요청
					if(!movieNm && !directorNm && !openStartDt){
						alert('영화명, 감독명, 개봉연도 중 하나 이상 입력해주세요.');
						return false;
					}

					getMovieSearchData(currentPage, movieNm, directorNm, openStartDt);
			      }
			    } 
			    else if (page === 'next-block') {
			    	  const pageBlockSize = 10;
			    	  const totalPages = Math.ceil(totalCnt / itemsPerPage);
			    	  const currentBlock = Math.floor((currentPage - 1) / pageBlockSize);
			    	  const maxBlock = Math.floor((totalPages - 1) / pageBlockSize);

			    	  if (currentBlock < maxBlock) {
			    	    currentPage = (currentBlock + 1) * pageBlockSize + 1;
			    	    if (currentPage > totalPages) currentPage = totalPages;

			    	    renderPagination(totalCnt, itemsPerPage, currentPage);

			    	    const movieNm = $('#movieNm').val().trim();
						const directorNm = $('#directorNm').val().trim();
						const openStartDt = $('#openStartDt').val().trim();

						// 최소한 한 가지는 입력해야 요청
						if(!movieNm && !directorNm && !openStartDt){
							alert('영화명, 감독명, 개봉연도 중 하나 이상 입력해주세요.');
							return false;
						}

			    	    getMovieSearchData(currentPage, movieNm, directorNm, openStartDt);
			    	  }
			    }

			    else {
			    	alert('특정 페이지!')
			      const selectedPage = parseInt(page);
			      if (selectedPage !== currentPage) {
			        currentPage = selectedPage;
			        renderPagination(totalCnt, itemsPerPage, currentPage);
					
			        const movieNm = $('#movieNm').val().trim();
					const directorNm = $('#directorNm').val().trim();
					const openStartDt = $('#openStartDt').val().trim();

					// 최소한 한 가지는 입력해야 요청
					if(!movieNm && !directorNm && !openStartDt){
						alert('영화명, 감독명, 개봉연도 중 하나 이상 입력해주세요.');
						return false;
					}
			        
					getMovieSearchData(currentPage, movieNm, directorNm, openStartDt);
			      }
			    }
			  });
			}
			

		
	</script>
</head>
<body>
	<div id="movie-search-wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div id="movie-main">
			<h1>영화 검색</h1>
			<div id="movie-search-box">
				<input type="text" id="movieNm" placeholder="영화명"/>
				<input type="text" id="directorNm" placeholder="감독명"/>
				<input type="text" id="openStartDt" placeholder="개봉연도(YYYY)"/>
				<button id="search-btn">검색</button>
			</div>
			<!-- 결과 렌더링 영역 -->
			<div id="movie-search-result">
				<img src="${pageContext.request.contextPath}/resources/static/images/movie/movie-icon.png" id="default-movie-icon"/>
			</div>
	
			<!-- 페이지네이션 -->
			<div id="pagination"></div>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>
