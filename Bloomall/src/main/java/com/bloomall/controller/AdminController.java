package com.bloomall.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bloomall.domain.AdminVO;
import com.bloomall.service.AdminService;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Inject
	private AdminService service;
	
	// 관리자 메인
	@RequestMapping(value = "/main", method=RequestMethod.GET)
	public void adminMain() {
		
	}
	
	// 관리자 메뉴
	@RequestMapping(value = "/menu", method=RequestMethod.GET)
	public void adminMenu() {
		
	}
	
	
	// 관리자 로그인(POST)
	@RequestMapping(value = "/login", method=RequestMethod.POST)
	public String adminLogin(AdminVO vo, RedirectAttributes rttr, HttpSession session) throws Exception {

		logger.info("======== adminLogin() called ========");
		logger.info(vo.toString());
		
		AdminVO adVO = service.adminLogin(vo);
		
		String url = "";
		
		if(adVO != null) {
			logger.info("관리자 로그인 성공");
			
			session.setAttribute("admin", adVO);	// 세션에 관리자 정보 저장
			rttr.addFlashAttribute("msg", "ADMIN_LOGIN_SUCCESS");
			
			// 로그인 전에 요청된 주소의 존재 유무 확인
			// 존재하면 해당 주소로 이동
			String destination = (String) session.getAttribute("destination");
			if(destination != null) {
				url= destination;
			}else {
				url="/admin/menu";
			}			
			
		}else {
			logger.info("관리자 로그인 실패");

			rttr.addFlashAttribute("msg", "ADMIN_LOGIN_FAIL");
		}
		
		return "redirect:" + url;
	}
		
	
	// 관리자 로그아웃(GET)
	@RequestMapping(value = "/logout", method=RequestMethod.GET)
	public String adminLogout(RedirectAttributes rttr, HttpSession session) {
		
		logger.info("======== adminLogout() called ========");
		
		session.invalidate();
		rttr.addFlashAttribute("msg", "ADMIN_LOGOUT_SUCCESS");
		
		return "redirect:/admin/main";
	}
}
