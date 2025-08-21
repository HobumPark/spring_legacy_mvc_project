package com.hb.cms.service.users;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.hb.cms.dao.users.UsersDao;
import com.hb.cms.dto.users.UserDto;

@Service
public class UsersServiceImpl implements UsersService {
	
	@Autowired
    private UsersDao dao;
	
	@Override
	public UserDto login(String id,String password) throws Exception{
		return dao.login(id, password);
	}
	
	@Override
	public boolean checkUserIdDuplicate(String id) throws Exception{
		return dao.checkUserIdDuplicate(id);
	}
	
	@Override
	public int join(UserDto user) throws Exception{
		return dao.join(user);
	}
	
	@Override
	public int deactivateUser(String userId) throws Exception{
		return dao.deactivateUser(userId);
	}
	
	@Override
	public int updateUserInfo(UserDto user) throws Exception{
		return dao.updateUserInfo(user);
	}
	
}