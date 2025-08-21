package com.hb.cms.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hb.cms.dto.comment.UserBoardCommentDto;
import com.hb.cms.service.comment.UserBoardCommentService;

@Controller
public class UserBoardCommentController {
	
	@Autowired
    private UserBoardCommentService boardCommentService;
	
	/*�궗�슜�옄 寃뚯떆�뙋*/
	
	// http://localhost:8080/cms/board/user/list?page=1
	@RequestMapping(value = "/board/user/comment/list", method = RequestMethod.GET)
	public ResponseEntity<?> getCommentList(
	        @RequestParam("boardNo") int boardNo,
	        @RequestParam(value = "page", defaultValue = "1") int page) {
		
		System.out.println("/board/user/comment/list");
		System.out.println("boardNo:"+boardNo);
		System.out.println("page:"+page);
		
	    try {
	        int pageSize = 10;
	        int groupSize = 10;

	        List<UserBoardCommentDto> commentList = boardCommentService.getUserBoardCommentsByBoardNo(boardNo, page, pageSize);
	        System.out.println("commentList:"+commentList);
	        int totalCount = boardCommentService.countUserBoardComments(boardNo);

	        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
	        int currentGroup = (int) Math.ceil((double) page / groupSize);

	        int startPage = (currentGroup - 1) * groupSize + 1;
	        int endPage = Math.min(startPage + groupSize - 1, totalPages);

	        boolean hasPrev = startPage > 1;
	        boolean hasNext = endPage < totalPages;

	        Map<String, Object> result = new HashMap<>();
	        result.put("commentList", commentList);
	        result.put("totalCount", totalCount);
	        result.put("currentPage", page);
	        result.put("pageSize", pageSize);
	        result.put("totalPages", totalPages);
	        result.put("startPage", startPage);
	        result.put("endPage", endPage);
	        result.put("hasPrev", hasPrev);
	        result.put("hasNext", hasNext);

	        return ResponseEntity.ok(result);

	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(500).body("�뙎湲� 濡쒕뵫 �떎�뙣");
	    }
	}
	
	
	@RequestMapping(value = "/board/user/comment/delete", method = RequestMethod.DELETE)
	public ResponseEntity<?> deleteComment(@RequestParam("commentId") int commentId) {
		
		System.out.println("/board/user/comment/delete");
		System.out.println("commentId:"+commentId);
		
		
		//boardCommentService
		
	    try {
	    	boardCommentService.deleteUserBoardCommentByCommentId(commentId);
	        return ResponseEntity.ok("ok");

	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(500).body("�뙎湲� �궘�젣 �떎�뙣");
	    }
	}

	
}
