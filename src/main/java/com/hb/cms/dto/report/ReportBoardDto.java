package com.hb.cms.dto.report;

import java.time.LocalDateTime;

public class ReportBoardDto {

    private Integer reportId;           // 신고 고유 ID (Auto-increment)
    private Integer userBoardId;        // 신고 대상 게시글 ID
    private String reporterId;          // 신고한 사용자 ID (VARCHAR(50))
    private String reasonCode;          // 신고 사유 코드 (예: "SPAM", "ABUSE")
    private String reasonDetail;        // 신고 상세 설명 (선택)
    private LocalDateTime createdAt;    // 신고 생성일시

    // 기본 생성자
    public ReportBoardDto() {}

    // 전체 생성자
    public ReportBoardDto(Integer reportId, Integer userBoardId, String reporterId, String reasonCode, String reasonDetail, LocalDateTime createdAt) {
        this.reportId = reportId;
        this.userBoardId = userBoardId;
        this.reporterId = reporterId;
        this.reasonCode = reasonCode;
        this.reasonDetail = reasonDetail;
        this.createdAt = createdAt;
    }

    // Getters and Setters

    public Integer getReportId() {
        return reportId;
    }

    public void setReportId(Integer reportId) {
        this.reportId = reportId;
    }

    public Integer getUserBoardId() {
        return userBoardId;
    }

    public void setUserBoardId(Integer userBoardId) {
        this.userBoardId = userBoardId;
    }

    public String getReporterId() {
        return reporterId;
    }

    public void setReporterId(String reporterId) {
        this.reporterId = reporterId;
    }

    public String getReasonCode() {
        return reasonCode;
    }

    public void setReasonCode(String reasonCode) {
        this.reasonCode = reasonCode;
    }

    public String getReasonDetail() {
        return reasonDetail;
    }

    public void setReasonDetail(String reasonDetail) {
        this.reasonDetail = reasonDetail;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "ReportBoardDto{" +
                "reportId=" + reportId +
                ", userBoardId=" + userBoardId +
                ", reporterId='" + reporterId + '\'' +
                ", reasonCode='" + reasonCode + '\'' +
                ", reasonDetail='" + reasonDetail + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
