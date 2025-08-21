<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB-TEST</title>
</head>
<body>
    <ul>
        <c:forEach var="item" items="${list}">
            <li>${item.no}</li>
            <li>${item.name}</li>
        </c:forEach>
    </ul>
</body>
</html>