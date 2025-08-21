package com.hb.cms.dao.users;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.hb.cms.dto.users.UserDto;

@Repository
public class UsersDaoImpl implements UsersDao {
	
	@Autowired
    private SqlSession sqlSession;
	
	private static final String TestNameSpace = "resources.mapper.users.UsersMapper";
	
	@Override
	public UserDto login(String id,String password) throws Exception{
		
		// 파라미터 Map 생성
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("password", password);
        
		
        return sqlSession.selectOne(TestNameSpace+".findUserByIdAndPassword", params);
	}
	
	@Override
	public boolean checkUserIdDuplicate(String id) throws Exception{
		// 파라미터 Map 생성
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        
		return sqlSession.selectOne(TestNameSpace+".checkUserIdDuplicate", params);
	}
	
	@Override
	public int join(UserDto user) throws Exception{
		return sqlSession.insert(TestNameSpace+".insertUser", user);
	}
	
	@Override
	public int deactivateUser(String userId) throws Exception{
		return sqlSession.update(TestNameSpace+".deactivateUser", userId);
	}
	
	@Override
	public int updateUserInfo(UserDto user) throws Exception{
		return sqlSession.update(TestNameSpace+".updateUserInfo", user);
	}
}
