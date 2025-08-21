package com.hb.cms.service.test;

import java.util.List;
import com.hb.cms.dto.test.TestDto;

public interface TestService {
	List<TestDto> getTestList() throws Exception;
	
}