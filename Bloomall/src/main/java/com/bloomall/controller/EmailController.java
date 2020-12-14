package com.bloomall.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bloomall.dto.EmailDTO;
import com.bloomall.service.EmailService;

@Controller
@RequestMapping("/email/*")
public class EmailController {
	
	private static final Logger logger = LoggerFactory.getLogger(EmailController.class);

	@Inject
	private EmailService service;
	
	// ajax 요청방식으로 이메일 인증코드 보내기
	@ResponseBody
	@RequestMapping(value = "/send")
	public ResponseEntity<String> sendEmail(EmailDTO dto, HttpSession session){
		
		logger.info("===== sendEmail() called =====");
		logger.info(dto.toString());
		
		ResponseEntity<String> entity = null;
		
		// 6자리 인증코드 생성
		String authcode = "";
		for(int i=0; i<6; i++) {
			authcode += String.valueOf((int)(Math.random()*10));
		}

		// 세션에 인증코드 저장
		session.setAttribute("authcode", authcode);
		// 코드 확인
		logger.info("authcode : " + authcode);
		
		try {
			// dto: 회원가입 시 입력한 수신자 메일주소, authcode: 6자리 인증코드
			service.sendEmail(dto, authcode);			
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
}
