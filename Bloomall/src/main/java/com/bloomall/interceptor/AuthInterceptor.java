package com.bloomall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bloomall.domain.AdminVO;

// 관리자 로그인 인터셉터
public class AuthInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		logger.info("======== AuthInterceptor preHandle() called ========");
		
		// 세션처리작업
		HttpSession session = request.getSession();
		AdminVO admin = (AdminVO) session.getAttribute("admin");
		
		if(admin == null) {
			logger.info("===== Admin not logged in =====");
			response.sendRedirect("/admin/main");
			
			return false;
		}
		
		return true;
	}
}
