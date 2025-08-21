package com.hb.cms.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import com.hb.cms.aspect.SessionCheckAspect;

@Configuration
@EnableAspectJAutoProxy  // AOP È°¼ºÈ­
public class AspectConfig {

    @Bean
    public SessionCheckAspect sessionCheckAspect() {
        return new SessionCheckAspect();
    }
}