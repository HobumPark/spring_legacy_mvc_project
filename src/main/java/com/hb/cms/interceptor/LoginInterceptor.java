package com.hb.cms.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 세션에서 로그인 정보를 확인
        Object user = request.getSession().getAttribute("user");

        if (user == null) {  // 로그인되지 않으면 로그인 페이지로 리다이렉트
        	System.out.println("로그인 인터셉터-로그인 안되어있음 (로그인 페이지로 리다이렉트");
            response.sendRedirect("/login");
            return false;  // 요청을 진행하지 않음
        }
        System.out.println("로그인 인터셉터-로그인 되어있음");
        return true;  // 로그인 되어 있으면 요청을 계속 처리
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            org.springframework.web.servlet.ModelAndView modelAndView) throws Exception {
        // 요청 처리 후 추가 작업이 필요하면 여기에 작성
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        // 요청 완료 후 처리할 내용이 필요하면 여기에 작성
    }
}
