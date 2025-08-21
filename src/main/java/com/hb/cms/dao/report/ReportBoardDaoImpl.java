package com.hb.cms.dao.report;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.hb.cms.dto.report.ReportBoardDto;

public class ReportBoardDaoImpl implements ReportBoardDao {
	
	@Autowired
    private SqlSession sqlSession;
	
	private static final String ReportBoardNameSpace = "resources.mapper.report.ReprtBoardMapper";
	
	public int submitReport(ReportBoardDto reportBoardDto) throws Exception{
		
		// 파라미터 Map 생성
        Map<String, Object> params = new HashMap<>();
        params.put("offset", "");
        params.put("limit", "");
		
		return sqlSession.insert(ReportBoardNameSpace+".insertReport", params);
	}
}