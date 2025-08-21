<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qr코드 만들기</title>
<link href="${pageContext.request.contextPath}/resources/static/css/style.css" type="text/css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/static/css/qr/qr-code-make.css" type="text/css" rel="stylesheet"/>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
<script>
	$(document).ready(function(){
		makeQrBtnClick()
	})
	
	function makeQrBtnClick(){
		$("#make-qr-btn").on('click',function(){
			alert('qr생성 클릭!')
			const url = $("#url").val()
			sendQrRequest(url)
		})
	}
	
	function sendQrRequest(url){
		$.ajax({
            url: '/cms/contents/qr', //
            type: 'POST', // POST 방식
            contentType: 'application/json', // content-type을 JSON으로 설정
            data: JSON.stringify({ url: url }), // id를 JSON 형태로 보내기
            dataType: 'blob', // 응답 데이터 타입 설정
            success: function(response) {
                console.log('성공!');
                console.log(response);

                // 응답이 Blob 형태로 반환됨
                const imageUrl = URL.createObjectURL(response);  // Blob을 URL로 변환

                // 이미지 표시
                $('#qr-code-result').html('<img src="' + imageUrl + '" alt="QR Code" />');
            },
            error: function(xhr, status, error) {
                console.log('오류 발생!');
                console.log('상태: ' + status);
                console.log('에러 메시지: ' + error);
                console.log('응답 상태 코드: ' + xhr.status);
            }
        });
	}
</script>
</head>
<body>
	<div id="qr-code-make-wrap">
	    <input type="text" id="url" name="url" placeholder="URL을 입력하세요" required />
	    <button type="button" id="make-qr-btn">QR 코드 생성</button>
		
		<div id="qr-code-result">
		    <!-- QR 코드 이미지가 여기에 표시됩니다 -->
		</div>
	</div>
</body>
</html>
