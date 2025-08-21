package com.hb.cms.service.file;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.web.multipart.MultipartFile;

import com.hb.cms.dto.file.FileDto;

public interface FileService {
	public boolean addFiles(List<MultipartFile> files, int no, ServletContext servletContext);
	
	public FileDto getFilePathByFileId(int fileId);
	
	public List<FileDto> getFileListByUserBoardNo(int no);
	
	public int deleteFile(int fileId, String fileName);
	
	public void deleteFilesForUserBoard(int boardNo) throws Exception;
	
	public int getUserBoardNoByFileId(int fileId) throws Exception;
	
	public int countFileListByUserBoardNo(int boardNo) throws Exception;

	public void setUserBoardHasFileFalse(int userBoardNo);
}