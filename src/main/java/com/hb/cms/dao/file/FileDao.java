package com.hb.cms.dao.file;

import java.sql.SQLException;
import java.util.List;

import com.hb.cms.dto.file.FileDto;

public interface FileDao {
	 public int insertFile(FileDto files) throws SQLException;
	 
	 public FileDto getFilePathByFileId(int fileId) throws SQLException;
	 
	 public List<FileDto> getFileListByUserBoardNo(int boardNo) throws SQLException;
	 
	 public int deleteFile(int fileId, String fileName) throws SQLException;
	 
	 public List<FileDto> getFilePathsForUserBoard(int boardNo) throws SQLException;
	 
	 public int getUserBoardNoByFileId(int fileId) throws Exception;
	 
	 public int countFileListByUserBoardNo(int boardNo) throws Exception;
}
