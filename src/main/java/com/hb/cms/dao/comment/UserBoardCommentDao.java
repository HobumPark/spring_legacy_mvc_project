package com.hb.cms.dao.comment;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.hb.cms.dto.comment.UserBoardCommentDto;

public interface UserBoardCommentDao {

	public List<UserBoardCommentDto> getUserBoardCommentsByBoardNo(int userBoardNo, @Param("offset") int offset, @Param("limit") int limit) throws Exception;
	
	public int deleteUserBoardCommentByCommentId(int commentId) throws Exception;
	
	public int countUserBoardComments(int userBoardNo) throws Exception;
}