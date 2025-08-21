package com.hb.cms.service.test;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hb.cms.dao.test.TestDao;
import com.hb.cms.dto.test.TestDto;

@Service
public class TestServiceImpl implements TestService {
	@Autowired
    private TestDao dao;
	
	@Override
	public List<TestDto> getTestList() throws Exception{
		return dao.getTestList();
	}
	
}