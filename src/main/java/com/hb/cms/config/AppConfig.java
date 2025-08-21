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
@EnableAspectJAutoProxy  // AOP 활성화
@ComponentScan(basePackages = {"com.hb.cms", "com.hb.cms.aspect"})
public abstract class AppConfig implements WebMvcConfigurer {

    // AOP 관련 설정
    @Bean
    public SessionCheckAspect sessionCheckAspect() {
        return new SessionCheckAspect();
    }

    // Interceptor 설정
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 로그인 인터셉터 등록
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/dashboard/**", "/profile/**")  // 로그인 체크할 경로들
                .excludePathPatterns("/login", "/register", "/home");  // 로그인 제외 경로들
    }
    
    
}
