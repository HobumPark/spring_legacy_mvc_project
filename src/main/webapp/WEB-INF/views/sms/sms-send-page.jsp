<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>movie search</title>
	<link href="${pageContext.request.contextPath}/resources/static/css/style.css" type="text/css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/static/css/sms/sms-send-page.css" type="text/css" rel="stylesheet"/>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		$(document).ready(function(){
			
			menu()
		})
	</script>
</head>
<body>
	<div id="sms-wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="sms-container">
		    <h2>문자 보내기</h2>
		    <form action="${pageContext.request.contextPath}/sms/send" method="post">
		        <label for="receiver">받는 사람</label>
		        <input type="text" id="phone-1" name="phone-number" placeholder="010" required /> -
		        <input type="text" id="phone-2" name="phone-number" placeholder="1234" required /> -
		        <input type="text" id="phone-3" name="phone-number" placeholder="1234" required />
		        
		        <label for="sender">보내는 사람</label>
		        <input type="text" id="sender" name="sender" placeholder="" required readonly value='${user.username} (${user.id})'/>
		
		        <label for="content">내용</label>
		        <textarea id="content" name="content" placeholder="문자 내용을 입력하세요" rows="8" required></textarea>
		
		        <button type="submit">보내기</button>
		    </form>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>
