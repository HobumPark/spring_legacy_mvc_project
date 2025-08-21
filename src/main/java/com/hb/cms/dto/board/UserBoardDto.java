package com.hb.cms.dto.board;

import java.text.SimpleDateFormat;
import java.util.Date;

public class UserBoardDto {

    private Integer no;               // 게시글 번호
    private String title;             // 게시글 제목
    private String content; 	      // 게시글 내용
    private String author;            // 작성자
    private String authorId;		  // 작성자 아이디
    private String phoneNumber;            // 연락처
    private Date createdDate; // 작성일
    private Integer views;            // 조회수
    private String filePath;          // 파일 경로
    private Boolean hasFile;          // 파일 첨부 여부

    // 기본 생성자
    public UserBoardDto() {
    }

    // 모든 필드를 포함한 생성자
    public UserBoardDto(Integer no,       String title,    String content, 
			    		String author,    String authorId, String phoneNumber, 
			    		Date createdDate, Integer views,   String filePath, Boolean hasFile) {
        this.no = no;
        this.title = title;
        this.content = content;
        this.author = author;
        this.authorId = authorId;
        this.phoneNumber = phoneNumber;
        this.createdDate = createdDate;
        this.views = views;
        this.filePath = filePath;
        this.hasFile = hasFile;
    }

    // Getter 및 Setter 메서드
    public Integer getNo() {
        return no;
    }

    public void setNo(Integer no) {
        this.no = no;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
    
    public String getAuthorId() {
        return authorId;
    }

    public void setAuthorId(String authorId) {
        this.authorId = authorId;
    }
    
    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNum(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    
    //날짜 변환
    public Date getCreatedDate() {
    	//SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //return formatter.format(createdDate); // Date -> String 변환
    	return this.createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }
    
    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
    
    public Boolean getHasFile() {
        return hasFile;
    }

    public void setHasFile(Boolean hasFile) {
        this.hasFile = hasFile;
    }


    public void showUserBoardInfo() {
        System.out.println("글번호:"+no);
        System.out.println("제목:"+title);
        System.out.println("내용:"+content);
        System.out.println("글쓴이:"+author);
        System.out.println("전화번호:"+phoneNumber);
        System.out.println("글쓴날짜:"+createdDate);
        System.out.println("조회수:"+views);
        System.out.println("파일경로:"+filePath);
        System.out.println("파일포함여부:"+hasFile);
    }
}