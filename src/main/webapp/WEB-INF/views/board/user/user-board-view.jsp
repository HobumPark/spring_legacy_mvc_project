<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>user board view</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/common/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/common/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/board/user/user-board-view.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/board/user/modal-report.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		$(document).ready(function(){
			menu()
			deleteBtnClick()
			fileDeleteBtnClick()
			delTestBtnClick()
			commentPageBtnClick()
			alarmBtnClick()
			commentDeleteBtnClick()
			modalReportBtnClick()
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
		
		function deleteBtnClick(){
			$("#delete-btn").on('click',function(){
				
				// 현재 URL에서 쿼리 파라미터 추출
				const urlParams = new URLSearchParams(window.location.search);
				const no = urlParams.get('no');

				console.log(no); // 출력: 34
				
				var result=window.confirm('삭제 하시겠습니까?')
				if(result==true){
					alert('삭제!')
					$.ajax({
					    url: "/cms/board/user/delete?no="+no, // 요청할 URL
					    type: 'DELETE',    // HTTP 메서드
					    success: function(response) {
					        console.log('Post deleted successfully:', response);
					        if(response=='success'){
					        	alert('삭제 성공!')
					        	window.location.href='/cms/board/user/list?page=1'
					        }else{
					        	alert('삭제 실패!')
					        }
					    },
					    error: function(xhr, status, error) {
					        console.error('Failed to delete post:', error);
					    }
					});
				}
			})
		}
		
		function fileDeleteBtnClick(){
			$(".file-delete-btn").on('click',function(){
				alert('파일 삭제!')
				
				var isDelete = confirm('삭제하시겠습니까?')
				if(isDelete==true){
					alert('파일삭제 진행!')
				
				
					const $fileElement = $(this).closest('.file-element'); // 삭제 대상 div
					const fileId = $fileElement.data("file-id");
					const fileName = $fileElement.data("file-name");
			        
			        console.log("fileId:"+fileId);
			        console.log("fileName:"+fileName);
			        
			        
			        
			        $.ajax({
					    type : 'POST',           // 타입 (get, post, put 등등)
					    url : `/cms/file/delete`,
					    data:{"fileId":fileId,"fileName":fileName},
					    async : true,            // 비동기화 여부 (default : true)
					    dataType : 'json',       // 데이터 타입 (html, xml, json, text 등등)
					    success : function(result) { // 결과 성공 콜백함수
					    	console.log('result');
					        console.log(result);
					        $fileElement.remove(); // 직접 삭제 대상 제거
		                  
					    },
					    error : function(request, status, error) { // 결과 에러 콜백함수
					        console.log(error)
		                }
					})
			        
			        
				}
				
				
			})
		}
		
		function delTestBtnClick(){
			$("#del-test-btn").on('click',function(){
				alert('파일 삭제 테스트!')
				
				// 현재 URL에서 쿼리 파라미터 추출
				const urlParams = new URLSearchParams(window.location.search);
				const no = urlParams.get('no');

				console.log(no); // 출력: 34
				
				var isDelete = confirm('삭제하시겠습니까?')
				if(isDelete==true){
					alert('파일삭제 진행!')
			        
			        $.ajax({
					    type : 'POST',           // 타입 (get, post, put 등등)
					    url : `/cms/board/user/del_test`,
					    data:{"no":no},
					    async : true,            // 비동기화 여부 (default : true)
					    dataType : 'json',       // 데이터 타입 (html, xml, json, text 등등)
					    success : function(result) { // 결과 성공 콜백함수
					    	console.log('result');
					        console.log(result);
					        $(`.file-element[data-file-id='${fileId}']`).remove();
					    },
					    error : function(request, status, error) { // 결과 에러 콜백함수
					        console.log(error)
		                }
					})
			        
			        
				}
				
				
			})
		}
		
		function commentPageBtnClick(){
			$(document).on('click', '.page', function () {
			    const page = $(this).data('page');
			    const boardNo = $('#board-no').val(); // 숨겨진 input에서 가져오거나 JS 변수로
			   
			    alert('페이지 버튼 클릭:'+page)
			    alert('게시판 번호:'+boardNo)
			    loadComments(boardNo, page);
			});
		}
		
		function loadComments(boardNo, page = 1) {
		    $.ajax({
		        url: '/cms/board/user/comment/list',
		        method: 'GET',
		        data: { boardNo, page },
		        success: function (res) {
		        	console.log('comment list result')
		        	console.log(res)
		            renderCommentList(res.commentList);
		            renderPagination(res, boardNo);
		        },
		        error: function () {
		            alert('댓글 로딩 실패');
		        }
		    });
		}

		function renderCommentList(commentList) {
		    const $list = $('#comment-list');
		    $list.empty();

		    if (commentList.length === 0) {
		        $list.append('<p>댓글이 없습니다.</p>');
		        return;
		    }

		    commentList.forEach(comment => {
		        $list.append(`
		            <div class="comment-item">
		                <p><strong>${comment.writer}</strong>: ${comment.content}</p>
		            </div>
		        `);
		    });
		}

		function renderPagination(pagingData, boardNo) {
		    const {
		        currentPage, startPage, endPage, hasPrev, hasNext
		    } = pagingData;

		    const $pagination = $('#comment-pagination');
		    $pagination.empty();

		    // 이전 그룹
		    if (hasPrev) {
		        $pagination.append(`<button class="page-btn" data-page="${startPage - 1}">«</button>`);
		    }

		    for (let i = startPage; i <= endPage; i++) {
		        const activeClass = (i === currentPage) ? 'active' : '';
		        $pagination.append(`<button class="page-btn ${activeClass}" data-page="${i}">${i}</button>`);
		    }

		    // 다음 그룹
		    if (hasNext) {
		        $pagination.append(`<button class="page-btn" data-page="${endPage + 1}">»</button>`);
		    }

		    // 이벤트 바인딩
		    $('.page-btn').on('click', function () {
		        const selectedPage = $(this).data('page');
		        loadComments(boardNo, selectedPage);
		    });
		}
		
		function alarmBtnClick(){
			$("#alarm-btn").on('click',function(){
				
				var result = confirm('신고하시겠습니까?')
				if(result===true){
					alert('신고!')
					$("#modal-report").show()
				}
			})
		}
		
		function commentDeleteBtnClick(){
			$(".comment-delete-btn").on('click',function(){
				
				var result = confirm('삭제하시겠습니까?')
				if(result===true){
					
					const commentElement = this.closest('.user-board-element');
				    const commentId = commentElement.dataset.commentId;
				    alert('삭제:'+commentId)
				    
				    
				    $.ajax({
				        url: '/cms/board/user/comment/delete?commentId='+commentId,
				        type: 'DELETE',
				        success: function (response) {
				          //alert("삭제 성공");
				          console.log('댓글 삭제 성공!')
				          // 삭제된 댓글 DOM 제거
				          $('.user-board-element[data-comment-id="' + commentId + '"]').remove();
				        },
				        error: function (xhr, status, error) {
				          alert("삭제 실패: " + xhr.responseText);
				        }
				      });
				    
				}
			})
		}
		
		function modalReportBtnClick(){
			$("#report-btn").on('click',function(){
				
				const reportData = {
				        userBoardNo: $('#board-no').val(),       // 게시글 번호
				        reporterId: $('#author-id').val(),         // 신고자 ID
				        reason: $('#reason').val(),         // 신고 사유 코드 (예: 'SPAM', 'ABUSE')
				        reasonDetail: $('#details').val()      // 상세 사유
				};

				console.log('reportData')
				console.log(reportData)
				
				$.ajax({
			        url: '/cms/report/submit',
			        type: 'POST',
			        data: JSON.stringify(reportData),
			        contentType: 'application/json',
			        success: function (response) {
			          alert('성공!')
			        },
			        error: function (xhr, status, error) {
			          alert("신고 실패: " + xhr.responseText);
			        }
			      });
			})
			
			$("#cancel-btn").on('click',function(){
				$("#modal-report").hide()
			})
		}
		
	</script>
</head>
<body>
	<!-- 신고 모달 -->
	<div id="modal-report" class="modal-overlay">
	  <div class="modal-box">
	    <button class="modal-close" onclick="closeModal()">×</button>
	    <h2 class="modal-title">게시글 신고</h2>
	
	    <label for="reason">신고 사유</label>
	    <select id="reason">
	      <option value="spam">스팸/홍보</option>
	      <option value="abuse">욕설/비방</option>
	      <option value="inappropriate">부적절한 콘텐츠</option>
	      <option value="other">기타</option>
	    </select>
	
	    <label for="details">상세 내용</label>
	    <textarea id="details" rows="4" placeholder="신고 사유를 구체적으로 입력해 주세요."></textarea>
	
	    <div class="modal-buttons">
	      <button id="report-btn">신고하기</button>
	      <button id="cancel-btn">취소</button>
	    </div>
	  </div>
	</div>

	<div id="user-board-view-wrap">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div id="user-board-view">
            <div id="user-board-view-title">
                <div id="title">
                    ${userBoard.title}
                    <c:if test="${loggedIn}">
                    	<span id="alarm-btn" title="신고하기">
                    		<img src="${pageContext.request.contextPath}/resources/static/images/board/alarm.png" alt="">
                    	</span>
                    </c:if>
                </div>
                <div id="info">
                    <span id="writer">
                        <b>작성자</b> ${userBoard.author} ${userBoard.authorId}
                    </span>
                    <span id="write-date">
                        <b>작성일</b>
                        <fmt:formatDate value="${userBoard.createdDate}" pattern="yyyy-MM-dd hh:mm:ss" />
                    </span>
                    <span id="hits">
                        <b>조회수</b> ${userBoard.views}
                    </span>
                </div>
            </div>
            <div id="user-board-view-contents">
                <div id="user-board-view-contents-inner">
					${userBoard.content}
                </div>
                <div id=file-list>
                	<c:forEach var="file" items="${fileList}">
                		<div class="file-element" data-file-id="${file.fileId}" data-file-name="${file.fileName}">
               				<i class="fa-regular fa-file-image"></i> 
               				<a href="/cms/file/download?fileId=${file.fileId}">${file.fileName}</a>
     
               				 <button class="file-delete-btn">
               				 	<i class="fa-solid fa-trash"></i>
               				 </button>
                		</div>
                	</c:forEach>
                </div>
                <div id="user-board-comment-list">
				    <c:forEach var="userBoardComment" items="${userBoardCommentList}">
				        <div class="user-board-element" data-comment-id="${userBoardComment.commentId}">
				                <span class="commenter-name">${userBoardComment.commenter}</span>
				                <span class="comment-content">${userBoardComment.content}</span>
				                <span class="comment-date">${userBoardComment.createdDate}</span>
				                <c:if test="${loggedIn && user.id == userBoardComment.commenterId}">
				                	<span class="comment-update-btn">✏️</span>
				                	<span class="comment-delete-btn">X</span>
				                </c:if>
				        </div>
				    </c:forEach>
				</div>
                <div id="user-board-comment-pagination">
                		<input type="hidden" id="board-no" value="${userBoard.no}"/>
                		<span class="page">
						     	이전
						</span>	    
					    <c:forEach begin="${startPage}" end="${lastPage}" var="page">
						    <span class="page" data-page="${page}">
						        ${page}
						    </span>	    
					    </c:forEach>
					    <span class="page">
						        다음
						</span>	    
                </div>
            </div>
            <div id="button-area">
	            <c:if test="${loggedIn}">
	            	<input type="hidden" id="author-id" value="${userBoard.authorId}">
	            </c:if>
                <c:if test="${loggedIn && user.id == userBoard.authorId}">
                
		        <a href="/cms/board/user/update?no=${userBoard.no}" id="update-btn">
		            <i class="fa-regular fa-pen-to-square"></i> 수정
		        </a>
		        <button id="delete-btn">
		            <i class="fa-solid fa-trash"></i> 삭제
		        </button>
				</c:if>
                <button id="del-test-btn">
                    <i class="fa-solid fa-trash"></i> 파일삭제테스트
                </button>
                <button id="scrap-btn">
                    <i class="fa-solid fa-star"></i> 스크랩
                </button>
                <button id="print-btn">
                    <i class="fa-solid fa-print"></i> 인쇄
                </button>
                <a href="/cms/board/user/list?page=1" id="list-btn">
                    <i class="fa-solid fa-list"></i> 목록으로
                </a>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>
</html>