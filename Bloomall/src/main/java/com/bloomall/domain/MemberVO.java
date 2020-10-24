package com.bloomall.domain;

import java.sql.Timestamp;

public class MemberVO {
	/*
	 * 
	 * 1)테이블명의 컬럼명과 VO클래스의 필드(변수)명을 일치 시키는 경우
	 * 2)테이블명의 컬럼명과 VO클래스의 필드(변수)명을 다르게 하는 경우:
	 * 		- 중간작업이 필요하다 (mapper 파일에 resultMap : DB 결과물을 객체에 로드하는 방법을 정의하는 역할)
	 * 
	
	mem_id              varchar2(50)            primary key,
    mem_pw              varchar2(20)            not null,
    mem_name            varchar2(30)            not null,
    mem_email           varchar2(50)            not null,
    mem_zip             char(5)                 not null,
    mem_addr            varchar2(50)            not null,
    mem_addr_d          varchar2(50)            not null,
    mem_tel             varchar2(15)            not null,
    mem_nick            varchar2(20)            unique not null,
    mem_email_accp      char(1)                 not null,
    mem_point           number default 0        not null,
    mem_regdate         date default sysdate    not null,
    mem_updatedate      date default sysdate    not null,
    mem_last_visit      date default sysdate    not null
    MEM_AUTHCODE        CHAR(6)                 NOT NULL

	== not yet applied ==
    MEM_SESSION_KEY	VARCHAR2(50),
	MEM_SESSION_LIMIT	TIMESTAMP(6)
	 */
	
	private String mem_id;				// 회원아이디
	private String mem_pw;				// 회원비밀번호
	private String mem_name;			// 회원이름
	private String mem_email;			// 회원이메일 주소
	private String mem_zip;				// 회원우편번호
	private String mem_addr;			// 회원기본주소
	private String mem_addr_d;			// 회원상세주소
	private String mem_tel;				// 회원전화번호
	private String mem_nick;			// 회원닉네임
	private String mem_email_accp;		// 이메일 수신여부
	private int    mem_point;			// 포인트
	private Timestamp mem_regdate;		// 회원가입날짜
	private Timestamp mem_updatedate;	// 회원정보 수정날짜
	private Timestamp mem_last_visit;	// 최근 접속날짜
	private String mem_authcode;		// 이메일 인증코드
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_pw() {
		return mem_pw;
	}
	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	public String getMem_zip() {
		return mem_zip;
	}
	public void setMem_zip(String mem_zip) {
		this.mem_zip = mem_zip;
	}
	public String getMem_addr() {
		return mem_addr;
	}
	public void setMem_addr(String mem_addr) {
		this.mem_addr = mem_addr;
	}
	public String getMem_addr_d() {
		return mem_addr_d;
	}
	public void setMem_addr_d(String mem_addr_d) {
		this.mem_addr_d = mem_addr_d;
	}
	public String getMem_tel() {
		return mem_tel;
	}
	public void setMem_tel(String mem_tel) {
		this.mem_tel = mem_tel;
	}
	public String getMem_nick() {
		return mem_nick;
	}
	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}
	public String getMem_email_accp() {
		return mem_email_accp;
	}
	public void setMem_email_accp(String mem_email_accp) {
		this.mem_email_accp = mem_email_accp;
	}
	public int getMem_point() {
		return mem_point;
	}
	public void setMem_point(int mem_point) {
		this.mem_point = mem_point;
	}
	public Timestamp getMem_regdate() {
		return mem_regdate;
	}
	public void setMem_regdate(Timestamp mem_regdate) {
		this.mem_regdate = mem_regdate;
	}
	public Timestamp getMem_updatedate() {
		return mem_updatedate;
	}
	public void setMem_updatedate(Timestamp mem_updatedate) {
		this.mem_updatedate = mem_updatedate;
	}
	public Timestamp getMem_last_visit() {
		return mem_last_visit;
	}
	public void setMem_last_visit(Timestamp mem_last_visit) {
		this.mem_last_visit = mem_last_visit;
	}
	public String getMem_authcode() {
		return mem_authcode;
	}
	public void setMem_authcode(String mem_authcode) {
		this.mem_authcode = mem_authcode;
	}
	
	@Override
	public String toString() {
		return "MemberVO [mem_id=" + mem_id + ", mem_pw=" + mem_pw + ", mem_name=" + mem_name + ", mem_zip=" + mem_zip
				+ ", mem_addr=" + mem_addr + ", mem_addr_d=" + mem_addr_d + ", mem_tel=" + mem_tel + ", mem_nick="
				+ mem_nick + ", mem_email_accp=" + mem_email_accp + ", mem_point=" + mem_point + ", mem_regdate="
				+ mem_regdate + ", mem_updatedate=" + mem_updatedate + ", mem_last_visit=" + mem_last_visit
				+ ", mem_authcode=" + mem_authcode + "]";
	}
}
