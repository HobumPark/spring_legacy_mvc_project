package com.hb.cms.dao.test;

import java.util.List;
import com.hb.cms.dto.test.TestDto;


public interface TestDao {
	public List<TestDto> getTestList() throws Exception;
	
}