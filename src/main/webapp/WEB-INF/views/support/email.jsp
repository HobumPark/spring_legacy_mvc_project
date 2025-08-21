<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>movie search</title>
	<link href="${pageContext.request.contextPath}/resources/static/css/style.css" type="text/css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/static/css/support/email.css" type="text/css" rel="stylesheet"/>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		$(document).ready(function(){
			
			menu()
		})
	</script>
</head>
<body>
	<div id="email-wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="email-container">
		    <h2>메일 보내기</h2>
		    <form action="${pageContext.request.contextPath}/support/email" method="post">
		        <label for="from-mail">받는 사람</label>
		        <input type="email" id="from-mail" name="from-mail" placeholder="example@example.com" required />
		        
		        <label for="from">보내는 사람</label>
		        <input type="email" id="from" name="from" placeholder="" required disabled value='${user.username} (${user.id})'/>
		
		        <label for="subject">제목</label>
		        <input type="text" id="subject" name="subject" placeholder="메일 제목 입력" required />
		
		        <label for="content">내용</label>
		        <textarea id="content" name="content" placeholder="메일 본문을 입력하세요" rows="8" required></textarea>
		
		        <button type="submit">보내기</button>
		    </form>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>
