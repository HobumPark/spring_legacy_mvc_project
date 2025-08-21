<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 스텝2</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/member/join/join-step4.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
        var isIdValid = false;
        var isPwValid = false;
        var isPwConfirmValid = false;
        var isPhone1Valid = false;
        var isPhone2Valid = false;
        var isPhone3Valid = false;
        var isEmailValid = false;

        $(document).ready(function(){
            checkIdBtnClick()
            validateId()
            validatePw()
            validatePwConfirm()
            validatePhone()
            addressSearchBtnClick()
            emailSelect()
            registerBtnClick()
            goHomeBtnClick()
            changeIdBtnClick()
            displayPasswordBtnClick()
        })

        function checkIdBtnClick(){
            $("#check-id-btn").on('click',function(){
                alert('아이디 중복 확인!')
                var id = $("#id-input").val().trim();

                if (id === '') {
                    //alert('아이디를 입력하세요!')
                    return;
                }

                // AJAX 요청 보내기
                $.ajax({
                    url: '/cms/member/duplicateIdCheck', //
                    type: 'POST', // POST 방식
                    contentType: 'application/json', // content-type을 JSON으로 설정
                    data: JSON.stringify({ userId: id }), // id를 JSON 형태로 보내기
                    dataType: 'json', // 응답 데이터 타입 설정
                    success: function(response) {
                        console.log('성공!')
                        console.log(response)
                        console.log(response.duplicate)
                        if(response.duplicate === true){
                            //alert('이미 사용 중인 아이디입니다.');
                            $("#check-id-display").text("이미 사용 중인 아이디입니다.").css("color","red")
                            $("#id-input").prop("disabled", false);
                            isIdValid = false;
                        } else {
                            //alert('사용 가능한 아이디입니다.');
                            $("#check-id-display").text("사용 가능한 아이디입니다.").css("color","green")
                            $("#id-input").prop("disabled", true);
                            $("#change-id-btn").show();
                            isIdValid = true;
                        }
                    },
                    error: function() {
                        // 오류 처리
                        console.log('오류!')
                    }
                });

            })
        }

        function validateId() {//아이디 유효성 검사
            $("#id-input").on('blur',function(){
                const idPattern = /^[a-zA-Z0-9_-]{4,12}$/; 
                // 예: 4~12자 영문, 숫자, -, _
                const id = $("#id-input").val()
                if(id.trim()===''){
                    //alert('아이디를 입력하세요!')
                }else if(idPattern.test(id)===true){
                    //alert('아이디 유효성 검사 성공!')
                    isIdValid=true;
                }else if(idPattern.test(id)===false){
                    //alert('아이디 유효성 검사 실패!')
                    $("#id-input").val('')
                }
                
            })
           
        }

        function validatePw(){//비밀번호 유효성 검사
            $("#pw-input").on('blur',function(){
                // 정규표현식: 영문(대소문자), 숫자, 특수문자를 포함하며 8~12글자
                const pwPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,12}$/;

                const pw = $("#pw-input").val()
                $("#pw-input").val( pw.trim() )

                if( pw.trim()==='' ){
                    //alert('비밀번호를 입력하세요!')
                }else if( pwPattern.test(pw)===true ){
                    //alert('비밀번호 유효성 검사 성공!')
                    $("#pw-validate-result").text('비밀번호 만족').css('color','green')
                    isPwValid=true;
                }else if( pwPattern.test(pw)===false ){
                    //alert('비밀번호 유효성 검사 실패!')
                    $("#pw-validate-result").text('비밀번호 실패').css('color','red')
                    $("#pw-input").val('')
                }
            })
        }
        function validatePwConfirm(){//비밀번호 확인
            $("#pw-confirm-input").on('blur',function(){
                const pw = $("#pw-input").val()
                const pwConfirm = $("#pw-confirm-input").val()
                
                if( pw.trim()==='' ){
                    //alert('비밀번호를 입력하세요!')
                }else if( pw.trim() === pwConfirm.trim() ){
                    //alert('비밀번호, 비밀번호 확인 일치!')
                    $("#pw-confirm-validate-result").text('비밀번호 일치').css('color','green')
                    isPwConfirmValid=true;
                }else if( pw.trim() !== pwConfirm.trim() ){
                    //alert('비밀번호, 비밀번호 확인 불일치!')
                    $("#pw-confirm-validate-result").text('비밀번호 불일치').css('color','red')
                    $("#pw-confirm-input").val('')
                }
            })
        }

        function validatePhone(){
            $("#phone-input-1").on('blur',function(){
                const phone1Pattern = /^\d{3}$/;  // 숫자 3자리
                const phone1 = $("#phone-input-1").val()

                if( phone1.trim()==='' ){
                    //alert('숫자를 입력하세요!')
                }else if( phone1Pattern.test(phone1)===true ){
                    //alert('숫자 3자리 만족!')
                    isPhone1Valid=true;
                }else if( phone1Pattern.test(phone1)===false ){
                    //alert('숫자 3자리 불만족!')
                    $("#phone-input-1").val('')
                }
            })

            $("#phone-input-2").on('blur',function(){
                const phone2Pattern = /^\d{4}$/;  // 숫자 3자리
                const phone2 = $("#phone-input-2").val()

                if( phone2.trim()==='' ){
                    //alert('숫자를 입력하세요!')
                }else if( phone2Pattern.test(phone2)===true ){
                    //alert('숫자 3자리 만족!')
                    isPhone2Valid=true;
                }else if( phone2Pattern.test(phone2)===false ){
                    //alert('숫자 3자리 불만족!')
                    $("#phone-input-2").val('')
                }
            })

            $("#phone-input-3").on('blur',function(){
                const phone3Pattern = /^\d{4}$/;  // 숫자 3자리
                const phone3 = $("#phone-input-3").val()

                if( phone3.trim()==='' ){
                    //alert('숫자를 입력하세요!')
                }else if( phone3Pattern.test(phone3)===true ){
                    //alert('숫자 3자리 만족!')
                    isPhone3Valid=true;
                }else if( phone3Pattern.test(phone3)===false ){
                    //alert('숫자 3자리 불만족!')
                    $("#phone-input-3").val('')
                }
            })

        }

        function addressSearchBtnClick(){
            $("#address-search-btn").on('click',function(){
                //alert("주소검색!~")
                new daum.Postcode({
                    oncomplete: function(data) {
                    	alert("완료!")
                    	console.log('data')
                    	console.log(data)
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                        // 예제를 참고하여 다양한 활용법을 확인해 보세요.
                        var zoneCode = data.zoneCode
                        var address = data.address
                        $("#zone-code-input").val(zoneCode)
                        $("#main-address-input").val(address)
                    }
                }).open();
            })
        }

        function emailSelect(){
            $("#email-select").on('change',function(){
                console.log('change')
                var val = $(this).val()
                if( val === '직접입력'){
                    return
                }else{
                    $("#domain-input").val(val)
                }
            })
        }

        function validateEmail(){
            $("#domain-input").on('blur',function(){
                const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}(\.[a-zA-Z]{2,})?$/;
                const domain = $("#domain-input").val()

                if( domain.trim()==='' ){
                    //alert('도메인을 입력하세요!')
                }else if( emailPattern.test(domain)===true ){
                    //alert('도메인 만족!')
                    isEmailValid=true;
                }else if( emailPattern.test(domain)===false ){
                    //alert('도메인 불만족!')
                }
            })
        }

        function registerBtnClick(){
            $("#register-btn").on('click',function(){
                //alert('등록!')
                var isAllValide= checkAllValidate()
                
                if(!isIdValid){
                    alert('아이디 중복 확인을 해주세요.');
                    return false;
                }
                
            })
        }

        function checkAllValidate(){
            if(isIdValid===false){
                return false
            }
            if(isPwValid===false){
                return false
            }
            if(isPwConfirmValid===false){
                return false
            }
            if(isPhone1Valid===false || isPhone2Valid===false || isPhone3Valid===false){
                return false
            }
            if(isEmailValid===false){
                return false
            }
            alert('유효성 모두 만족!')
            return true
        }

        function goHomeBtnClick(){
            $("#go-home-btn").on('click',function(){
                alert('홈으로!')
                window.location.href='/'
            })
        }
        
        function changeIdBtnClick(){
        	$("#change-id-btn").on('click',function(){
                alert('아이디 변경!')
                $("#id-input").prop("disabled", false);
                
            })
        }
        
        function displayPasswordBtnClick(){
        	$("#display-pw-btn").on('click',function(){
        		var type=$("#pw-input").attr('type')
        		
        		if(type==='password'){
        			$("#pw-input").attr('type','text')	
        			$("#display-pw-btn").text('비밀번호 숨기기')	
        		}else if(type==='text'){
        			$("#pw-input").attr('type','password')	
        			$("#display-pw-btn").text('비밀번호 표시')	
        		}
        	})
		}

