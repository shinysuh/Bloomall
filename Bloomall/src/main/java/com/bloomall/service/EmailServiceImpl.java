package com.bloomall.service;

import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.bloomall.dto.EmailDTO;

@Service
public class EmailServiceImpl implements EmailService {

	@Inject
	private JavaMailSender mailSender;
	
	// 이메일 인증코드 보내기
	@Override
	public void sendEmail(EmailDTO dto, String authcode) {
		
		MimeMessage msg = mailSender.createMimeMessage();
		
		try {
			// 수신자 메일 설정
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getRecipient_email()));
			// 발신자 메일/이름 설정
			msg.addFrom(new InternetAddress[] {new InternetAddress(dto.getSender_email(), dto.getSender_name())});
			// 메일 제목
			msg.setSubject(dto.getE_title(), "utf-8");
			// 메일 내용(인증코드 추가)
			msg.setText(dto.getE_content() + authcode, "utf-8");
			
			// 메일 전송
			mailSender.send(msg);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
