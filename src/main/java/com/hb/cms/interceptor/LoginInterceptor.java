package com.hb.cms.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // ���ǿ��� �α��� ������ Ȯ��
        Object user = request.getSession().getAttribute("user");

        if (user == null) {  // �α��ε��� ������ �α��� �������� �����̷�Ʈ
        	System.out.println("�α��� ���ͼ���-�α��� �ȵǾ����� (�α��� �������� �����̷�Ʈ");
            response.sendRedirect("/login");
            return false;  // ��û�� �������� ����
        }
        System.out.println("�α��� ���ͼ���-�α��� �Ǿ�����");
        return true;  // �α��� �Ǿ� ������ ��û�� ��� ó��
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            org.springframework.web.servlet.ModelAndView modelAndView) throws Exception {
        // ��û ó�� �� �߰� �۾��� �ʿ��ϸ� ���⿡ �ۼ�
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        // ��û �Ϸ� �� ó���� ������ �ʿ��ϸ� ���⿡ �ۼ�
    }
}
