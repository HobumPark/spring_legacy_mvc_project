<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="${pageContext.request.contextPath}/resources/static/css/style.css" type="text/css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/static/css/member/join/join-step1.css" type="text/css" rel="stylesheet"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
	<title>회원가입 스텝1</title>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        $(document).ready(function(){
            console.log('join-step1')
            more14Hover()
            below14Hover()
        })

        function more14Hover(){
            $("#more-14>a").on({
                "mouseover":function(){
                    console.log('mouseover!')
                    $(this).find('img').attr('src','${pageContext.request.contextPath}/resources/static/images/join/join-step1/mem_adult_on.png')
                },
                "mouseout":function(){
                    console.log('mouseout!')
                    $(this).find('img').attr('src','${pageContext.request.contextPath}/resources/static/images/join/join-step1/mem_adult.png')
                }
            })
        }
        function below14Hover(){
            $("#below-14>a").on({
                "mouseover":function(){
                    console.log('mouseover!')
                    $(this).find('img').attr('src','${pageContext.request.contextPath}/resources/static/images/join/join-step1/mem_child_on.png')
                },
                "mouseout":function(){
                    console.log('mouseout!')
                    $(this).find('img').attr('src','${pageContext.request.contextPath}/resources/static/images/join/join-step1/mem_child.png')
                }
            })
        }
    </script>
</head>
<body>
	<jsp:include page="../../common/header.jsp"></jsp:include>
	<div id="register-step1-wrap">
        <div id="register-step1-list">
            <ul>
                <li>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs01_on.png" alt="회원유형확인-온">
                    <span>회원유형확인</span>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs_arrow.png" alt="화살표">
                </li>
                <li>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join//mem_prcs02.png" alt="이용약관동의">
                    <span>이용약관동의</span>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs_arrow.png" alt="화살표">
                </li>
                <li>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs03.png" alt="본인확인">
                    <span>본인확인</span>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs_arrow.png" alt="화살표">
                </li>
                <li>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs04.png" alt="정보입력">
                    <span>정보입력</span>
                </li>
            </ul>
        </div>
        <div id="register-step1-select-type">
            <div id="more-14">
                <a href="./join-step2">
                    <h1>14세이상</h1>
                    <h2>일반회원</h2>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/join-step1/mem_adult.png" alt="14세이상">
                </a>
            </div>
            <div id="below-14">
                <a href="#">
                    <h1>14세미만</h1>
                    <h2>어린이, 학생회원</h2>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/join-step1/mem_child.png" alt="14세미만">
                </a>
            </div>
        </div>
    </div>
    <jsp:include page="../../common/footer.jsp"></jsp:include>
</body>
</html>