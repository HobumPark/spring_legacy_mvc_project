package com.hb.cms.dao.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.hb.cms.dto.board.UserBoardDto;
import com.hb.cms.dto.file.FileDto;

@Repository
public class UserBoardDaoImpl implements UserBoardDao {
	
	@Autowired
    private SqlSession sqlSession;
	
	private static final String UserBoardNameSpace = "resources.mapper.board.UserBoardMapper";
	private static final String FileNameSpace = "resources.mapper.board.FileMapper";
	
	@Override
	public List<UserBoardDto> getAllUserBoards(@Param("offset") int offset, @Param("limit") int limit) throws Exception{
		System.out.println("getAllUserBoards");

		// 파라미터 Map 생성
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("limit", limit);
        
		return sqlSession.selectList(UserBoardNameSpace+".selectAllUserBoards", params);
	}
	
	
	@Override
	public List<UserBoardDto> getHomeUserBoards(@Param("offset") int offset, @Param("limit") int limit) throws Exception{
		System.out.println("getHomeUserBoards");

		// 파라미터 Map 생성
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("limit", limit);
        
		return sqlSession.selectList(UserBoardNameSpace+".selectHomeUserBoards", params);
	}
	
	//글 상세보기
	@Override
	public UserBoardDto getUserBoardByNo(int no) throws Exception{
		System.out.println("getUserBoardByNo");
		System.out.println("no:"+no);
		
		return sqlSession.selectOne(UserBoardNameSpace+".selectUserBoardByNo", no);
	}
	
	@Override
	public int increaseViewCount(int no) throws Exception {
		System.out.println("increaseViewCount");
		System.out.println("no:"+no);
		
		return sqlSession.update(UserBoardNameSpace+".updateViewCount", no);
	}
	
	//글 상세보기 - 파일정보
	public List<FileDto> getFileListByUserBoardNo(int no) throws Exception{
		System.out.println("getFileListByUserBoardNo");
		System.out.println("no:"+no);
		return sqlSession.selectList(FileNameSpace+".selectFileListByUserBoardNo", no);
	}
	
	@Override
	public int getTotalUserBoardCount() throws Exception{
		System.out.println("getTotalUserBoardCount");
		
		return sqlSession.selectOne(UserBoardNameSpace+".countAllUserBoards");
	}
	
	@Override
	public int addUserBoard(UserBoardDto userBoardDto) throws Exception{
		System.out.println("addUserBoard");
		System.out.println(userBoardDto);
		return sqlSession.insert(UserBoardNameSpace+".insertUserBoard",userBoardDto);
	}
	
	@Override
	public int updateUserBoard(int no,String title,String content) throws Exception{
		System.out.println("updateUserBoard");
		System.out.println("no:"+no);
		System.out.println("title:"+title);
		System.out.println("content"+content);
		
		// 파라미터 Map 생성
        Map<String, Object> params = new HashMap<>();
        params.put("no", no);
        params.put("title", title);
        params.put("content", content);
		
		return sqlSession.insert(UserBoardNameSpace+".updateUserBoard",params);
	}
	
	@Override
	public int deleteUserBoard(int no) throws Exception{
		
		
		return sqlSession.delete(UserBoardNameSpace+".deleteUserBoard",no);
	}
	
	@Override
	public int getLastUserBoardNo() throws Exception{
		return sqlSession.selectOne(UserBoardNameSpace+".selectLastUserBoardNo");
	}
	
	//사용자 게시판 검색
	@Override
	public List<UserBoardDto> searchUserBoards(@Param("offset") int offset, @Param("limit") int limit, String searchInput) throws Exception{
		// 파라미터 Map 생성
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("limit", limit);
        params.put("searchInput", searchInput);
        
		return sqlSession.selectList(UserBoardNameSpace+".searchUserBoards", params);
	}
	
	@Override
	public int getUserBoardSearchCount(String searchInput) throws Exception{
		Map<String, Object> params = new HashMap<>();

        params.put("searchInput", searchInput);
        
		return sqlSession.selectOne(UserBoardNameSpace+".countSearchUserBoards", params);
	}
	
	@Override
	public int setUserBoardHasFile(int lastNo) throws Exception{
		// 파라미터 Map 생성
        Map<String, Object> params = new HashMap<>();
        params.put("no", lastNo);
		return sqlSession.update(UserBoardNameSpace+".updateUserBoardHasFile", params);
	}
	
	@Override
	public int unSetUserBoardHasFile(int lastNo) throws Exception{
		// 파라미터 Map 생성
        Map<String, Object> params = new HashMap<>();
        params.put("no", lastNo);
		return sqlSession.update(UserBoardNameSpace+".updateUserBoardNotHasFile", params);
	}
}