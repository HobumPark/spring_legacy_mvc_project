package com.hb.cms.dao.board;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hb.cms.dto.board.UserBoardDto;
import com.hb.cms.dto.file.FileDto;

public interface UserBoardDao {
	public List<UserBoardDto> getAllUserBoards(@Param("offset") int offset, @Param("limit") int limit) throws Exception;

	public List<UserBoardDto> getHomeUserBoards(@Param("offset") int offset, @Param("limit") int limit) throws Exception;
	
	public UserBoardDto getUserBoardByNo(@Param("no") int no) throws Exception;//글 상세보기
	
	public List<FileDto> getFileListByUserBoardNo(int no) throws Exception;

	public int increaseViewCount(int no) throws Exception;
		
	public int getTotalUserBoardCount() throws Exception;
	
	public int addUserBoard(UserBoardDto userBoardDto) throws Exception;
	
	public int updateUserBoard(int no,String title,String content) throws Exception;
	
	public int deleteUserBoard(int no) throws Exception;
	
	public int getLastUserBoardNo() throws Exception;
	
	public List<UserBoardDto> searchUserBoards(@Param("offset") int offset, @Param("limit") int limit, String searchInput) throws Exception;
	
	public int getUserBoardSearchCount(String searchInput) throws Exception;
	
	public int setUserBoardHasFile(int lastNo) throws Exception;
	
	public int unSetUserBoardHasFile(int lastNo) throws Exception;
	
}