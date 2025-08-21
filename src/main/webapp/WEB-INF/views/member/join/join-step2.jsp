<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/member/join/join-step2.css">
<title>회원가입 스텝2</title>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        $(document).ready(function(){
            console.log('join-step2')
            term1Check()
            term2Radio()
            term3Radio()
            term4Radio()
            termAllCheck()
            agreeBtnClick()
            disAgreeBtnClick()
        })

        var term1=false;
        var term2=false;
        var term3=false;
        var term4=false;
        
        function term1Check(){
            $("#term1-agree-check").on('click',function(){
                //alert('약관동의1 체크')
                term1 = !term1
            })
        }
        function term2Radio(){
            $("input[name='term2-agree-radio']").on('click',function(){
                //alert('약관동의2 클릭')
              
                var val = $(this).val()
                if(val=='yes'){
                    term2=true
                }else{
                    term2=false
                }
            })
        }
        function term3Radio(){
            $("input[name='term3-agree-radio']").on('click',function(){
                //alert('약관동의3 클릭')

                var val = $(this).val()
                if(val=='yes'){
                    term3=true
                }else{
                    term3=false
                }
            })
        }
        function term4Radio(){
            $("input[name='term4-agree-radio']").on('click',function(){
                //alert('약관동의4 클릭')

                var val = $(this).val()
                if(val=='yes'){
                    term4=true
                }else{
                    term4=false
                }
            })
        }
        function termAllCheck(){
            $("#all-term-check").on('click',function(){
                //alert('모든 약관 동의 체크')
                $("#term1-agree-check").prop('checked','true')
                $("#term2-agree-yes").prop('checked','true')
                $("#term3-agree-yes").prop('checked','true')
                $("#term4-agree-yes").prop('checked','true')
            })
        }
        function agreeBtnClick(){
            $("#agree-btn").on('click',function(){
                //alert('동의 클릭!')
                window.location.href='/cms/member/join-step3'
                if(term1==false){
                    return false
                }
                if(term2==false){
                    return false
                }
                if(term3==false){
                    return false
                }
                if(term4==false){
                    return false
                }
                //alert('모든약관 동의 확인!')
                window.location.href='./join-step3.html'
            })
        }
        function disAgreeBtnClick(){
            $("#disagree-btn").on('click',function(){
                alert('비동의 클릭!')
            })
        }
    </script>
    
