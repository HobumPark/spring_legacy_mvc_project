<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<link href="${pageContext.request.contextPath}/resources/static/css/common/header.css" type="text/css" rel="stylesheet"/>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.12/jquery.bxslider.min.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		var intervalId=null;
		
        $(document).ready(function(){
			menu()	
			getSessionRemainTime()
			loginBtnClick()
		})

        function menu(){
        	//alert('menu!')
            $("#gnb>li").on({
                "mouseover":function(){
                    console.log("mouseover");
                    $(this).find('.lnb').stop().slideDown()
                },
                "mouseout":function(){
                    $(".lnb").stop().slideUp()
                }
            })
        }
        
        function getSessionRemainTime(){
			
        	let remainingSeconds = ${sessionRemainingTime != null ? sessionRemainingTime : 0};
        	
        	if(remainingSeconds == 0){
        		console.log('세션만료됨!')
        		return;
        	}
        	
        	console.log('getSessionRemainTime(header)')
        	console.log(remainingSeconds)
        	updateTimeDisplay(remainingSeconds)
        }
        
        function updateTimeDisplay(remainingSeconds){
            clearInterval(intervalId); // 기존 인터벌 있으면 초기화

            if(remainingSeconds <= 0){
                $("#session-timer").text("0");
                return;  // 남은 시간이 0 이하면 바로 종료
            }

            $("#session-timer").text(remainingSeconds);

            intervalId = setInterval(() => {
                remainingSeconds--;
                if(remainingSeconds <= 0){
                    clearInterval(intervalId);
                    $("#session-timer").text("0");
                    window.location.href="/cms"
                    return;
                }
                $("#session-timer").text(remainingSeconds);
            }, 1000);
        }
        
        function loginBtnClick() {
        	  $("#login-btn").on('click', function (e) {
        	    e.preventDefault();
        	    const currentUrl = window.location.pathname + window.location.search;
        	    window.location.href = "/cms/member/login?redirectUrl=" + encodeURIComponent(currentUrl);
        	  });
        	}
    </script>
</head>
<body>
	<div id="header">
            <div id="logo">
                <a href="/cms">
                    <img src="${pageContext.request.contextPath}/resources/static/images/logo.webp" alt="로고">
                </a>
            </div>
            <div id="nav">
            	<div id="util">
            		<c:if test="${loggedIn}">
				        <span id="session-timer"></span>초 남음
				    </c:if>
				    
				    <c:if test="${loggedIn && user.role == 'ADMIN'}">
					    <a href="/cms/sms/send">문자전송</a>
					</c:if>
				    
            		<c:if test="${loggedIn}">
            			<a href="/cms/member/update">회원정보수정</a>
				        <a href="/cms/member/logout">로그아웃</a>
				    </c:if>
				    
				    <!-- 비로그인 상태일 때 -->
				    <c:if test="${!loggedIn}">
				        <a href="" id="login-btn">로그인</a>
				        <a href="/cms/member/join-step1">회원가입</a>
				    </c:if>
                </div>
                <ul id="gnb">
                    <li>
                        <a href="#">강의</a>
                        <ul class="lnb">
                            <li><a href="#">C</a></li>
                            <li><a href="#">C++</a></li>
                            <li><a href="#">Java</a></li>
                            <li><a href="#">Spring</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">영화</a>
                        <ul class="lnb">
                            <li><a href="/cms/movie/movie-box-office">박스오피스</a></li>
                            <li><a href="/cms/movie/movie-search">영화목록</a></li>
                            <li><a href="/cms/movie/movie-actor">영화인</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">컨텐츠</a>
                        <ul class="lnb">
                            <li><a href="/cms/contents/nasa">나사</a></li>
                            <li><a href="/cms/contents/quotes">명언</a></li>
                            <li><a href="/cms/contents/weather">날씨</a></li>
                            <li><a href="/cms/contents/qr">QR코드</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">지도</a>
                        <ul class="lnb">
                            <li><a href="/cms/map/address-search">주소검색</a></li>
                            <li><a href="/cms/map/pollution-map">미세먼지</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">게시판</a>
                        <ul class="lnb">
                            <li><a href="/cms/board/notice/list?page=1">공지사항</a></li>
                            <li><a href="/cms/board/user/list?page=1">사용자</a></li>
                            <li><a href="/cms/board/user/list?page=1">갤러리</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">고객지원</a>
                        <ul class="lnb">
                            <li><a href="/cms/support/contact">접근</a></li>
                            <li><a href="/cms/support/email">메일보내기</a></li>
                            <li><a href="/cms/support/inquiry">문의하기</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
</body>
</html>