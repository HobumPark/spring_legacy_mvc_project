package com.hb.cms.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.hb.cms.aspect.SessionCheckAspect;
import com.hb.cms.interceptor.LoginInterceptor;

@Configuration
@EnableAspectJAutoProxy  // AOP Ȱ��ȭ
@ComponentScan(basePackages = {"com.hb.cms", "com.hb.cms.aspect"})
public abstract class AppConfig implements WebMvcConfigurer {

    // AOP ���� ����
    @Bean
    public SessionCheckAspect sessionCheckAspect() {
        return new SessionCheckAspect();
    }

    // Interceptor ����
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // �α��� ���ͼ��� ���
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/dashboard/**", "/profile/**")  // �α��� üũ�� ��ε�
                .excludePathPatterns("/login", "/register", "/home");  // �α��� ���� ��ε�
    }
    
    
}
