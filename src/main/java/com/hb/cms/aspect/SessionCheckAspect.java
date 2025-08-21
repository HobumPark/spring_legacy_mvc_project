package com.hb.cms.aspect;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import com.hb.cms.dto.users.UserDto;

@Aspect
@Component
public class SessionCheckAspect {
    
    @Autowired
    private HttpSession session;

    @Pointcut("execution(* com.hb.cms.controller.*.*(..))") // 모든 컨트롤러 메서드
    public void controllerMethods() {}

    @Before("controllerMethods()")
    public void addCommonUserInfo(JoinPoint joinPoint) {
        System.out.println("AOP - Session Check!");

        // Model 객체를 얻기 위한 로직
        Object[] args = joinPoint.getArgs();
        Model model = null;
        for (Object arg : args) {
            if (arg instanceof Model) {
                model = (Model) arg;
                break;
            }
        }

        if (model != null) {
            // 세션이 무효화되지 않았는지 확인
            if (session.isNew() || session.getAttribute("user") == null) {
                System.out.println("Session is new or user is not logged in");
                model.addAttribute("loggedIn", false);
                model.addAttribute("sessionRemainingTime", 0);
                return;  // 세션이 무효화되었거나 새로 생성된 경우, 더 이상 처리하지 않음
            }
            
            // 세션 만료 시간 체크
            int maxInactiveInterval = session.getMaxInactiveInterval();
            long creationTime = session.getCreationTime();
            long currentTime = System.currentTimeMillis();

            int remainingSeconds = (int) ((creationTime + (maxInactiveInterval * 1000L) - currentTime) / 1000);
            System.out.println("maxInactiveInterval: " + maxInactiveInterval);
            System.out.println("remainingSeconds: " + remainingSeconds);

            // 세션에 저장된 사용자 정보 확인
            UserDto user = (UserDto) session.getAttribute("user");
            if (user != null && remainingSeconds > 0) {
                System.out.println("User is logged in");
                model.addAttribute("loggedIn", true);
                model.addAttribute("user", user);
                model.addAttribute("sessionRemainingTime", Math.max(remainingSeconds, 0));
            } else {
                System.out.println("User is not logged in or session has expired");
                session.invalidate();  // 세션 무효화
                model.addAttribute("loggedIn", false);
                model.addAttribute("sessionRemainingTime", 0);
            }
        }
    }
}
