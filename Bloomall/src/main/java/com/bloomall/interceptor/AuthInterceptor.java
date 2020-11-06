package com.bloomall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bloomall.domain.AdminVO;

// 관리자 로그인 인터셉터 클래스
public class AuthInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		logger.info("======== AuthInterceptor preHandle() called ========");
		
		// 세션처리작업
		HttpSession session = request.getSession();
		AdminVO admin = (AdminVO) session.getAttribute("admin");
		
		if(admin == null) {  // 관리자 미 로그인 시, 로그인 페이지 로드
			logger.info("===== Admin not logged in =====");

			// 로그인 페이지 로드 전에 요청된 페이지 정보 저장
			getDestination(request);
			
			response.sendRedirect("/admin/main");
			
			return false;
		}
		
		return true;
	}
	
//	@Override
//	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
//			ModelAndView modelAndView) throws Exception {
//
//		logger.info("======== AuthInterceptor postHandle() called ========");
//		
//		// 로그인 정보가 정상적으로 넘어가면 다음 수행
////		if(admin != null) {
////			logger.info("로그인 프로세스");
////			session.setAttribute("adminLogin", admin);
////			
////			// 요청한 주소의 존재 유무 확인
////			// 존재하면 해당 주소로 이동
////			String destination = (String) session.getAttribute("destination");
////			
////			if(destination != null) {
////				response.sendRedirect(destination);
////			}else {
////				response.sendRedirect("/admin/menu");
////			}
////		}
//	}
	
	// 인터셉터 동작 전에 요청된 주소 정보를 저장하는 메소드
	private void getDestination(HttpServletRequest request){
		
		String uri = request.getRequestURI();
		String query = request.getQueryString();
		
		// 쿼리스트링
		if(query == null || query.equals("null")) {
			query = "";
		}else {
			query = "?" + query;
		}
		
		String destination = uri + query; 
		
		if(request.getMethod().equals("GET")) {
			logger.info("destination : " + destination);
			// 원래 요청된 주소 저장
			request.getSession().setAttribute("destination", destination);
		}
	}
	
	
}
