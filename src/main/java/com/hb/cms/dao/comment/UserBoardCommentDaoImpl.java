package com.hb.cms.dao.comment;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.hb.cms.dto.comment.UserBoardCommentDto;

@Repository
public class UserBoardCommentDaoImpl implements UserBoardCommentDao {
	
	@Autowired
    private SqlSession sqlSession;
	
	private static final String UserBoardNameSpace = "resources.mapper.comment.UserBoardCommentMapper";
	
	@Override
	public List<UserBoardCommentDto> getUserBoardCommentsByBoardNo(int userBoardNo, @Param("offset") int offset, @Param("limit") int limit) throws Exception{
		System.out.println("getAllUserBoards");

		// 파라미터 Map 생성
        Map<String, Object> params = new HashMap<>();
        params.put("userBoardNo", userBoardNo);
        params.put("offset", offset);
        params.put("limit", limit);
        
		return sqlSession.selectList(UserBoardNameSpace+".selectUserBoardCommentsByBoardNo", params);
	}
	
	@Override
	public int deleteUserBoardCommentByCommentId(int commentId) throws Exception{
		// 파라미터 Map 생성
        Map<String, Object> params = new HashMap<>();
        params.put("commentId", commentId);
		
		return sqlSession.delete(UserBoardNameSpace+".deleteUserBoardCommentByCommentId", params);
	}
	
	@Override
	public int countUserBoardComments(int userBoardNo) throws Exception {
		System.out.println("countUserBoardComments");

		// 파라미터 Map 생성
        Map<String, Object> params = new HashMap<>();
        params.put("userBoardNo", userBoardNo);
        
		return sqlSession.selectOne(UserBoardNameSpace+".countUserBoardCommentsByBoardNo", params);
	}
	
}