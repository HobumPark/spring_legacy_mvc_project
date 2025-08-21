<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/common/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/common/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/member/login/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
	    $(document).ready(function(){
			menu()  
		})
    
	    function menu(){
	    	//alert('menu!')
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
	<title>로그인</title>
</head>
<body>
	<jsp:include page="../../common/header.jsp"></jsp:include>
    <div id="login-wrap">
        <h1>사이트 방문을 환영합니다.</h1>
        <form action="/cms/member/login" method="post">
            <div id="login-img">
                <img src="${pageContext.request.contextPath}/resources/static/images/login/mem_loginimg.png" alt="로그인이미지">
            </div>
            <div id="input-area">
                <div id="input-area-1">
                    <input type="text" placeholder="아이디" name="id">
                    <input type="password" placeholder="비밀번호" name="password">
                    <input type="hidden" name="redirectUrl" value="${redirectUrl}" />
                    <button id="login-btn" type="submit">로그인</button>
                </div>
                <div id="input-area-2">
                    <ul>
                        <li>
                            <a href="/cms/member/join-step1">회원가입</a>
                            <i class="fa-solid fa-caret-right"></i>
                        </li>
                        <li>
                            <a href="#">아이디 찾기</a>
                            <i class="fa-solid fa-caret-right"></i>
                        </li>
                        <li>
                            <a href="#">비밀번호 찾기</a>
                        </li>
                    </ul>
                </div>
                <div id="input-area-3">
                    <span>※ 기존 회원은 통합회원 인증 후 로그인할 수 있습니다.</span>
                </div>
            </div>
        </form>
    </div>
    <jsp:include page="../../common/footer.jsp"></jsp:include>
</body>
</html>