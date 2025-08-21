package com.hb.cms.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hb.cms.dto.board.UserBoardDto;
import com.hb.cms.dto.comment.UserBoardCommentDto;
import com.hb.cms.dto.file.FileDto;
import com.hb.cms.service.board.UserBoardService;
import com.hb.cms.service.comment.UserBoardCommentService;
import com.hb.cms.service.file.FileService;

import org.springframework.web.multipart.MultipartFile;

@Controller
public class UserBoardController {
    
    @Autowired
    private UserBoardService boardService;
    
    @Autowired
    private UserBoardCommentService boardCommentService;
    
    @Autowired
    private FileService fileService;
    
    @Autowired
    private ServletContext servletContext;
    
    /*
     * //Before AOP method with direct session info checking in controller
     * 
     * @ModelAttribute public void addCommonUserInfo(Model model, HttpSession session) { 
     *     System.out.println("Checking session information!");
     * 
     *     // Get session details: maxInactiveInterval and current remaining time
     *     int maxInactiveInterval = session.getMaxInactiveInterval(); // Max inactive 
     *     long creationTime = session.getCreationTime(); // Session creation time 
     *     long currentTime = System.currentTimeMillis(); // Current time
     * 
     *     int remainingSeconds = (int) ((creationTime + (maxInactiveInterval * 1000L) - currentTime) / 1000);
     *     System.out.println("maxInactiveInterval: " + maxInactiveInterval);
     *     System.out.println("remainingSeconds: " + remainingSeconds);
     * 
     *     // Retrieve user information from the session
     *     UserDto user = (UserDto) session.getAttribute("user");
     *     if (user != null && remainingSeconds > 0) {
     *         System.out.println("User is logged in"); 
     *         model.addAttribute("loggedIn", true);
     *         model.addAttribute("user", user);
     *         model.addAttribute("sessionRemainingTime", Math.max(remainingSeconds, 0)); 
     *     } else {
     *         System.out.println("No user is logged in or session expired");
     *         session.invalidate(); // Invalidate session if expired or not logged in
     *         model.addAttribute("loggedIn", false);
     *         model.addAttribute("sessionRemainingTime", 0); 
     *     }
     * }
     */
    
