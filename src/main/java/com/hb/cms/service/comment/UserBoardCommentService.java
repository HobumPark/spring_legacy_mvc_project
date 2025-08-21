package com.hb.cms.service.comment;

import java.util.List;
import com.hb.cms.dto.comment.UserBoardCommentDto;

public interface UserBoardCommentService {
	List<UserBoardCommentDto> getUserBoardCommentsByBoardNo(int userBoardNo, int page, int pageSize) throws Exception;
	
	int deleteUserBoardCommentByCommentId(int commentId) throws Exception;
	
	int countUserBoardComments(int userBoardNo) throws Exception;
}