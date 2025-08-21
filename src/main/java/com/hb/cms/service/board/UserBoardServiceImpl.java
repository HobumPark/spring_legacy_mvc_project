package com.hb.cms.service.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hb.cms.dao.board.UserBoardDao;
import com.hb.cms.dto.board.UserBoardDto;
import com.hb.cms.dto.file.FileDto;;

@Service
public class UserBoardServiceImpl implements UserBoardService {
	@Autowired
    private UserBoardDao dao;
	
	@Override
	public List<UserBoardDto> getAllUserBoards(int page, int pageSize) throws Exception{
		int offset = (page - 1) * pageSize;
		return dao.getAllUserBoards(offset,pageSize);
	}
	
	@Override
	public List<UserBoardDto> getHomeUserBoards(int page, int pageSize) throws Exception{
		int offset = (page - 1) * pageSize;
		return dao.getHomeUserBoards(offset,pageSize);
	}
	
	//글 상세보기
	@Override
	public UserBoardDto getUserBoardByNo(int no) throws Exception{
		return dao.getUserBoardByNo(no);
	}
	
	@Override
	public int increaseViewCount(int no) throws Exception {
		return dao.increaseViewCount(no); //
	}
	
	//글 상세보기 - 파일정보
	public List<FileDto> getFileListByUserBoardNo(int no) throws Exception{
		return dao.getFileListByUserBoardNo(no);
	}
	
	@Override
	public int getTotalUserBoardCount() throws Exception{
		return dao.getTotalUserBoardCount();
	}
	
	@Override
	public int addUserBoard(UserBoardDto userBoardDto) throws Exception{
		return dao.addUserBoard(userBoardDto);
	}
	
	@Override
	public int updateUserBoard(int no,String title,String content) throws Exception{
		return dao.updateUserBoard(no,title,content);
	}
	
	//글삭제
	@Override
	public int deleteUserBoard(int no) throws Exception{
		return dao.deleteUserBoard(no);
	}
	
	@Override
	public int getLastUserBoardNo() throws Exception{
		return dao.getLastUserBoardNo();
	}
	
	@Override
	public List<UserBoardDto> searchUserBoards(int page, int pageSize, String searchInput) throws Exception{
		int offset = (page - 1) * pageSize;
		return dao.searchUserBoards(offset, pageSize, searchInput);
	}
	
	@Override
	public int getUserBoardSearchCount(String searchInput) throws Exception{
		return dao.getUserBoardSearchCount(searchInput);
	}
	
	@Override
	public int setUserBoardHasFile(int lastNo) throws Exception{
		return dao.setUserBoardHasFile(lastNo);
	}
	
	@Override
	public int unSetUserBoardHasFile(int lastNo) throws Exception{
		return dao.unSetUserBoardHasFile(lastNo);
	}
}