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

    @Pointcut("execution(* com.hb.cms.controller.*.*(..))") // ��� ��Ʈ�ѷ� �޼���
    public void controllerMethods() {}

    @Before("controllerMethods()")
    public void addCommonUserInfo(JoinPoint joinPoint) {
        System.out.println("AOP - Session Check!");

        // Model ��ü�� ��� ���� ����
        Object[] args = joinPoint.getArgs();
        Model model = null;
        for (Object arg : args) {
            if (arg instanceof Model) {
                model = (Model) arg;
                break;
            }
        }

        if (model != null) {
            // ������ ��ȿȭ���� �ʾҴ��� Ȯ��
            if (session.isNew() || session.getAttribute("user") == null) {
                System.out.println("Session is new or user is not logged in");
                model.addAttribute("loggedIn", false);
                model.addAttribute("sessionRemainingTime", 0);
                return;  // ������ ��ȿȭ�Ǿ��ų� ���� ������ ���, �� �̻� ó������ ����
            }
            
            // ���� ���� �ð� üũ
            int maxInactiveInterval = session.getMaxInactiveInterval();
            long creationTime = session.getCreationTime();
            long currentTime = System.currentTimeMillis();

            int remainingSeconds = (int) ((creationTime + (maxInactiveInterval * 1000L) - currentTime) / 1000);
            System.out.println("maxInactiveInterval: " + maxInactiveInterval);
            System.out.println("remainingSeconds: " + remainingSeconds);

            // ���ǿ� ����� ����� ���� Ȯ��
            UserDto user = (UserDto) session.getAttribute("user");
            if (user != null && remainingSeconds > 0) {
                System.out.println("User is logged in");
                model.addAttribute("loggedIn", true);
                model.addAttribute("user", user);
                model.addAttribute("sessionRemainingTime", Math.max(remainingSeconds, 0));
            } else {
                System.out.println("User is not logged in or session has expired");
                session.invalidate();  // ���� ��ȿȭ
                model.addAttribute("loggedIn", false);
                model.addAttribute("sessionRemainingTime", 0);
            }
        }
    }
}
