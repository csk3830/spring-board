package com.ezen.spring.config;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration.Dynamic;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer{

	@Override
	protected Class<?>[] getRootConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] {RootConfig.class, SecurityConfig.class};
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
	
	// 사용자 지정 설정이 필요한 경우 사용. (파일업로드)
	@Override
	protected void customizeRegistration(Dynamic registration) {
		registration.setInitParameter("throwExceptionIfNoHandlerFound", "true");
		
		String uploadLocation = "D:\\sk\\_myProject\\_java\\_fileUpload";
		int maxFileSize = 1024*1024*20; //20MB
		int maxReqSize = maxFileSize * 3;
		int fileSizeThreshold = maxFileSize;
		
		MultipartConfigElement multipartConfig =
				new MultipartConfigElement(uploadLocation, maxFileSize, maxReqSize, fileSizeThreshold);
				
		registration.setMultipartConfig(multipartConfig); 
		
	}

	
}
