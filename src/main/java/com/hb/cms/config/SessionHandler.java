package com.hb.cms.config;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import com.hb.cms.dto.users.UserDto;
import javax.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.ControllerAdvice;

@ControllerAdvice
// Global advice - Handling session login check
public class SessionHandler {

    @ModelAttribute
    public void addUserToModel(HttpSession session, Model model) {
        UserDto user = (UserDto) session.getAttribute("user"); // Get the user object from the session
        System.out.println("Login check advice");

        // Check if the user is logged in and add the user info to the model
        if (user != null) {
            model.addAttribute("loggedIn", true);
            model.addAttribute("user", user);
        } else {
            model.addAttribute("loggedIn", false); // User is not logged in
        }
    }
}
