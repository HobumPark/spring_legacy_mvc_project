package com.hb.cms.dao.report;

import java.util.List;

import com.hb.cms.dto.report.ReportBoardDto;

public interface ReportBoardDao {
	int submitReport(ReportBoardDto reportBoardDto) throws Exception;
	
}