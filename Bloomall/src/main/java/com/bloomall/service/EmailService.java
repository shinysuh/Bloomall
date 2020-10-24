package com.bloomall.service;

import com.bloomall.dto.EmailDTO;

public interface EmailService {

	// 이메일 인증코드 보내기
	public void sendEmail(EmailDTO dto, String authcode) throws Exception;
	
}
