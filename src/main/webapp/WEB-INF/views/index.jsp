<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>홈페이지</title>
	
	<!-- Favicon 추가 -->
    <link rel="icon" href="${pageContext.request.contextPath}/resources/static/images/home/favicon.ico" type="image/x-icon">
	
	
	<link href="${pageContext.request.contextPath}/resources/static/css/style.css" type="text/css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/static/css/index.css" type="text/css" rel="stylesheet"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.12/jquery.bxslider.min.css">
    
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.12/jquery.bxslider.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/imagesloaded@4.1.4/imagesloaded.pkgd.min.js"></script>
    <script>
    	const contextPath = '<%= request.getContextPath() %>';
    
        $(document).ready(function(){
			//menu()
            //slide()
            boardTab()
            contentsTab()
            nasaAPI()
            quotesAPI()
            
		})
		
		$(window).on('load', function(){
			//alert('load!')
		    slide(); // bxSlider 초기화
		});

        function slide(){    	
                $("#lecture-slide").bxSlider({
                    auto: true, // 자동 슬라이딩
                    pause: 3000, // 슬라이드 전환 간격 (3초)
                    speed: 500, // 슬라이드 속도
                    pager: false, // 페이지 네비게이션 숨김
                    controls: true // 이전/다음 버튼 표시
                });
        }

        function boardTab(){
            $("#notice-btn").on('click',function(){
                $("#user-board-contents").hide()
                $("#user-btn").removeClass("active")
                $("#notice-board-contents").show()
                $("#notice-btn").addClass("active")
            })
            $("#user-btn").on('click',function(){
                $("#notice-board-contents").hide()
                $("#notice-btn").removeClass("active")
                $("#user-board-contents").show()
                $("#user-btn").addClass("active")
            })
        }

        function contentsTab(){
            $("#nasa-btn").on('click',function(){
                $("#quotes-contents").hide()
                $("#quotes-btn").removeClass("active")
                $("#nasa-contents").show()
                $("#nasa-btn").addClass("active")
            })
            $("#quotes-btn").on('click',function(){
                $("#nasa-contents").hide()
                $("#nasa-btn").removeClass("active")
                $("#quotes-contents").show()
                $("#quotes-btn").addClass("active")
            })
        }

        function nasaAPI(){
            // 하루 전 날짜
            const date1 = moment().subtract(1, 'days').format('YYYY-MM-DD');
            console.log("하루 전 날짜:", date1);
            const date2 = moment().subtract(2, 'days').format('YYYY-MM-DD');
            console.log("이틀 전 날짜:", date2);
            const date3 = moment().subtract(3, 'days').format('YYYY-MM-DD');
            console.log("삼일 전 날짜:", date3);
            $("#nasa-contents").append('<h4>나사 이미지</h4>')
            getNasaData(date1)
            getNasaData(date2)
            getNasaData(date3)
        }

        function getNasaData(date){
            console.log('getNasaData')
            
            const apiKey = 'MWdJPzVSb1wrUknY6DNToQZGzj5Fjq6p703R2rg5'
            
           	console.log('넘어온 date:', date);
    		console.log('apiKey:', apiKey);
            
    		var url = "https://api.nasa.gov/planetary/apod?api_key=" + apiKey + "&date=" + date;
    		 console.log(url);
    		  
    		 $.ajax({
   			    type: 'get',
   			    url: url,
   			    async: true,
   			    dataType: 'json',
   			    success: function(result) {
   			        console.log(result);

   			        // result.url이 없거나 비어있으면 대체 이미지 사용
   			        var imageUrl = result.url ? result.url : contextPath + '/resources/static/images/fun-contents/no-contents.png';

   			        var img = '<img src="' + imageUrl + '" alt="나사이미지"/>';
   			        $("#nasa-contents").append(img);
   			    },
   			    error: function(request, status, error) {
   			        console.log(error);
   			    }
   			});
        }

        function quotesAPI(){
            // https://korean-advice-open-api.vercel.app/api/advice
            $.ajax({
			    type : 'get',           // 타입 (get, post, put 등등)
			    url : `https://korean-advice-open-api.vercel.app/api/advice`,// 요청할 서버url
			    async : true,            // 비동기화 여부 (default : true)
			    dataType : 'json',       // 데이터 타입 (html, xml, json, text 등등)
			    success : function(result) { // 결과 성공 콜백함수
			        console.log(result);
                    $("#author").text(result.author)
                    $("#author-profile").text(result.authorProfile)
                    $("#message").text(result.message)
			    },
			    error : function(request, status, error) { // 결과 에러 콜백함수
			        console.log(error)
                }
			})
        }
        
    </script>
</head>
<body>
	<jsp:include page="common/header.jsp"></jsp:include>
	<div id="wrap">
		<div id="main">
			<div id="slide">
                <div id="lecture-slide">
                    <div class="slide-element">
                        <img src="${pageContext.request.contextPath}/resources/static/images/home/c.png" alt="">
                    </div>
                    <div class="slide-element">
                        <img src="${pageContext.request.contextPath}/resources/static/images/home/cpp.png" alt="">
                    </div>
                    <div class="slide-element">
                        <img src="${pageContext.request.contextPath}/resources/static/images/home/java.png" alt="">
                    </div>
                    <div class="slide-element">
                        <img src="${pageContext.request.contextPath}/resources/static/images/home/javascript.png" alt="">
                    </div>
                    <div class="slide-element">
                        <img src="${pageContext.request.contextPath}/resources/static/images/home/python.png" alt="">
                    </div>
                    <div class="slide-element">
                        <img src="${pageContext.request.contextPath}/resources/static/images/home/spring.png" alt="">
                    </div>
                    <div class="slide-element">
                        <img src="${pageContext.request.contextPath}/resources/static/images/home/nodejs.png" alt="">
                    </div>
                </div>
            </div>
            <div id="tab">
                <div id="board-tab">
                    <div id="board-tab-title">
                        <button id="notice-btn" class="active">공지사항</button>
                        <button id="user-btn">사용자</button>
                    </div>
                    <div id="board-tab-contents">
                        <div id="notice-board-contents">
                            <div class="board-element">
                                <span>
                                    <a href="#">
                                        	제목10
                                    </a>
                                </span>
                                <span>김철수</span>
                                <span>2024-12-01</span>
                            </div>
                            <div class="board-element">

                            </div>
                            <div class="board-element">

                            </div>
                            <div class="board-element">

                            </div>
                            <div class="board-element">

                            </div>
                        </div>
                        <div id="user-board-contents">
                            <c:forEach var="board" items="${userBoardList}">
					            <div class="board-element">
					                <span>
					                	<a href="/cms/board/user/view?no=${board.no}">
					                		${board.title}
					                	</a>
					                </span>
					                <span>${board.author}</span>
					                <span>
					                	<fmt:formatDate value="${board.createdDate}" pattern="yyyy-MM-dd" />
					                </span>
				            	</div>
				        	</c:forEach>
                        </div>
                    </div>
                </div>
                <div id="contents-tab">
                    <div id="contents-tab-title">
                        <button id="nasa-btn" class="active">나사</button>
                        <button id="quotes-btn">명언</button>
                    </div>
                    <div id="contents-tab-contents">
                        <div id="nasa-contents">
                            
                        </div>
                        <div id="quotes-contents">
                            <div id="author"></div>
                            <div id="author-profile"></div>
                            <div id="message"></div>
                        </div>
                    </div>
                </div>
            </div>
		</div>
	</div>
	<jsp:include page="common/footer.jsp"></jsp:include>
</body>
</html>
