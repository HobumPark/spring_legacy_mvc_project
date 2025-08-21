package com.hb.cms.service.report;

import java.util.List;
import com.hb.cms.dto.report.ReportBoardDto;

public interface ReportBoardService {
	int submitReport(ReportBoardDto reportBoardDto) throws Exception;

}