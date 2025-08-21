package com.hb.cms.controller;

import java.util.ArrayList;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hb.cms.dto.board.UserBoardDto;
import com.hb.cms.dto.test.TestDto;
import com.hb.cms.dto.users.UserDto;
import com.hb.cms.service.board.UserBoardService;
import com.hb.cms.service.test.TestService;

@Controller
public class HomeController {
	/*
	 * //AOP전에 컨트롤러에 직접 넣었던 세션정보 확인
	 * 
	 * @ModelAttribute public void addCommonUserInfo(Model model, HttpSession
	 * session) { System.out.println("Checking session information!");
	 * 
	 * // Get session details: maxInactiveInterval and current remaining time int
	 * maxInactiveInterval = session.getMaxInactiveInterval(); // Max inactive
	 * interval in seconds long creationTime = session.getCreationTime(); // Session
	 * creation time in milliseconds long currentTime = System.currentTimeMillis();
	 * // Current time in milliseconds
	 * 
	 * int remainingSeconds = (int) ((creationTime + (maxInactiveInterval * 1000L) -
	 * currentTime) / 1000); System.out.println("maxInactiveInterval: " +
	 * maxInactiveInterval); System.out.println("remainingSeconds: " +
	 * remainingSeconds);
	 * 
	 * // Retrieve user information from the session UserDto user = (UserDto)
	 * session.getAttribute("user"); if (user != null && remainingSeconds > 0) {
	 * System.out.println("User is logged in"); model.addAttribute("loggedIn",
	 * true); model.addAttribute("user", user);
	 * model.addAttribute("sessionRemainingTime", Math.max(remainingSeconds, 0)); }
	 * else { System.out.println("No user is logged in or session expired");
	 * session.invalidate(); // Invalidate session if expired or not logged in
	 * model.addAttribute("loggedIn", false);
	 * model.addAttribute("sessionRemainingTime", 0); } }
	 */

	@Autowired
	private TestService service;

	@Autowired
	private UserBoardService boardService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session, Model model) {
		System.out.println("index!");

		try {
			ArrayList<UserBoardDto> userBoardList = (ArrayList<UserBoardDto>) boardService.getAllUserBoards(1, 5);

			model.addAttribute("userBoardList", userBoardList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "index";
	}

	@RequestMapping(value = "/db_test", method = RequestMethod.GET)
	public String DBTest(Locale locale, Model model) {
		System.out.println("/db_test");
		try {

			ArrayList<TestDto> testList = (ArrayList<TestDto>) service.getTestList();
			System.out.println(testList);
			model.addAttribute("list", testList);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "test/db-test";
	}
}
