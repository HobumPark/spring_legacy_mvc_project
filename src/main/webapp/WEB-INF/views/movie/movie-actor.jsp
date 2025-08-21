<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>movie search</title>
	<link href="${pageContext.request.contextPath}/resources/static/css/style.css" type="text/css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/static/css/movie/movie-actor.css" type="text/css" rel="stylesheet"/>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		const apiKey = '6446e4279ac4b8a7c13210bd72bb0c2b';
		const contextPath = '${pageContext.request.contextPath}';
		var currentPage = 1; // 현재 페이지 전역 변수
		console.log(contextPath)
		
		$(document).ready(function(){
			searchBtnClick()
			enterKeyPress()
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
				const peopleNm = $('#peopleNm').val().trim();
				const filmoNames = $('#filmoNames').val().trim();

				// 최소한 한 가지는 입력해야 요청
				if(!peopleNm && !filmoNames){
					alert('배우이름, 필모리스트 중 하나 이상 입력해주세요.');
					return;
				}

				getMovieSearchData(currentPage, peopleNm, filmoNames);
			});
		}
		
		function enterKeyPress(){
			$(document).on('keydown',function(e){
				if(e.keyCode==13){
					const peopleNm = $('#peopleNm').val().trim();
					const filmoNames = $('#filmoNames').val().trim();

					// 최소한 한 가지는 입력해야 요청
					if(!peopleNm && !filmoNames){
						alert('배우이름, 필모리스트 중 하나 이상 입력해주세요.');
						return;
					}

					getMovieSearchData(currentPage, peopleNm, filmoNames);
				}
			})
		}
		
		function getMovieSearchData(currentPage, peopleNm, filmoNames){
			let url = 'http://www.kobis.or.kr/kobisopenapi/webservice/rest/people/searchPeopleList.json?itemPerPage=20&key=' + apiKey;
			
			if(currentPage) url += '&curPage=' + encodeURIComponent(currentPage);
			if(peopleNm) url += '&peopleNm=' + encodeURIComponent(peopleNm);
			if(filmoNames) url += '&filmoNames=' + encodeURIComponent(filmoNames);


			console.log('Request URL:', url);

			$.ajax({
			    type : 'get',  
			    url : url,
			    async : true,  
			    dataType : 'json', 
			    success : function(result) {
			        console.log(result);
			        const peopleList = result.peopleListResult.peopleList;
			        const totalCnt = result.peopleListResult.totCnt
		            console.log('영화인 목록:', peopleList);
		            $('#movie-actor-search-result').empty()
		            peopleList.forEach(people => {
		                searchAndMakeMovieActor(people); // TMDb에서 포스터 검색
		            });
		            
		            renderPagination(totalCnt, 20, currentPage)
			    },
			    error : function(request, status, error) { 
			        console.log(error);
			    }
			})
		}

		
		function searchAndMakeMovieActor(peopleData) {
			const peopleNm = peopleData.peopleNm;
			const peopleCd = peopleData.peopleCd;
		    const TMDB_API_KEY = '23563aa555ef57d437fca235f2f582e9';
		    const tmdbUrl = 'https://api.themoviedb.org/3/search/person?api_key=' + TMDB_API_KEY + '&query=' + encodeURIComponent(peopleNm) + '&language=ko-KR';
		    const defaultPosterUrl = contextPath + '/resources/static/images/movie/no-poster.png';
		   
            
		    $.ajax({
		        type: 'get',
		        url: tmdbUrl,
		        async: true,
		        dataType: 'json',
		        success: function (result) {
		        	console.log('searchAndMakeMovieActor')
		        	console.log(result)
		        	const people = result.results[0];
		            const profilePath = people.profile_path;
		            const id = people.id;
		            
		            if (people.profile_path != null) {
		                
		                const fullPosterUrl = 'https://image.tmdb.org/t/p/w500' + profilePath;
		               
		                
		                console.log('fullPosterUrl')
						console.log(fullPosterUrl)
						console.log('defaultPosterUrl')
						console.log(defaultPosterUrl)
						
						
						
		                // DOM에 이미지 출력
						$('#movie-actor-search-result').append(
							    '<a href="/cms/movie/movie-actor-detail?peopleCd=' + peopleCd +'&personId='+id+'" class="people-item">' +
							        // 영화 포스터
							        '<img src="' + fullPosterUrl + '" alt="' + peopleNm + '">' +

							        // 영화 제목
							        '<p title="'+peopleNm+'">' + peopleNm + '</p>' +
							    '</a>'
						);
		                
		            } else {
		            	$('#movie-actor-search-result').append(
							    '<a href="/cms/movie-actor-detail?peopleCd=' + peopleCd +'&personId='+id+'" class="people-item">' +
							        // 영화 포스터
							        '<img src="' + defaultPosterUrl + '" alt="' + peopleNm + '">' +

							        // 영화 제목
							        '<p title="'+peopleNm+'">' + peopleNm + '</p>' +

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
			        
			        const peopleNm = $('#peopleNm').val().trim();
					const filmoNames = $('#filmoNames').val().trim();

					// 최소한 한 가지는 입력해야 요청
					if(!peopleNm && !filmoNames){
						alert('배우이름, 필모리스트 중 하나 이상 입력해주세요.');
						return;
					}
					
					getMovieSearchData(currentPage, peopleNm, filmoNames);
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
			        
			        const peopleNm = $('#peopleNm').val().trim();
					const filmoNames = $('#filmoNames').val().trim();

					// 최소한 한 가지는 입력해야 요청
					if(!peopleNm && !filmoNames){
						alert('배우이름, 필모리스트 중 하나 이상 입력해주세요.');
						return;
					}

					getMovieSearchData(currentPage, peopleNm, filmoNames);
			      }
				}
			    else if (page === 'next') {
			      if (currentPage < totalPages) {
			        currentPage++;
			        renderPagination(totalCnt, itemsPerPage, currentPage);
			        
			        const peopleNm = $('#peopleNm').val().trim();
					const filmoNames = $('#filmoNames').val().trim();

					// 최소한 한 가지는 입력해야 요청
					if(!peopleNm && !filmoNames){
						alert('배우이름, 필모리스트 중 하나 이상 입력해주세요.');
						return;
					}

					getMovieSearchData(currentPage, peopleNm, filmoNames);
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

						const peopleNm = $('#peopleNm').val().trim();
						const filmoNames = $('#filmoNames').val().trim();

						// 최소한 한 가지는 입력해야 요청
						if(!peopleNm && !filmoNames){
							alert('배우이름, 필모리스트 중 하나 이상 입력해주세요.');
							return;
						}

			    	    getMovieSearchData(currentPage, peopleNm, filmoNames);
			    	  }
			    }

			    else {
			    	alert('특정 페이지!')
			      const selectedPage = parseInt(page);
			      if (selectedPage !== currentPage) {
			        currentPage = selectedPage;
			        renderPagination(totalCnt, itemsPerPage, currentPage);
					
			        const peopleNm = $('#peopleNm').val().trim();
					const filmoNames = $('#filmoNames').val().trim();

					// 최소한 한 가지는 입력해야 요청
					if(!peopleNm && !filmoNames){
						alert('배우이름, 필모리스트 중 하나 이상 입력해주세요.');
						return;
					}
			        
					getMovieSearchData(currentPage, peopleNm, filmoNames);
			      }
			    }
			  });
			}
			

		
	</script>
</head>
<body>
	<div id="movie-actor-search-wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div id="movie-actor-main">
			<h1>영화인 검색</h1>
			<div id="movie-actor-search-box">
				<input type="text" id="peopleNm" placeholder="배우이름"/>
				<input type="text" id="filmoNames" placeholder="필모리스트"/>
				<button id="search-btn">검색</button>
			</div>
			<!-- 결과 렌더링 영역 -->
			<div id="movie-actor-search-result">
				<img src="${pageContext.request.contextPath}/resources/static/images/movie/movie-actor-icon.png" id="default-movie-icon"/>
			</div>
	
			<!-- 페이지네이션 -->
			<div id="pagination"></div>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>
