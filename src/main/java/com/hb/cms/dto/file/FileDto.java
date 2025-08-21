package com.hb.cms.dto.file;

import java.security.Timestamp;

public class FileDto {
    private int fileId; // 파일 ID
    private int no; // 게시글 ID
    private String fileName; // 파일 이름
    private String originalFileName; // 원본 파일 이름
    private long fileSize; // 파일 크기
    private String fileType; // 파일 타입
    private String filePath; // 파일 경로
    private Timestamp uploadDate; // 업로드 날짜

    // 기본 생성자
    public FileDto() {}

    // 전체 필드를 받는 생성자
    public FileDto(int fileId, int no, String fileName, String originalFileName,
                   long fileSize, String fileType, String filePath, Timestamp uploadDate) {
        this.fileId = fileId;
        this.no = no;
        this.fileName = fileName;
        this.originalFileName = originalFileName;
        this.fileSize = fileSize;
        this.fileType = fileType;
        this.filePath = filePath;
        this.uploadDate = uploadDate;
    }

    // Getter와 Setter

    public int getFileId() {
        return fileId;
    }

    public void setFileId(int fileId) {
        this.fileId = fileId;
    }

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getOriginalFileName() {
        return originalFileName;
    }

    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }

    public long getFileSize() {
        return fileSize;
    }

    public void setFileSize(long fileSize) {
        this.fileSize = fileSize;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public Timestamp getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Timestamp uploadDate) {
        this.uploadDate = uploadDate;
    }
    
    public void showFileInfo() {
    	System.out.println("파일아이디:"+fileId);
    	System.out.println("게시글번호:"+no);
    	System.out.println("파일이름:"+fileName);
    	System.out.println("원본파일이름:"+originalFileName);
    	System.out.println("파일크기:"+fileSize);
    	System.out.println("파일타입:"+fileType);
    	System.out.println("파일경로:"+filePath);
    	System.out.println("업로드날짜:"+uploadDate);
    }
}