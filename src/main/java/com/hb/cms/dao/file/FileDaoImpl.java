package com.hb.cms.dao.file;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hb.cms.dto.file.FileDto;

@Repository
public class FileDaoImpl implements FileDao {
	
	@Autowired
    private SqlSession sqlSession;
	
	private static final String TestNameSpace = "resources.mapper.file.FileMapper";
	
	public int insertFile(FileDto file) throws SQLException{
		
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("file", file);
		System.out.println("file:"+file);
		
		return sqlSession.insert(TestNameSpace+".insertFile", file);
	}
	
	@Override
	public List<FileDto> getFileListByUserBoardNo(int boardNo) {
		System.out.println("getFilesByBoardNo");
		
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("boardNo", boardNo);
	    
	    List<FileDto> fileList = sqlSession.selectList(TestNameSpace+".selectFileListByUserBoardNo", paramMap);
		return fileList;
	}
	
	@Override
	public FileDto getFilePathByFileId(int fileId) {
		System.out.println("getFilePathByFileId");
		
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("fileId", fileId);
		
		return sqlSession.selectOne(TestNameSpace+".selectFilePathByFileId", fileId);
	}
	
	@Override
	public int deleteFile(int fileId, String fileName) {
		System.out.println("deleteFile");
		
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("fileId", fileId);
	    paramMap.put("fileName", fileName);
		
	    return sqlSession.delete(TestNameSpace+".deleteFileByFileId", paramMap);
	}
	
	@Override
	public List<FileDto> getFilePathsForUserBoard(int boardNo) throws SQLException{
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("boardNo", boardNo);
	    
	    List<FileDto> filePaths = sqlSession.selectList(TestNameSpace+".selectFilePathByUserBoard", paramMap);
	    
	    /*
		 List<String> filePaths = new ArrayList<>();
	        
        // 임시 데이터: 세 개의 파일 경로 (테스트용)
        filePaths.add("/test/files/board_" + boardNo + "_file1.jpg");
        filePaths.add("/test/files/board_" + boardNo + "_file2.png");
        filePaths.add("/test/files/board_" + boardNo + "_file3.pdf");
        */
	    
        return filePaths;
	}
	
	@Override
	public int getUserBoardNoByFileId(int fileId) throws Exception{
		Map<String, Object> params = new HashMap<>();
        params.put("fileId", fileId);
		return sqlSession.selectOne(TestNameSpace+".selectUserBoardNoByFileId", params);
	}
	
	@Override
	public int countFileListByUserBoardNo(int boardNo) throws Exception{
		Map<String, Object> params = new HashMap<>();
        params.put("boardNo", boardNo);
		return sqlSession.selectOne(TestNameSpace+".countFileListByUserBoardNo", params);
	}
}
