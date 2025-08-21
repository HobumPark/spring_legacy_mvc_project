<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/static/css/style.css" type="text/css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/static/css/fun-contents/nasa-api-page.css" type="text/css" rel="stylesheet"/>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
<script>
	$(document).ready(function() {
		quotesAPI()
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
	<div id="quotes-wrap">
	
	</div>
</body>
</html>