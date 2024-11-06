package com.ezen.spring.config;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.Registration.Dynamic;

import org.springframework.security.access.SecurityConfig;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer{

	@Override
	protected Class<?>[] getRootConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] {RootConfig.class};
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] {ServletConfiguration.class};
	}

	@Override
	protected String[] getServletMappings() {
		// TODO Auto-generated method stub
		return new String[] {"/"};
	}

	//encoding filter 설정
	@Override
	protected Filter[] getServletFilters() {
		// TODO Auto-generated method stub
//		CharacterEncodingFilter encoding = new CharacterEncodingFilter("UTF-8", true);
		CharacterEncodingFilter encoding = new CharacterEncodingFilter();
		encoding.setEncoding("UTF-8");
		encoding.setForceEncoding(true); //외부로 나가는 데이터 인코딩 여부
		
		return new Filter[] {encoding};
	}

	
}
