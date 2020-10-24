package com.bloomall.dto;

import java.sql.Timestamp;

// 아이디와 비번 입력정보를 저장하는 용도 + a
// 로그인 기능 겸 이후 페이지에서 자주 사용하는 회원정보 저장 용도(db에서 멤버정보 전부를 가져오는 게 아닐때 사용)
// 따라서 LoginDTO -> MemberDTO로 이름 바꿈
public class MemberDTO {
	
	private String mem_id;				// 회원아이디
	private String mem_pw;				// 회원비밀번호
	private String mem_name;			// 회원이름
	private String mem_nick;			// 회원닉네임
	private int    mem_point;			// 포인트
	private Timestamp mem_last_visit;	// 최근 접속날짜
	
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
	public String getMem_nick() {
		return mem_nick;
	}
	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}
	public int getMem_point() {
		return mem_point;
	}
	public void setMem_point(int mem_point) {
		this.mem_point = mem_point;
	}
	public Timestamp getMem_last_visit() {
		return mem_last_visit;
	}
	public void setMem_last_visit(Timestamp mem_last_visit) {
		this.mem_last_visit = mem_last_visit;
	}
	
	@Override
	public String toString() {
		return "MemberDTO [mem_id=" + mem_id + ", mem_pw=" + mem_pw + ", mem_name=" + mem_name + ", mem_nick="
				+ mem_nick + ", mem_point=" + mem_point + ", mem_last_visit=" + mem_last_visit + "]";
	}
	
}
