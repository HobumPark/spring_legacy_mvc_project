package com.hb.cms.dao.users;

import com.hb.cms.dto.users.UserDto;

public interface UsersDao {
	public UserDto login(String id,String password) throws Exception;
	
	public boolean checkUserIdDuplicate(String id) throws Exception;
	
	public int join(UserDto user) throws Exception;
	
	public int deactivateUser(String userId) throws Exception;
	
	public int updateUserInfo(UserDto user) throws Exception;
}
