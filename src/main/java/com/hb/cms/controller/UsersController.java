package com.hb.cms.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hb.cms.dto.users.UserDto;
import com.hb.cms.service.users.UsersService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
public class UsersController {
    
    @Autowired
    private UsersService service;
    
    @RequestMapping(value = "/member/login", method = RequestMethod.GET)
    public String loginPage(Locale locale, Model model, HttpSession session,
            @RequestParam(value = "redirectUrl", required = false) String redirectUrl) {
        
        UserDto user = (UserDto) session.getAttribute("user");
    	
    	
        if(user != null) {
        	System.out.println("로그인 되어있습니다.");
        	 return "/index";
        }
        
    	session.setAttribute("redirectUrl", redirectUrl);
        
        return "/member/login/login";
    }
    
    @RequestMapping(value = "/member/login", method = RequestMethod.POST)
    public String loginPost(Locale locale, Model model, HttpSession session,
            @RequestParam("id") String id,
            @RequestParam("password") String password,
            @RequestParam(value = "redirectUrl", required = false) String redirectUrl) {
        
        System.out.println("id: " + id);
        System.out.println("password: " + password);
        try {
            UserDto users = service.login(id, password);
            
            if(users == null) {
                System.out.println("Login failed!");
                return "/member/login/login";
            } else {
                System.out.println("Login successful!");
                System.out.println(users.getId());
                System.out.println("redirectUrl: " + redirectUrl);
                
                // Store logged-in user information in session
                session.setAttribute("user", users);
                
                if (redirectUrl != null && !redirectUrl.isEmpty()) {
                    if (redirectUrl.startsWith("/cms")) {
                        redirectUrl = redirectUrl.replaceFirst("/cms", "/");
                    }
                    System.out.println("redirectUrl: " + redirectUrl);
                    return "redirect:" + redirectUrl;
                } else {
                    return "redirect:/"; // Go to home page
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/member/login/login";
    }
    
    // Logout
    @RequestMapping(value = "/member/logout", method = RequestMethod.GET)
    public String logout(Locale locale, Model model, HttpSession session) {
        System.out.println("Logging out...");
        // Remove 'user' attribute from session
        session.removeAttribute("user");

        // Invalidate session (destroy session)
        session.invalidate();
        
        return "redirect:/";  // After logout, redirect to home page
    }
    
    // Check duplicate user ID
    @RequestMapping(value = "/member/duplicateIdCheck", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> duplicateIdCheck(@RequestBody Map<String, String> data) {
        String userId = data.get("userId");
        Map<String, Object> result = new HashMap<>();
        try {
            boolean isDuplicate = service.checkUserIdDuplicate(userId);
            result.put("duplicate", isDuplicate);
            result.put("message", isDuplicate ? "This user ID is already taken." : "This user ID is available.");
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("error", "An error occurred");
            return ResponseEntity.status(500).body(result);
        }
    }
    
    // Step 1: Registration
    @RequestMapping(value = "/member/join-step1", method = RequestMethod.GET)
    public String joinStep1Page(Locale locale, Model model) {
        System.out.println("Step 1 - User Registration");
        return "/member/join/join-step1";
    }
    
    // Step 2: Registration
    @RequestMapping(value = "/member/join-step2", method = RequestMethod.GET)
    public String joinStep2Page(Locale locale, Model model) {
        System.out.println("Step 2 - User Registration");
        return "/member/join/join-step2";
    }
    
    // Step 3: Registration
    @RequestMapping(value = "/member/join-step3", method = RequestMethod.GET)
    public String joinStep3Page(Locale locale, Model model) {
        System.out.println("Step 3 - User Registration");
        return "/member/join/join-step3";
    }
    
    // Step 4: Final Registration
    @RequestMapping(value = "/member/join-step4", method = RequestMethod.GET)
    public String joinStep4RegisterPage(Locale locale, Model model) {
        System.out.println("Step 4 - Final User Registration");
        
        try {
            // Check duplicate ID
            CheckIdDuplicateTest();
            
            // User registration
            joinTest();
            
            // User resignation
            memberResignTest();
            
            // User update
            memberUpdateTest();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "/member/join/join-step4";
    }
    
    // Check duplicate user ID (Test method)
    public void CheckIdDuplicateTest() {
        try {
            boolean result1 = service.checkUserIdDuplicate("asdf1234");
            boolean result2 = service.checkUserIdDuplicate("aaaa1234");
            System.out.println("result1: " + result1);
            System.out.println("result2: " + result2);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // User registration test
    public void joinTest() {
        // Create a test user object
        UserDto user = new UserDto(
                "user123",                  // id
                "John Doe",                 // username
                "password123",              // password
                "john.doe@example.com",     // email
                "010-1234-5678",            // phoneNumber
                "123 Main St, Springfield", // address
                "USER",                     // role
                LocalDateTime.now(),        // createdAt
                LocalDateTime.now(),        // updatedAt
                true                        // isActive
        );
        
        int result;
        
        try {
            result = service.join(user);
            if(result > 0) {
                System.out.println("User registration successful");
            } else {
                System.out.println("User registration failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // User update test
    public void memberUpdateTest() {
        int result;
        UserDto user = new UserDto(
                "user123",                  // id
                "John Doe",                 // username
                "password123",              // password
                "jjjj.doe@example.com",     // email
                "111-2222-3333",            // phoneNumber
                "999 Main St, Springfield", // address
                "USER",                     // role
                LocalDateTime.now(),        // createdAt
                LocalDateTime.now(),        // updatedAt
                true                        // isActive
        );
        
        try {
            result = service.updateUserInfo(user);
            
            if(result > 0) {
                System.out.println("User update successful");
            } else {
                System.out.println("User update failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // User resignation test
    public void memberResignTest() {
        int result;
        
        try {
            result = service.deactivateUser("user123");
            if(result > 0) {
                System.out.println("User resigned successfully");
            } else {
                System.out.println("User resignation failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @RequestMapping(value = "/member/update", method = RequestMethod.GET)
    public String memberUpdatePage(Locale locale, Model model, HttpSession session) {
        System.out.println("/member/update (GET)");
        
        UserDto user = (UserDto) session.getAttribute("user");
        model.addAttribute("user", user);
        
        return "/member/update/member-update";
    }
    
    @RequestMapping(value = "/member/update", method = RequestMethod.POST)
    public String memberUpdateAction(
            @RequestParam("id-input") String id,
            @RequestParam("name-input") String name,
            @RequestParam("phone-input-1") String phone1,
            @RequestParam("phone-input-2") String phone2,
            @RequestParam("phone-input-3") String phone3,
            @RequestParam("email-input") String email,
            @RequestParam("zone-code-input") String zoneCode,
            @RequestParam("main-address-input") String mainAddress,
            @RequestParam("detail-address-input") String detailAddress,
            @RequestParam("sms-agree") String smsAgree,
            Model model) {

        // Process the information (e.g., save to DB, store in session, etc.)
        System.out.println("ID: " + id);
        System.out.println("Name: " + name);
        System.out.println("Phone: " + phone1 + "-" + phone2 + "-" + phone3);
        System.out.println("Email: " + email);
        System.out.println("Address: " + zoneCode + ", " + mainAddress + " " + detailAddress);
        System.out.println("SMS Agree: " + smsAgree);
        
        String phoneNumber = phone1 + "-" + phone2 + "-" + phone3;
        String address = zoneCode + " " + mainAddress + " " + detailAddress;
        
        // Store values in the UserDto object
        UserDto user = new UserDto();
        user.setId(id);
        user.setPhoneNumber(phoneNumber);
        user.setEmail(email);
        user.setAddress(address);
        
        try {
            service.updateUserInfo(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Return the view after data processing
        return "/member/update/member-update";
    }
}
