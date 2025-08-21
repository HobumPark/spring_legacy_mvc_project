<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 스텝2</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/member/join/join-step3.css">
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        $(document).ready(function(){
            console.log('join-step3')
            phoneIdentifyClick()
            ipinIdentifyClick()
        })

        function phoneIdentifyClick(){
            $("#phone-identify").on('click',function(){
                alert('휴대폰 본인인증')
                
                window.location.href='/cms/member/join-step4'
                
                window.open('', 'popupChk',
                'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, ' +
                'status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
                document.form_chk_phone.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
                document.form_chk_phone.target = "popupChk";
                document.form_chk_phone.submit();
            })
        }

        function ipinIdentifyClick(){
            $("#ipin-identify").on('click',function(){
                alert('아이핀 인증')
                window.open('', 'popupChk',
                'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, ' +
                'status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
                document.form_chk_ipin.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
                document.form_chk_ipin.target = "popupChk";
                document.form_chk_ipin.submit();
            })
        }
</script>

</head>
<body>
	<jsp:include page="../../common/header.jsp"></jsp:include>
	<div id="register-step3-wrap">
        <div id="register-step3-list">
            <ul>
                <li>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs01.png" alt="회원유형확인-온">
                    <span>회원유형확인</span>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs_arrow.png" alt="화살표">
                </li>
                <li>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs02.png" alt="이용약관동의">
                    <span>이용약관동의</span>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs_arrow.png" alt="화살표">
                </li>
                <li>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs03_on.png" alt="본인확인">
                    <span>본인확인</span>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs_arrow.png" alt="화살표">
                </li>
                <li>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs04.png" alt="정보입력">
                    <span>정보입력</span>
                </li>
            </ul>
        </div>
        <div id="register-step3-Identity-verification">
            <h4>I-PIN 신규발급 [신규발급 바로가기]</h4>
            <div id="phone-identify">
                <img src="${pageContext.request.contextPath}/resources/static/images/join/join-step3/identy1.png" alt="인증1">
                <span>휴대폰 본인인증</span>
                <!-- 본인인증 form chk -->
                <form name="form_chk_phone" method="post">
                    <input type="hidden" name="m" value="checkplusService">
                    <input type="hidden" name="EncodeData" th:value="${sEncData}">
                </form>
            </div>
            <div id="ipin-identify">
                <img src="${pageContext.request.contextPath}/resources/static/images/join/join-step3/identy2.png" alt="인증1">
                <span>I-PIN(아이핀)인증</span>
                <form name="form_chk_ipin" method="post" action="https://cert.nice.com/ipin" target="ipinPopup">
                    <input type="hidden" name="m" value="checkplusService">
                    <input type="hidden" name="EncodeData" value="${EncodeData}">
                </form>
            </div>
        </div>
    </div>
    <jsp:include page="../../common/footer.jsp"></jsp:include>
</body>
</html>