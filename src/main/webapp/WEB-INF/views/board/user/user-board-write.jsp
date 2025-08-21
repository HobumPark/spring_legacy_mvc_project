<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/common/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/common/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/board/user/user-board-write.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/static/ckeditor/ckeditor.js"></script>
    <script>
    
        var ckeditor_config = {
            height: 470,
            enterMode :  CKEDITOR.ENTER_BR.CKEDITOR,
            shiftEnterMode : CKEDITOR.ENTER_P,
            filebrowserUploadUrl:''
        }

        function writePost(){
            alert("글 등록!")
            const text=CKEDITOR.instances.board_textarea.getData()
            alert(text)
        }

        function cancelPost(){
            alert("글 취소!")
        }

        $(document).ready(function(){
            ckeditorSet()
            fileInputChange()
        })  
        
        function ckeditorSet(){
            CKEDITOR.replace("board-textarea",ckeditor_config)
        }
        
        
        function fileInputChange(){

            $("#file-input").on('change',function(event){
             const files = event.target.files; // FileList 객체
             for (let i = 0; i < files.length; i++) {
                 const file = files[i];
                 console.log(`파일명: ${file.name}`);
                 console.log(`파일 크기: ${file.size} bytes`);
                 console.log(`파일 형식: ${file.type}`);
                 console.log(`마지막 수정 날짜: ${file.lastModifiedDate}`);


                 $("#file-info").append(
           		    "<div class='file-element'>" +
           		        file.name + " (" + file.size + " bytes)" +
           		    "</div>"
                	);
             	}
            })
         };
    </script>
</head>
<body>
	<div id="user-board-write-wrap">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <form action="/cms/board/user/write" method="post" accept-charset="UTF-8" enctype="multipart/form-data">
	        <div id="user-board-write">
	                <div id="user-board-write-title">
	                    <div id="user-board-write-title-01">
	                        <span>
	                            	제목
	                        </span>
	                        <span>
	                            <input type="text" id="input-title" name="input-title"/>
	                        </span>
	                    </div>
	                    <div id="user-board-write-title-02">
	                        <span>
	                            	작성자
	                        </span>
	                        <span>
	                            <input type="text" id="input-writer" name="input-writer" value="${user.username}" readonly/>
	                            <input type="text" id="input-id" name="input-id" value="${user.id}" hidden/>
	                        </span>
	                        <span>
	                            	작성일
	                        </span>
	                        <span>
	                            <b>2024-11-15</b>
	                        </span>
	                    </div>
	                    <div id="user-board-write-title-03">
	                        <span>
	                           	 비밀글 여부
	                        </span>
	                        <span>
	                            <input type="radio" name="secret" class="input-secret" value="yes" checked>
	                            <b>예</b>
	                            <input type="radio" name="secret" class="input-secret" value="no">
	                            <b>아니오</b>
	                        </span>
	                        <span>
	                            	연락처
	                        </span>
	                        <span>
	                            <input type="text" id="input-phone" name="input-phone" value="${user.phoneNumber}" readonly/>
	                            <br>
	                            (관리자만 열람가능)
	                        </span>
	                    </div>
	                </div>
	                <div id="user-board-write-contents">
	                    <textarea id="board-textarea" name="board-textarea"></textarea>
	                </div>
	                <div id="file-attach-area">
	    				<input type="file" name="files" id="file-input" multiple>
	                    <div id="file-info">
	                        
	                    </div>
	                </div>
	                <div id="button-area">
	                    <button id="preview-btn">
	                        	미리보기
	                    </button>
	                    <button id="write-btn" type="submit">
	                        <i class="fa-solid fa-pencil"></i> 저장하기
	                    </button>
	                    <button id="list-btn">
	                        <i class="fa-solid fa-list"></i>목록으로
	                    </button>
	                </div>
	        </div>
        </form>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>
</html>