</script>
</head>
<body>
	<jsp:include page="../../common/header.jsp"></jsp:include>
	<div id="postcodePopup">
	</div>
	<div id="register-step4-wrap">
        <div id="register-step4-list">
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
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs03.png" alt="본인확인">
                    <span>본인확인</span>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs_arrow.png" alt="화살표">
                </li>
                <li>
                    <img src="${pageContext.request.contextPath}/resources/static/images/join/mem_prcs04_on.png" alt="정보입력">
                    <span>정보입력</span>
                </li>
            </ul>
        </div>
        <div id="register-step4-info-input">
            <div id="register-wrap">
                <form action="" method="">
                    <div id="id-row">
                        <div class="label-area">
                            아이디*
                        </div>
                        <div class="input-area">
                            <span>
                                <input type="text" id="id-input">
                                <button id="check-id-btn" type="button">중복확인</button>
                                <button type="button" id="change-id-btn" style="display:none;">아이디 변경</button>
                                <span id="check-id-display"></span>
                            </span>
                            <span>
                                영문, 숫자만 가능(5~20자), 중복확인 버튼을 눌러 ID중복 여부를 확인해주시기 바랍니다.
                            </span>
                        </div>
                    </div>
                    <div id="password-row">
                        <div class="label-area">
                            비밀번호*
                        </div>
                        <div class="input-area">
                        	<div>
                        		<input type="password" id="pw-input">
                        		<button id="display-pw-btn" type="button">비밀번호표시</button>
                        		<span id="pw-validate-result"></span>
                        	</div>
                            <div>
                            	<span>영문자,숫자,특수문자 포함 8~12글자</span>
                            </div>
                        </div>
                    </div>
                    <div id="password-confirm-row">
                        <div class="label-area">
                            비밀번호 확인*
                        </div>
                        <div class="input-area">
                        	<div>
                        		<input type="password" id="pw-confirm-input">
                        		<span id="pw-confirm-validate-result"></span>
                        	</div>
                        </div>
                    </div>
                    <div id="name-row">
                        <div class="label-area">
                            이름*
                        </div>
                        <div class="input-area">
                            <input type="text">
                        </div>
                    </div>
                    <div id="phone-row">
                        <div class="label-area">
                            휴대폰*
                        </div>
                        <div class="input-area">
                            <input type="text" id="phone-input-1"> - 
                            <input type="text" id="phone-input-2"> - 
                            <input type="text" id="phone-input-3">
                        </div>
                    </div>
                    <div id="address-row">
                        <div class="label-area">
                            주소*
                        </div>
                        <div class="input-area">
                            <span id="address-search">
                                <input type="text" id="zone-code-input">
                                <button id="address-search-btn">주소검색</button>
                            </span>
                            <span id="main-address">
                                <input type="text" id="main-address-input">
                            </span>
                            <span id="detail-address">
                                <input type="text" id="detail-address-input">
                            </span>
                        </div>
                    </div>
                    <div id="email-row">
                        <div class="label-area">
                            이메일*
                        </div>
                        <div class="input-area">
                            <input type="text">@
                            <select name="" id="email-select">
                                <option>직접입력</option>
                                <option>gmail.com</option>
                                <option>hanmail.net</option>
                                <option>naver.com</option>
                            </select>
                            <input type="text" id="domain-input">
                        </div>
                    </div>
                    <div id="sms-row">
                        <div class="label-area">
                            메일/SMS 수신동의
                        </div>
                        <div class="input-area">
                            <input type="radio" name="sms-agree" value="yes">
                            <span>수신</span>
                            <input type="radio" name="sms-agree" value="no">
                            <span>미수신</span>
                        </div>
                    </div>
                    <div id="btn-row">
                        <button id="register-btn">입력완료</button>
                        <button id="go-home-btn">처음으로</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <jsp:include page="../../common/footer.jsp"></jsp:include>
</body>
</html>