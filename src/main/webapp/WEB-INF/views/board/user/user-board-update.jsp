<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8"> <!-- 추가할부분 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- 추가할부분 -->
	<meta http-equiv="X-UA-Compatible" content="ie=edge"> <!-- 추가할부분 -->
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/common/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/common/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/board/user/user-board-update.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
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
            ckeditorSet();
            sendFileBtnClick();
            fileSelectChange();
            fileDelete();
        })  
        
        function ckeditorSet(){
            CKEDITOR.replace("board-textarea",ckeditor_config)
        }
        
        function sendFileBtnClick(){
            $("#send-file-btn").on("click", function(){
            	alert('업로드!')
                const files = $("#file-input")[0].files;
                if(files.length === 0){
                    alert("업로드할 파일을 선택해주세요.");
                    return;
                }
                
                const urlParams = new URLSearchParams(window.location.search);
                const userBoardNo = urlParams.get("no"); // "1" (문자열)

                if (!userBoardNo) {
                    alert("게시글 번호가 없습니다.");
                    return;
                }

                let formData = new FormData();
                for(let i=0; i<files.length; i++){
                    formData.append("files", files[i]); // key "files"는 서버측에서 맞게 받는 이름으로 맞춰주세요
                }
                formData.append("userBoardNo", userBoardNo);  // ← 실제 게시글 번호 값으로 교체
                
                $.ajax({
                    url: '/cms/file/upload',  // 실제 파일 업로드 처리 URL로 변경하세요
                    type: 'POST',
                    data: formData,
                    processData: false,  // jQuery가 데이터를 문자열로 변환하지 않도록 설정
                    contentType: false,  // multipart/form-data로 자동 설정되도록 false
                    success: function(response){
                        alert("파일 업로드 성공!");
                        // 필요하면 업로드 후 처리(파일 목록 갱신 등) 추가
                        $("#file-info").empty();
                        $("#file-input").val(""); // 파일 input 초기화
                        
                        console.log('file upload response')
                        console.log(response)
                        
                        $("#file-list").empty();
                        
                     	// 2) 새로 받은 파일 리스트를 화면에 추가
                        response.forEach(function(file){
                        	console.log('file')
                        	console.log(file)
                        	console.log(file.fileName)
                        	
                            const fileElement =
							    '<div class="file-element" data-file-id="' + file.fileId + '" data-file-name="' + file.fileName + '">' +
							        '<i class="fa-regular fa-file-image"></i>' +
							        '<a href="/cms/file/download?fileId=' + file.fileId + '">' + file.fileName + '</a>' +
							        '<button class="file-delete-btn" type="button">' +
							            '<i class="fa-solid fa-trash"></i>' +
							        '</button>' +
							    '</div>';;
                            console.log('fileElement');
                            console.log(fileElement);
                            
                            $("#file-list").append(fileElement);
                        	
                        });
                    },
                    error: function(xhr, status, error){
                        alert("파일 업로드 실패: " + error);
                    }
                });
            });
        }
        
        function fileSelectChange(){
            $("#file-input").on("change", function() {
                const files = this.files;
                if(files.length > 0) {
                    let fileNames = [];
                    for(let i=0; i<files.length; i++){
                        fileNames.push(files[i].name);
                    }
                    $("#file-info").html(fileNames.join("<br>"));
                } else {
                    $("#file-info").text("선택된 파일 없음");
                }
            });
        }
        
 		function fileDeleteTemp(){
 			$(".file-delete-btn").on('click',function(){
 				alert('삭제!')
 				
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
 		
 		function fileDelete(){
 			$(document).on('click', '.file-delete-btn', function() {
 			    alert('삭제!');

 			    var isDelete = confirm('삭제하시겠습니까?');
 			    if(isDelete == true){
 			        alert('파일삭제 진행!');

 			        const $fileElement = $(this).closest('.file-element');
 			        const fileId = $fileElement.data("file-id");
 			        const fileName = $fileElement.data("file-name");

 			        console.log("fileId:"+fileId);
 			        console.log("fileName:"+fileName);

 			        $.ajax({
 			            type : 'POST',
 			            url : `/cms/file/delete`,
 			            data: {"fileId":fileId,"fileName":fileName},
 			            async : true,
 			            dataType : 'json',
 			            success : function(result) {
 			                console.log('result', result);
 			                $fileElement.remove();
 			            },
 			            error : function(request, status, error) {
 			                console.log(error);
 			            }
 			        });
 			    }
 			});

 		}
        
    </script>
</head>
<body>
	<div id="user-board-update-wrap">
        <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
        <div id="user-board-update">
            <form action="/cms/board/user/update" method="post" accept-charset="UTF-8">
                <div id="user-board-update-title">
                    <div id="user-board-update-title-01">
                        <span>
                            	제목
                        </span>
                        <span>
                        	<input type="hidden" id="no" value="${userBoard.no}" name="no"/>
                            <input type="text" id="input-title" value="${userBoard.title}" name="input-title"/>
                        </span>
                    </div>
                    <div id="user-board-update-title-02">
                        <span>
                           	 작성자
                        </span>
                        <span>
                            <input type="text" id="input-writer" value="${userBoard.author}" disabled/>
                        </span>
                       	<span>
                            	작성일
                        </span>
                        <span>
                            <b>2024-11-15</b>
                        </span>
                    </div>
                    <div id="user-board-update-title-03">
                        <span>
                            	비밀글 여부
                        </span>
                        <span>
                            <input type="radio" name="secret" id="input-secret" value="yes" checked>
                            <b>예</b>
                            <input type="radio" name="secret" id="input-secret" value="no">
                            <b>아니오</b>
                        </span>
                        <span>
                            	연락처
                        </span>
                        <span>
                            <input type="text" id="input-phone" value="${userBoard.phoneNumber}"disabled/>
                            <br>
                            (관리자만 열람가능)
                        </span>
                    </div>
                </div>
                <div id="user-board-update-contents">
                    <textarea id="board-textarea" name="board-textarea">
                    	${userBoard.content}
                    </textarea>
                </div>
                <div id="file-attach-area">
    				 <div id=file-list>
	                	<c:forEach var="file" items="${fileList}">
	                		<div class="file-element" data-file-id="${file.fileId}" data-file-name="${file.fileName}">
	               				<i class="fa-regular fa-file-image"></i> 
	               				<a href="/cms/file_download?fileId=${file.fileId}">${file.fileName}</a>
	     
	               				 <button class="file-delete-btn" type="button">
	               				 	<i class="fa-solid fa-trash"></i>
	               				 </button>
	                		</div>
	                	</c:forEach>
	                </div>
	                <div>
	                	<input type="file" name="files" id="file-input" multiple>
					    <button type="button" id="send-file-btn">파일 추가</button>
					    
					    <div id="file-info"></div>
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
            </form>
            
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
    </div>
</body>
</html>