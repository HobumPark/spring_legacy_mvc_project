package com.hb.cms.service.file;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hb.cms.dao.file.FileDao;
import com.hb.cms.dto.file.FileDto;

@Service
public class FileServiceImpl implements FileService {
	
	@Autowired
	private FileDao dao;
	
	@Override
	public boolean addFiles(List<MultipartFile> files, int no, ServletContext servletContext) {
		System.out.println( "넘어온 파일 갯수:"+files.size() );
		boolean allSuccess = true;
		
		for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                
                String fileName = Paths.get(file.getOriginalFilename()).getFileName().toString();
                String fileOriginalName = file.getOriginalFilename();
                long fileSize = file.getSize();
                String fileType = file.getContentType();
                String uploadDir = servletContext.getRealPath("/uploads");  
                File destination = new File(uploadDir, fileName);
                
                System.out.println("파일명(본래): " + fileOriginalName);//파일경로+이름
                System.out.println("파일명: " + fileName);
                System.out.println("파일 크기: " + fileSize);
                System.out.println("파일 타입: " + fileType);
                System.out.println("파일 업로드 경로: " + uploadDir);
                System.out.println("파일 업로드 경로+파일: " + destination);
                
                try {
                    file.transferTo(destination);  // 파일 저장
                    System.out.println("파일 저장 완료: " + fileName);
                    
                    
                    FileDto fileDto = new FileDto();
                    fileDto.setFileId(111);
                    fileDto.setNo(no);
                    fileDto.setFileName( fileName );
                    fileDto.setOriginalFileName( fileOriginalName );
                    fileDto.setFileSize( fileSize );
                    fileDto.setFileType( fileType );
                    fileDto.setFilePath( uploadDir );
                    
                    fileDto.showFileInfo();
                    
                    dao.insertFile(fileDto);
                
                    
                    
                } catch (IOException | SQLException e) {
                    e.printStackTrace();
                    // 파일 저장 실패 시 처리 로직 추가
                    allSuccess = false;  // 하나라도 실패하면 false
                }
            }
        }
		return allSuccess;
	}
	
	
	@Override
	public List<FileDto> getFileListByUserBoardNo(int boardNo) {
		System.out.println("getFilesByBoardNo");
		try {
			return dao.getFileListByUserBoardNo(boardNo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public FileDto getFilePathByFileId(int fileId) {
		System.out.println("getFilePathByFileId");
		try {
			return dao.getFilePathByFileId(fileId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public int deleteFile(int fileId, String fileName) {
		System.out.println("deleteFile");

		try {
			FileDto fileDto=getFilePathByFileId(fileId);
			String filePath = fileDto.getFilePath();
			
			// 삭제하려는 파일 경로
	        //String filePath = "C:\\Users\\YJ\\eclipse-workspace\\spring-pj\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\spring-legacy-mvc-project-master\\uploads\\스크린샷_14-6-2024_113519_localhost.jpeg";
	        
	        // File 객체 생성
	        File file = new File(filePath+"\\"+fileName);

	        // 파일이 존재하면 삭제
	        if (file.exists()) {
	            if (file.delete()) {
	                System.out.println("파일이 성공적으로 삭제되었습니다.");
	            } else {
	                System.out.println("파일 삭제에 실패했습니다.");
	            }
	        } else {
	            System.out.println("파일이 존재하지 않습니다.");
	        }
			
			
			return dao.deleteFile(fileId,fileName);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
	
	@Override
	public void deleteFilesForUserBoard(int boardNo) throws Exception{
		 // 1. 해당 게시글에 첨부된 파일 목록을 조회
	    List<FileDto> filePaths = dao.getFilePathsForUserBoard(boardNo); // 게시글 번호로 파일 경로를 조회
	    for(int i=0; i<filePaths.size(); i++) {
	    	int fileId = filePaths.get(i).getFileId();
	    	String filePath = filePaths.get(i).getFilePath();
	    	String fileName = filePaths.get(i).getFileName();
	    	System.out.println("filePaths:"+filePath+"\\"+fileName);
	    	
	    	deleteFile(fileId,fileName);
	    }
	}
	
	@Override
	public int getUserBoardNoByFileId(int fileId) throws Exception{
		int userBardNo=dao.getUserBoardNoByFileId(fileId);
		return userBardNo;
	}
	
	@Override
	public int countFileListByUserBoardNo(int boardNo) throws Exception{
		int countFile=dao.countFileListByUserBoardNo(boardNo);
		return countFile;
	}


	@Override
	public void setUserBoardHasFileFalse(int userBoardNo) {
		// TODO Auto-generated method stub
		
	}
	
}
