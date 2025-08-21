package com.hb.cms.dao.test;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hb.cms.dto.test.TestDto;

@Repository
public class TestDaoImpl implements TestDao {
	
	@Autowired
    private SqlSession sqlSession;
	
	private static final String TestNameSpace = "resources.mapper.test.TestMapper";
	
	@Override
	public List<TestDto> getTestList() throws Exception{
		return sqlSession.selectList(TestNameSpace+".selectTestList");
	}
}