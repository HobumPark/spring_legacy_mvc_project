<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 스텝2</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/member/update/member-update.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(document).ready(function() {
		phoneNumberSplitAndDisplay()
		emailSplitAndDisplay()
		changePwBtnClick()
		addressSearchBtnClick()
		
	});
	
	function phoneNumberSplitAndDisplay(){
		// 사용자 전화번호가 "111-1111-1111" 형식이라고 가정
	    var phoneNumber = "${user.phoneNumber}";  // JSP에서 값 가져오기
	
	    // 전화번호를 "-" 기준으로 분리
	    var phoneParts = phoneNumber.split('-');
	
	    // 각 부분을 해당 input 필드에 할당
	    $('#phone-input-1').val(phoneParts[0]);
	    $('#phone-input-2').val(phoneParts[1]);
	    $('#phone-input-3').val(phoneParts[2]);
	}
	function emailSplitAndDisplay(){
		var email = "${user.email}";
	    
	    var emailParts = email.split('@'); 
	    
	    $('#email-input').val(emailParts[0]);
	    $('#email-select').val(emailParts[1]);
	}
	
	function changePwBtnClick(){
		$("#change-pw-btn").on('click', function(){
			// 버튼의 readonly 상태를 확인
			if ($("#pw-input").attr('readonly')) {
				// readonly 속성이 있으면 해제
				alert('해제!')
				$("#pw-input").removeAttr('readonly').css("backgroundColor", "#fff");
				alert('비밀번호 변경 가능');
			} else {
				// readonly 속성이 없으면 복원
				alert('복원!')
				$("#pw-input").attr('readonly', true).css("backgroundColor", "#666");
				alert('비밀번호 변경 불가');
			}
		});
	}
	
	function addressSearchBtnClick() {
	    $("#address-search-btn").on('click', function(){
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 선택된 주소 데이터를 각 필드에 채워넣기
	                $('#zone-code-input').val(data.zonecode);  // 우편번호
	                $('#main-address-input').val(data.address);  // 기본 주소
	                if (data.bname !== '') {
	                    $('#detail-address-input').val(data.bname);  // 상세 주소 (동/호수 등)
	                } else {
	                    $('#detail-address-input').val('');  // 상세 주소가 없으면 비워두기
	                }

	                // 팝업 창 닫기
	                $('#postcodePopup').hide(); // 팝업 닫기
	            }
	        }).open();
	    });
	}
</script>
</head>
<body>
	<jsp:include page="../../common/header.jsp"></jsp:include>
	<div id="postcodePopup"></div>
	<div id="update-member-wrap">
		<div id="update-member-list">
			<!-- 회원 정보 수정 항목들 -->
		</div>
		<div id="update-member-info-input">
			<div id="update-wrap">
				<form action="" method="POST">
					<div id="id-row">
						<div class="label-area">아이디*</div>
						<div class="input-area">
							<span> 
								<input type="text" id="id-input" value="${user.id}" readonly>
								<button type="button" id="change-id-btn" style="display: none;">아이디 변경</button> 
								<span id="check-id-display"></span>
							</span> 
							<span> 
								영문, 숫자만 가능(5~20자), 중복확인 버튼을 눌러 ID중복 여부를 확인해주시기 바랍니다. 
							</span>
						</div>
					</div>
					<div id="password-row">
						<div class="label-area">비밀번호*</div>
						<div class="input-area">
							<div>
								<input type="password" id="pw-input" readonly value="${user.password}">
								<button id="change-pw-btn" type="button">비밀번호변경</button>
								<span id="pw-validate-result"></span>
							</div>
							<div>
								<span>영문자,숫자,특수문자 포함 8~12글자</span>
							</div>
						</div>
					</div>
					<div id="password-confirm-row">
						<div class="label-area">비밀번호 확인*</div>
						<div class="input-area">
							<div>
								<input type="password" id="pw-confirm-input" value="${user.password}"> 
								<span id="pw-confirm-validate-result"></span>
							</div>
						</div>
					</div>
					<div id="name-row">
						<div class="label-area">이름*</div>
						<div class="input-area">
							<input type="text" id="name-input" value="${user.username}" readonly>
						</div>
					</div>
					<div id="phone-row">
						<div class="label-area">휴대폰*</div>
						<div class="input-area">
							<input type="text" id="phone-input-1" value="${user.phoneNumber}"> - 
							<input type="text" id="phone-input-2" value="${user.phoneNumber}"> - 
							<input type="text" id="phone-input-3" value="${user.phoneNumber}">
						</div>
					</div>
					<div id="address-row">
						<div class="label-area">주소*</div>
						<div class="input-area">
							<span id="address-search"> <input type="text"
								id="zone-code-input">
								<button id="address-search-btn">주소검색</button>
							</span> <span id="main-address"> <input type="text"
								id="main-address-input" value="${user.address}">
							</span> <span id="detail-address"> <input type="text"
								id="detail-address-input">
							</span>
						</div>
					</div>
					<div id="email-row">
						<div class="label-area">이메일*</div>
						<div class="input-area">
							<input type="text" id="email-input">@ 
							<select name=""id="email-select">
								<option>직접입력</option>
								<option>example.com</option>
								<option>gmail.com</option>
								<option>hanmail.net</option>
								<option>naver.com</option>
							</select> <input type="text" id="domain-input">
						</div>
					</div>
					<div id="sms-row">
						<div class="label-area">메일/SMS 수신동의</div>
						<div class="input-area">
							<input type="radio" name="sms-agree" value="yes"> <span>수신</span>
							<input type="radio" name="sms-agree" value="no"> <span>미수신</span>
						</div>
					</div>
					<div id="btn-row">
						<button id="update-btn">수정완료</button>
						<button id="go-home-btn">처음으로</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<jsp:include page="../../common/footer.jsp"></jsp:include>
</body>
</html>