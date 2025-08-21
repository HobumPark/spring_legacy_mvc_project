package com.hb.cms.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.hb.cms.dto.file.FileDto;
import com.hb.cms.service.file.FileService;
import com.hb.cms.service.board.UserBoardService;

@RestController
public class FileController {

    @Autowired
    private FileService fileService;
    
    @Autowired
    private UserBoardService userBoardService;
    
    @Autowired
	private ServletContext servletContext;
    
    // �뙆�씪 �떎�슫濡쒕뱶
    @GetMapping("/file/download")
    public ResponseEntity<Resource> downloadFile(@RequestParam("fileId") int fileId) throws IOException {
        System.out.println("download file!");
        System.out.println("fileId:" + fileId);

        FileDto fileDto = fileService.getFilePathByFileId(fileId);
        fileDto.showFileInfo();

        String dtofilePath = fileDto.getFilePath();
        String dtofileName = fileDto.getFileName();

        String fixedFilePath = dtofilePath + "\\" + dtofileName;
        String fixedFileName = dtofileName;

        Path filePath = Paths.get(fixedFilePath);
        Resource resource = new UrlResource(filePath.toUri());

        if (!resource.exists()) {
            throw new RuntimeException("�뙆�씪�쓣 李얠쓣 �닔 �뾾�뒿�땲�떎.");
        }

        String encodedFileName = URLEncoder.encode(fixedFileName, StandardCharsets.UTF_8.toString());
        encodedFileName = encodedFileName.replaceAll("\\+", "%20");

        String contentDisposition = "attachment; filename=\"" + encodedFileName + "\"";

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, contentDisposition)
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .body(resource);
    }

    // �뙆�씪 �궘�젣
    @PostMapping("/file/delete")
    public ResponseEntity<String> deleteFile(@RequestParam("fileId") int fileId,
                                             @RequestParam("fileName") String fileName) {
        System.out.println("�뙆�씪�궘�젣!");
        System.out.println("fileId:" + fileId);
        System.out.println("fileName:" + fileName);

        int userBoardNo = -1;

        try {
            // 1. �궘�젣 �쟾�뿉 湲� 踰덊샇瑜� 議고쉶
            userBoardNo = fileService.getUserBoardNoByFileId(fileId);
            System.out.println("userBoardNo: " + userBoardNo);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .header(HttpHeaders.CONTENT_TYPE, "application/json; charset=UTF-8")
                    .body("{\"message\": \"�뙆�씪 �궘�젣 �떎�뙣 (湲�踰덊샇 議고쉶 �떎�뙣)\"}");
        }

        int isDeleted = fileService.deleteFile(fileId, fileName);
        System.out.println("isDeleted: " + isDeleted);

        if (isDeleted == 1) {
            try {
                // 2. �궘�젣 �썑 �궓�� �뙆�씪 媛쒖닔 �솗�씤
                int remainingFiles = fileService.countFileListByUserBoardNo(userBoardNo);          
                System.out.println("remainingFiles: " + remainingFiles);

                // 3. �궓�� �뙆�씪�씠 0媛쒕㈃ has_file=0 �꽕�젙
                if (remainingFiles == 0) {
                	userBoardService.unSetUserBoardHasFile(userBoardNo);//�뙆�씪泥⑤��뿬遺� false
                }
            } catch (Exception e) {
                e.printStackTrace(); // �뿉�윭 �엳�뼱�룄 �궘�젣�뒗 �꽦怨듯븳 嫄곕땲源� 洹몃�濡� �쓳�떟�� 蹂대깂
            }

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_TYPE, "application/json; charset=UTF-8")
                    .body("{\"message\": \"�뙆�씪 �궘�젣 �꽦怨�\"}");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .header(HttpHeaders.CONTENT_TYPE, "application/json; charset=UTF-8")
                    .body("{\"message\": \"�뙆�씪 �궘�젣 �떎�뙣\"}");
        }
    }


    // (�븘�슂�븯硫�) �뙆�씪 �뾽濡쒕뱶 泥섎━ 硫붿꽌�뱶�룄 �뿬湲� 異붽� 媛��뒫
    @RequestMapping(value = "/file/upload", method = RequestMethod.POST)
    public ResponseEntity<?> uploadFile(@RequestParam("files") List<MultipartFile> files,
                                             @RequestParam("userBoardNo") int userBoardNo) {
        System.out.println("�뙆�씪 �뾽濡쒕뱶 �슂泥�");
        System.out.println("userBoardNo:"+userBoardNo);
        
        if (files.isEmpty()) {
            return ResponseEntity.badRequest()
                .body("{\"message\": \"�뾽濡쒕뱶�븷 �뙆�씪�씠 �뾾�뒿�땲�떎.\"}");
        }

        try {
            // �꽌鍮꾩뒪 硫붿꽌�뱶瑜� �샇異쒗빐�꽌 �뙆�씪 ���옣 諛� DB 湲곕줉 泥섎━
        	fileService.addFiles(files, userBoardNo, servletContext);
            
        	List<FileDto> fileList = fileService.getFileListByUserBoardNo(userBoardNo);
        	userBoardService.setUserBoardHasFile(userBoardNo);//�뙆�씪泥⑤��뿬遺� true
        	
        	
        	return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_TYPE, "application/json; charset=UTF-8")
                    .body(fileList); // JSON�쑝濡� 由ъ뒪�듃 諛섑솚
        	
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .header(HttpHeaders.CONTENT_TYPE, "application/json; charset=UTF-8")
                    .body("{\"message\": \"�뙆�씪 �뾽濡쒕뱶 �떎�뙣\"}");
        }
    }
}
