package com.bloomall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bloomall.dto.MemberDTO;

// 사용자 로그인 인터셉터
public class LoginInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		logger.info("======== LoginInterceptor preHandle() called ========");
		
		// 세션처리 작업
		HttpSession session = request.getSession();
		MemberDTO user = (MemberDTO) session.getAttribute("user");
		
		if(user == null) {
			logger.info("===== User not logged in =====");
			response.sendRedirect("/member/login/");
			
			return false;
		}
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		logger.info("======== LoginInterceptor postHandle() called ========");
		
		super.postHandle(request, response, handler, modelAndView);
	}
}
