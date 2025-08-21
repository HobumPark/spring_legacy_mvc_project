package com.hb.cms.dto.comment;

import java.time.LocalDateTime;

public class UserBoardCommentDto {

    private int commentId;        // comment_id
    private int boardNo;          // board_no
    private String commenter;     // commenter
    private String commenterId;   // commenter_id
    private String content;       // content
    private LocalDateTime createdDate; // created_date
    private boolean isDeleted;    // is_deleted

    public UserBoardCommentDto() {}

    public UserBoardCommentDto(int commentId, int boardNo, String commenter, String commenterId, String content,
                               LocalDateTime createdDate, boolean isDeleted) {
        this.commentId = commentId;
        this.boardNo = boardNo;
        this.commenter = commenter;
        this.commenterId = commenterId;
        this.content = content;
        this.createdDate = createdDate;
        this.isDeleted = isDeleted;
    }

    // Getters and Setters
    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getBoardNo() {
        return boardNo;
    }

    public void setBoardNo(int boardNo) {
        this.boardNo = boardNo;
    }

    public String getCommenter() {
        return commenter;
    }

    public void setCommenter(String commenter) {
        this.commenter = commenter;
    }

    public String getCommenterId() {
        return commenterId;
    }

    public void setCommenterId(String commenterId) {
        this.commenterId = commenterId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    @Override
    public String toString() {
        return "UserBoardCommentDto{" +
                "commentId=" + commentId +
                ", boardNo=" + boardNo +
                ", commenter='" + commenter + '\'' +
                ", commenterId='" + commenterId + '\'' +
                ", content='" + content + '\'' +
                ", createdDate=" + createdDate +
                ", isDeleted=" + isDeleted +
                '}';
    }
}
