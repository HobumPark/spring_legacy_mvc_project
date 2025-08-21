package com.hb.cms.dto.email;

import java.time.LocalDateTime;

public class EmailDto {
    
    private Long id;                // PK
    private String sender;       	// 보낸사람
    private String subject;         // 제목
    private String content;         // 내용
    private LocalDateTime sentAt;   // 보낸시간
    private String status;          // 상태
    private String errorMessage;    // 오류
    
    public EmailDto() {}

    public EmailDto(Long id, String sender, String subject, String content,
                   LocalDateTime sentAt, String status, String errorMessage) {
        this.id = id;
        this.sender = sender;
        this.subject = subject;
        this.content = content;
        this.sentAt = sentAt;
        this.status = status;
        this.errorMessage = errorMessage;
    }

    // getter/setter �깮�왂
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getSentAt() {
        return sentAt;
    }

    public void setSentAt(LocalDateTime sentAt) {
        this.sentAt = sentAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    
    @Override
    public String toString() {
        return "EmailDto{" +
                "id=" + id +
                ", sender='" + sender + '\'' +
                ", subject='" + subject + '\'' +
                ", content='" + content + '\'' +
                ", sentAt=" + sentAt +
                ", status='" + status + '\'' +
                ", errorMessage='" + errorMessage + '\'' +
                '}';
    }
}
