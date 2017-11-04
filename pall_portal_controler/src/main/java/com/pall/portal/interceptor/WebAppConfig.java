package com.pall.portal.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class WebAppConfig extends WebMvcConfigurerAdapter{
	@Autowired
	private AuthInterceptor authInterceptor;
	 @Override
	    public void addInterceptors(InterceptorRegistry registry) {
		 	registry.addInterceptor(new TokenInterceptor()).addPathPatterns("/**");
	        registry.addInterceptor(authInterceptor).addPathPatterns("/**");
	        super.addInterceptors(registry);
	    }
}