</head>
<body>
	<jsp:include page="../../common/header.jsp"></jsp:include>
	<div id="register-step2-wrap">
        <div id="register-step2-list">
            <ul>
                <li>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs01.png" alt="회원유형확인-온">
                    <span>회원유형확인</span>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs_arrow.png" alt="화살표">
                </li>
                <li>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs02_on.png" alt="이용약관동의">
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
        <div id="register-step2-agree-term">
            <div id="agree-term1">
                <h4>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/join-step2/blt_02.gif" alt="">
                    대구광역시 도서관 통합회원 이용약관
                </h4>
                <div id="agree-term1-inner">
					<div class="agree-term-inner">
					  <p class="agree-term-text">
					    본 약관은 대구광역시 도서관 통합회원(이하 "회원")의 서비스 이용에 관한 권리, 의무 및 책임사항을 규정합니다.
					  </p>
					  <ul class="agree-term-list">
					    <li>1. 회원은 대구광역시가 제공하는 도서관 통합 서비스를 자유롭게 이용할 수 있습니다.</li>
					    <li>2. 회원은 타인의 명의로 가입하거나 허위 정보를 제공해서는 안 됩니다.</li>
					    <li>3. 회원은 관련 법령과 본 약관을 준수해야 하며, 타인의 권리를 침해해서는 안 됩니다.</li>
					    <li>4. 회원 탈퇴 시 이용 정보는 관련 법령에 따라 보관 또는 파기됩니다.</li>
					  </ul>
					</div>
                </div>
                <div id="agree-term1-btn">
                    <input type="checkbox" name="" id="term1-agree-check">
                    <span>통합회원 이용약관에 동의합니다.</span>
                </div>
            </div>
            <div id="agree-term2">
                <h4> 
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/join-step2/blt_02.gif" alt="">
                    개인정보 수집이용 동의
                </h4>
                <div id="agree-term2-inner">
					<div class="agree-term-inner">
					  <p class="agree-term-text">
					    대구광역시 도서관은 통합회원 서비스 제공을 위하여 아래와 같은 개인정보를 수집 및 이용합니다.
					  </p>
					  <ul class="agree-term-list">
					    <li>1. 수집 항목: 이름, 생년월일, 성별, 연락처, 주소, 이메일</li>
					    <li>2. 이용 목적: 회원 인증, 서비스 제공 및 민원처리</li>
					    <li>3. 보유 및 이용 기간: 회원 탈퇴 시까지 (단, 법령에 따라 보존이 필요한 경우 해당 기간까지)</li>
					  </ul>
					  <p class="agree-term-text">
					    회원은 위의 개인정보 수집 및 이용에 동의하지 않을 수 있으나, 이 경우 통합회원 서비스 이용이 제한될 수 있습니다.
					  </p>
					</div>
                </div>
                <div id="agree-term2-btn">
                    <input type="radio" name="term2-agree-radio" id="term2-agree-yes" value="yes">
                    <span>동의</span>
                    <input type="radio" name="term2-agree-radio" id="term2-agree-no" value="no">
                    <span>미동의</span>
                </div>
            </div>
            <div id="agree-term3">
                <h4>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/join-step2/blt_02.gif" alt="">
                    개인정보 공동이용(제공) 내역
                </h4>
                <div id="agree-term3-inner">
					<div class="agree-term-inner">
					  <p class="agree-term-text">
					    대구광역시 도서관은 다음과 같이 귀하의 개인정보를 대구광역시 산하 도서관과 공동으로 이용합니다.
					  </p>
					  <ul class="agree-term-list">
					    <li>1. 제공받는 자: 대구광역시 통합 도서관 소속 기관</li>
					    <li>2. 제공 항목: 이름, 생년월일, 회원번호, 도서 대출/반납 기록</li>
					    <li>3. 이용 목적: 도서 대출/반납 서비스 제공, 이용자 관리</li>
					    <li>4. 보유 및 이용 기간: 회원 탈퇴 또는 목적 달성 시까지</li>
					  </ul>
					  <p class="agree-term-text">
					    공동 이용에 동의하지 않으실 경우 일부 서비스 이용이 제한될 수 있습니다.
					  </p>
					</div>
                </div>
                <div id="agree-term3-btn">
                    <input type="radio" name="term3-agree-radio" id="term3-agree-yes" value="yes">
                    <span>동의</span>
                    <input type="radio" name="term3-agree-radio" id="term3-agree-no" value="no">
                    <span>미동의</span>
                </div>
            </div>
            <div id="agree-term4">
                <h4>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/join-step2/blt_02.gif" alt="">
                    개인정보 제3자 제공 내역
                </h4>
                <div id="agree-term4-inner">
					<div class="agree-term-inner">
					  <p class="agree-term-text">
					    대구광역시 도서관은 원칙적으로 회원의 개인정보를 제3자에게 제공하지 않습니다. 다만 다음의 경우는 예외로 합니다.
					  </p>
					  <ul class="agree-term-list">
					    <li>1. 회원의 사전 동의가 있는 경우</li>
					    <li>2. 법령에 따라 제공이 요구되는 경우 (예: 수사기관의 요청 등)</li>
					  </ul>
					  <p class="agree-term-text">
					    이 외 제3자 제공이 필요한 경우에는 별도 동의를 받으며, 동의하지 않아도 서비스 이용에 제한은 없습니다.
					  </p>
					</div>
                </div>
                <div id="agree-term4-btn">
                    <input type="radio" name="term4-agree-radio" id="term4-agree-yes" value="yes">
                    <span>동의</span>
                    <input type="radio" name="term4-agree-radio" id="term4-agree-no" value="no">
                    <span>미동의</span>
                </div>
            </div>
            <div id="all-check-area">
                <input type="checkbox" name="" id="all-term-check">
                <span>모든 약관에 동의합니다.</span>
            </div>  
            <div id="agree-btn-area">
                <button id="agree-btn">동의합니다.</button>
                <button id="disagree-btn">동의하지 않습니다.</button>
            </div>
        </div>
    </div>
    <jsp:include page="../../common/footer.jsp"></jsp:include>
</body>
</html>