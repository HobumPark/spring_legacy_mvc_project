package com.hb.cms.service.board;

import java.util.List;
import com.hb.cms.dto.board.UserBoardDto;
import com.hb.cms.dto.file.FileDto;

public interface UserBoardService {
	List<UserBoardDto> getAllUserBoards(int page, int pageSize) throws Exception;
	
	List<UserBoardDto> getHomeUserBoards(int page, int pageSize) throws Exception;
	
	UserBoardDto getUserBoardByNo(int no) throws Exception;//글 상세보기
	
	int increaseViewCount(int no) throws Exception;//글 조회수 증가
	
	List<FileDto> getFileListByUserBoardNo(int no) throws Exception;//글 상세보기 - 파일정보 가져오기
	//파일 정보 가져오기
	
	int getTotalUserBoardCount() throws Exception;
	
	int addUserBoard(UserBoardDto userBoardDto) throws Exception;
	
	int updateUserBoard(int no,String title,String content) throws Exception;
	
	int deleteUserBoard(int no) throws Exception;
	
	int getLastUserBoardNo() throws Exception;
	
	List<UserBoardDto> searchUserBoards(int page, int pageSize, String searchInput) throws Exception;
	
	int getUserBoardSearchCount(String searchInput) throws Exception;
	
	int setUserBoardHasFile(int lastNo) throws Exception; //파일첨부 - true
	
	int unSetUserBoardHasFile(int lastNo) throws Exception; //파일첨부 - false
}