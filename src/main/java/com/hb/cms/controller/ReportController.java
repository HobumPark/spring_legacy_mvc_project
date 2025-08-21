package com.hb.cms.controller;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hb.cms.service.report.ReportBoardService;
import com.hb.cms.dto.report.ReportBoardDto;


@Controller
public class ReportController {
	
	@Autowired
    private ReportBoardService reportBoardService;
	
	@RequestMapping(value = "/report/submit", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> submitReport(Locale locale, Model model,
			@RequestBody Map<String, String> data) {
		System.out.println("/report/submit");
		
	    Map<String, Object> result = new HashMap<>();
	    try {
	    	String userBoardNoStr = data.get("userBoardNo");
	        String reporterId = data.get("reporterId");
	        String reason = data.get("reason");
	        String reasonDetail = data.get("reasonDetail");
	        
	        int userBoardNo = Integer.parseInt(userBoardNoStr);
	        
	        System.out.println("userBoardNo:"+userBoardNo);
	        System.out.println("reporterId:"+reporterId);
	        System.out.println("reason:"+reason);
	        System.out.println("reasonDetail:"+reasonDetail);
	    	ReportBoardDto dto = new ReportBoardDto();
	    	dto.setUserBoardId(userBoardNo);
	    	dto.setReporterId(reporterId);
	    	dto.setReasonCode(reason);
	    	dto.setReasonDetail(reasonDetail);
	    	
	        reportBoardService.submitReport(dto);
	        
	        boolean isReport = true;
	        result.put("report", isReport);
	        result.put("message", isReport ? "�떊怨좎셿猷�" : "�떊怨좎떎�뙣");
	        return ResponseEntity.ok(result);
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("error", "�꽌踰� �삤瑜�");
	        return ResponseEntity.status(500).body(result);
	    }
	}
	
}
