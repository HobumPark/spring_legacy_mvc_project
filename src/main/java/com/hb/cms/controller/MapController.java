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
public class MapController {

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

	// 카카오 지도 검색 페이지
	@RequestMapping(value = "/map/address-search", method = RequestMethod.GET)
	public String addressSearch(HttpSession session, Model model) {
		System.out.println("addressSearch!");
		return "/map/address-search-page";
	}

	// 오염농도 지도 페이지
	@RequestMapping(value = "/map/pollution-map", method = RequestMethod.GET)
	public String pollutionMap(HttpSession session, Model model) {
		System.out.println("addressSearch!");
		return "/map/pollution-map-page";
	}

}
