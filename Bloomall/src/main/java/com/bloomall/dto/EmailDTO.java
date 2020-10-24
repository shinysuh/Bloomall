package com.bloomall.dto;

public class EmailDTO {

	/* 발신자 이름, 발신자 메일주소, 수신자 메일주소, 메일제목, 메일내용 */
	
	private String sender_name;
	private String sender_email;
	private String recipient_email;
	private String e_title;
	private String e_content;
	
	// 수신자 메일주소를 제외한 정보들 기본값 세팅
	public EmailDTO() {
		this.sender_name = "BLOOMALL";
		this.sender_email = "BLOOMALL";
		this.e_title = "[BLOOMALL] 회원가입 인증코드";
		this.e_content = "안녕하세요,\n아래 코드를 이메일 인증코드란에 정확하게 입력해주세요.\n";
	}

	public String getSender_name() {
		return sender_name;
	}

	public void setSender_name(String sender_name) {
		this.sender_name = sender_name;
	}

	public String getSender_email() {
		return sender_email;
	}

	public void setSender_email(String sender_email) {
		this.sender_email = sender_email;
	}

	public String getRecipient_email() {
		return recipient_email;
	}

	public void setRecipient_email(String recipient_email) {
		this.recipient_email = recipient_email;
	}

	public String getE_title() {
		return e_title;
	}

	public void setE_title(String e_title) {
		this.e_title = e_title;
	}

	public String getE_content() {
		return e_content;
	}

	public void setE_content(String e_content) {
		this.e_content = e_content;
	}

	@Override
	public String toString() {
		return "EmailDTO [sender_name=" + sender_name + ", sender_email=" + sender_email + ", recipient_email="
				+ recipient_email + ", e_title=" + e_title + ", e_content=" + e_content + "]";
	}
	
}
