package com.hb.cms.service.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hb.cms.dao.comment.UserBoardCommentDao;
import com.hb.cms.dto.comment.UserBoardCommentDto;
import com.hb.cms.dto.file.FileDto;

@Service
public class UserBoardCommentServiceImpl implements UserBoardCommentService {
	
	@Autowired
	private UserBoardCommentDao dao;
	
	public List<UserBoardCommentDto> getUserBoardCommentsByBoardNo(int userBoardNo, int page, int pageSize) throws Exception {
		int offset = (page - 1) * pageSize;
		return dao.getUserBoardCommentsByBoardNo(userBoardNo, offset, pageSize);
	}
	
	public int deleteUserBoardCommentByCommentId(int commentId) throws Exception{
		return dao.deleteUserBoardCommentByCommentId(commentId);
	}
	
	public int countUserBoardComments(int userBoardNo) throws Exception {
		return dao.countUserBoardComments(userBoardNo);
	}
}