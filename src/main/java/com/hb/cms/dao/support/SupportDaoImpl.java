package com.hb.cms.dao.support;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hb.cms.dto.email.EmailDto;

@Repository
public class SupportDaoImpl implements SupportDao  {
	
	@Autowired
    private SqlSession sqlSession;
	
	private static final String SupportNameSpace = "resources.mapper.support.SupportMapper";
	
	public int saveEmail(EmailDto emailDto) throws Exception{
		// save email
	    Map<String, Object> params = new HashMap<>();
	    
	    // EmailDto에서 필요한 값을 모두 Map에 넣기
	    params.put("sender", emailDto.getSender());
	    params.put("subject", emailDto.getSubject());
	    params.put("content", emailDto.getContent());
	    params.put("sentAt", emailDto.getSentAt());
	    params.put("status", emailDto.getStatus());
	    params.put("errorMessage", emailDto.getErrorMessage());
	    
	    // sqlSession.insert 호출
	    return sqlSession.insert(SupportNameSpace + ".saveEmail", params);
	}
}