    /* User board list */
    // http://localhost:8080/cms/board/user/list?page=1
    @RequestMapping(value = "/board/user/list", method = RequestMethod.GET)
    public String userBoardList(@RequestParam(value = "page", required = false, defaultValue = "1") int page, 
                                @RequestParam(value = "search_input", required = false, defaultValue = "") String searchInput,
                                Locale locale, Model model, HttpSession session) {
        System.out.println("/board/user/list");
        System.out.println("Page: " + page); // Displaying page number
        System.out.println("searchInput: " + searchInput); // Search input
        
         try {
              ArrayList<UserBoardDto> userBoardList = new ArrayList<>();
                int count = 0;

                // If search input is empty, fetch all user boards
                if (searchInput == null || searchInput.isEmpty()) {
                    userBoardList = (ArrayList<UserBoardDto>) boardService.getAllUserBoards(page, 10);
                    count = boardService.getTotalUserBoardCount();
                } else {
                    // If search input is provided, fetch search results
                    userBoardList = (ArrayList<UserBoardDto>) boardService.searchUserBoards(page, 10, searchInput);
                    count = boardService.getUserBoardSearchCount(searchInput);
                }

            int currentPage = page;
            int lastPage = count / 10;
            if (lastPage % 10 != 0) {
                lastPage += 1;
            }
            if (count < 10) {
                lastPage = 1;
            }
            
            System.out.println(userBoardList);
            System.out.println(count);
            model.addAttribute("userBoardList", userBoardList);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("lastPage", lastPage);
            model.addAttribute("searchInput", searchInput); // Displaying search input
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/board/user/user-board-list";
    }
    
    
    // Search board
    @RequestMapping(value = "/board/search", method = RequestMethod.POST)
    public String userBoardSearch(@RequestParam(value = "page", required = false, defaultValue = "1") int page, 
                                  @RequestParam(value = "search-input", required = false, defaultValue = "") String searchInput,
        Locale locale, Model model,
        HttpSession session) {
        System.out.println("/board/search");
        System.out.println("Page: " + page); // Displaying page number
        System.out.println("searchInput: " + searchInput); // Search input
        
        try {
            ArrayList<UserBoardDto> userBoardList = (ArrayList<UserBoardDto>) boardService.searchUserBoards(page, 10, searchInput);
            
            int count = boardService.getUserBoardSearchCount(searchInput);
            System.out.println("count:"+count);
            int currentPage = page;
            int lastPage = count / 10;
            if (lastPage % 10 != 0) {
                lastPage += 1;
            }
            if (count < 10) {
                lastPage = 1;
            }
            System.out.println("lastPage:" + lastPage);
            
            model.addAttribute("userBoardList", userBoardList);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("lastPage", lastPage);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "/board/user/user-board-list";
    }
    
    /* View the selected board */
    @RequestMapping(value = "/board/user/view", method = RequestMethod.GET)
    public String userBoardView(@RequestParam(value = "no", required = false) int no, Locale locale, Model model, HttpSession session) {
        System.out.println("/board/user/view");
        System.out.println("no: " + no);
        

        try {
            // Increment view count if post not already viewed
            @SuppressWarnings("unchecked")
            Set<Integer> viewedPosts = (Set<Integer>) session.getAttribute("viewedPosts");

            if (viewedPosts == null) {
                viewedPosts = new HashSet<>();
            }

            if (!viewedPosts.contains(no)) {
                boardService.increaseViewCount(no);
                viewedPosts.add(no);
                session.setAttribute("viewedPosts", viewedPosts);
            }
            
            UserBoardDto userBoardView = boardService.getUserBoardByNo(no);
            System.out.println(userBoardView);
            
            ArrayList<UserBoardCommentDto> userBoardCommentList = (ArrayList<UserBoardCommentDto>) boardCommentService.getUserBoardCommentsByBoardNo(no, 1, 10);
            System.out.println("userBoardCommentList");
            System.out.println(userBoardCommentList);
            
            ArrayList<FileDto> fileList = (ArrayList<FileDto>) fileService.getFileListByUserBoardNo(no);
            
            for (int i = 0; i < fileList.size(); i++) {
                fileList.get(i).showFileInfo();
            }
            
            int count = boardCommentService.countUserBoardComments(no);
            int currentPage = 1;
            int startPage = 1;
            int lastPage = count / 10;
            if (lastPage % 10 != 0) {
                lastPage += 1;
            }
            if (count < 10) {
                lastPage = 1;
            }
            
            model.addAttribute("userBoard", userBoardView);
            model.addAttribute("userBoardCommentList", userBoardCommentList);
            model.addAttribute("startPage", startPage);
            model.addAttribute("lastPage", lastPage);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("fileList", fileList);    
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/board/user/user-board-view";
    }
    
    // Write a new post page
    @RequestMapping(value = "/board/user/write", method = RequestMethod.GET)
    public String userBoardWritePage(Locale locale, Model model, HttpSession session) {
        System.out.println("/board/user/write(get)");
        
        return "/board/user/user-board-write";
    }
    
    // Submit a new post
    @RequestMapping(value = "/board/user/write", method = RequestMethod.POST)
    public String userBoardWritePost(Locale locale, 
            @RequestParam("input-title") String inputTitle,
            @RequestParam("input-id") String inputId,
            @RequestParam("input-writer") String inputWriter,
            @RequestParam("input-phone") String inputPhone,
            @RequestParam("secret") String secret,
            @RequestParam("board-textarea") String boardTextarea,
            @RequestParam("files") List<MultipartFile> files,
            Model model) {
        
        System.out.println("/board/user/write(post)");
        System.out.println("inputTitle:" + inputTitle);
        System.out.println("inputWriter:" + inputWriter);
        System.out.println("inputId:" + inputId);
        System.out.println("inputPhone:" + inputPhone);
        System.out.println("secret:" + secret);
        System.out.println("boardTextarea:" + boardTextarea);
        System.out.println("files:" + files);
        
        boolean isFile = false;
        // Check if files are provided
        if (files != null && !files.isEmpty() && files.get(0).getSize() > 0) {
            isFile = true;
        }
        
        UserBoardDto userBoardWrite = new UserBoardDto(0, inputTitle, boardTextarea, inputWriter, inputId, inputPhone, null, 0, null, isFile);
        userBoardWrite.showUserBoardInfo();
        try {
            int no = boardService.addUserBoard(userBoardWrite);
            System.out.println("Post added successfully!");
            System.out.println("Added post ID:" + no);
            int lastNo = boardService.getLastUserBoardNo();
            System.out.println("Last post ID:" + lastNo);
            
            fileService.addFiles(files, lastNo, servletContext);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "redirect:/board/user/list?page=1";
    }
    
    /* Update the post */
    @RequestMapping(value = "/board/user/update", method = RequestMethod.GET)
    public String userBoardUpdatePage(@RequestParam(value = "no", required = false) int no, Locale locale, Model model, HttpSession session) {
        System.out.println("/board/user/update");
        System.out.println("no: " + no);
        
        try {
            UserBoardDto userBoardView = boardService.getUserBoardByNo(no);
            System.out.println(userBoardView);
                    
            ArrayList<FileDto> fileList = (ArrayList<FileDto>) fileService.getFileListByUserBoardNo(no);
            
            for (int i = 0; i < fileList.size(); i++) {
                fileList.get(i).showFileInfo();
            }
            
            model.addAttribute("userBoard", userBoardView);
            model.addAttribute("fileList", fileList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/board/user/user-board-update";
    }
    
    /* Submit the post update */
    @RequestMapping(value = "/board/user/update", method = RequestMethod.POST)
    public String userBoardUpdatePost( 
            @RequestParam("no") int no,
            @RequestParam("input-title") String inputTitle,
            @RequestParam("board-textarea") String boardTextarea,
            Locale locale, Model model) {
        System.out.println("/board/user/update(post)");
        System.out.println("no: " + no);
        System.out.println("inputTitle: " + inputTitle);
        System.out.println("boardTextarea: " + boardTextarea);
        try {
            boardService.updateUserBoard(no, inputTitle, boardTextarea);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //
        return "redirect:/board/user/list?page=1";
    }
    
    /* Delete the post */
    @RequestMapping(value = "/board/user/delete", method = RequestMethod.DELETE)
    public ResponseEntity<String> userBoardDelete(@RequestParam("no") int no, 
            Locale locale, Model model) {
        System.out.println("/board/user/delete");
        System.out.println("no: " + no);
        try {
            fileService.deleteFilesForUserBoard(no); // Delete files
            boardService.deleteUserBoard(no); // Delete post
            
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.ok("fail");
        }
        return ResponseEntity.ok("success");
    }
    
    @RequestMapping(value = "/board/user/del_test", method = RequestMethod.POST)
    public ResponseEntity<String> userBoardDelTest(@RequestParam("no") int no, 
            Locale locale, Model model) {
        System.out.println("/board/user/del_test");
        System.out.println("no: " + no);
        try {
            fileService.deleteFilesForUserBoard(no);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.ok("fail");
        }
        return ResponseEntity.ok("success");
    }
    
    /* Notice board list */
    @RequestMapping(value = "/board/notice/list", method = RequestMethod.GET)
    public String noticeBoardList(Locale locale, Model model) {
        
        return "/board/notice/notice-board-list";
    }
    
    @RequestMapping(value = "/board/notice/view", method = RequestMethod.GET)
    public String noticeBoardView(Locale locale, Model model) {
        
        return "/board/notice/notice-board-view";
    }
    
    @RequestMapping(value = "/board/notice/write", method = RequestMethod.GET)
    public String noticeBoardWrite(Locale locale, Model model) {
        
        return "/board/notice/notice-board-write";
    }
}
