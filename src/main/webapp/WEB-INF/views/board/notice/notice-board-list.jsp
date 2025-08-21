<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>notice board list</title>
	<link href="${pageContext.request.contextPath}/resources/static/css/style.css" type="text/css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/resources/static/css/board/notice/notice-board-list.css" type="text/css" rel="stylesheet"/>
</head>
<body>
	<div id="notice-board-list-wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div id="notice-board-list">
			공지사항 게시판 목록
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	</div>
</body>
</html>