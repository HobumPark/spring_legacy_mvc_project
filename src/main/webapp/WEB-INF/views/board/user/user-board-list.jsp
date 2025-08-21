<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/common/header.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/common/footer.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/board/user/user-board-list.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		$(document).ready(function(){
			menu()
			writeBtnClick()
		})
		
		 function menu(){
        	alert('menu!')
            $("#gnb>li").on({
                "mouseover":function(){
                    console.log("mouseover")
                    $(this).find('.lnb').stop().slideDown()
                },
                "mouseout":function(){
                    $(".lnb").stop().slideUp()
                }
            })
        }
		
		function writeBtnClick(){
			$("#write-btn").on('click',function(){
				window.location.href='/cms/board/user/write'
			})
		}
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
    <div id="user-board-list-wrap">
        <div id="user-board-list">
            <div id="user-board-list-header">
                <span>번호</span>
                <span>제목</span>
                <span>작성자</span>
                <span>작성일</span>
                <span>조회수</span>
                <span>파일</span>
            </div>
            <c:forEach var="board" items="${userBoardList}">
	            <div class="user-board-element">
	                <span>${board.no}</span>
	                <span>
	                	<a href="/cms/board/user/view?no=${board.no}">
	                		${board.title}
	                	</a>
	                </span>
	                <span>${board.author}</span>
	                <span>
	                	<fmt:formatDate value="${board.createdDate}" pattern="yyyy-MM-dd" />
	                </span>
	                <span>${board.views}</span>
	                <c:if test="${board.hasFile eq true}">
	                	<span>
	                		<i class="fa-solid fa-floppy-disk"></i>
	                	</span>
	                </c:if>
	                <c:if test="${board.hasFile eq false}">
	                	<span></span>
	                </c:if>
            	</div>
        	</c:forEach>
        	<div id="write-btn-area">
            	<c:if test="${loggedIn}">
            		<button id="write-btn">글쓰기</button>
            	</c:if>
            </div>
            <div id="pagination">
                <span class="page">
                	<c:if test="${currentPage eq 1}">
					  <a href="/cms/board/user/list?page=${currentPage}">
                		 이전
                	  </a>
					</c:if>
                	<c:if test="${currentPage ne 1}">
					  <a href="/cms/board/user/list?page=${currentPage-1}">
                		 이전
                	  </a>
					</c:if>
                </span>
                 <c:forEach var="page" begin="1" end="${lastPage}">
			        <span class="page">
			        	 <c:if test="${not empty searchInput}">
			        	 	<a href="/cms/board/user/list?page=${page}&search_input=${searchInput}" class="${page == currentPage ? 'active' : ''}">
					       		${page}
					    	</a>
			        	 </c:if>
			             <c:if test="${empty searchInput}">
			        	 	<a href="/cms/board/user/list?page=${page}" class="${page == currentPage ? 'active' : ''}">
					       		${page}
					    	</a>
			        	 </c:if>
			        </span>
			     </c:forEach>
			    <span class="page">
                	<c:if test="${currentPage eq lastPage}">
					  <a href="/cms/board/user/list?page=${currentPage}">
                		 다음
                	  </a>
					</c:if>
                	<c:if test="${currentPage ne lastPage}">
					  <a href="/cms/board/user/list?page=${currentPage+1}">
                		 다음
                	  </a>
                	  
					</c:if>
                </span>
            </div>
            <div id="search-area">
                <form action="/cms/board/user/list" method="get">
                    <select name="search-type" id="">
                        <option value="title-and-cotent">제목+내용</option>
                        <option value="title">제목</option>
                        <option value="cotent">내용</option>
                        <option value="writer">작성자</option>
                    </select>
                    <input type="text" name="search_input" id="search-input" placeholder="검색어를 입력하세요">
                    <button type="submit" id="search-btn">
                        <i class="fa-solid fa-magnifying-glass"></i>검색
                    </button>
                    <input type="hidden" name="page" value="1"/>
                </form>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>