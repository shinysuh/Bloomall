package com.bloomall.service;

import com.bloomall.domain.MemberVO;
import com.bloomall.dto.MemberDTO;

public interface MemberService {

	// 회원가입
	public void join(MemberVO vo) throws Exception;
	
	// 아이디 중복체크
	public String confirmId(String mem_id) throws Exception;
	
	// 로그인
	public MemberDTO login(MemberDTO dto) throws Exception;
	
	// 회원정보(MemberVO) 가져오기
	public MemberVO getUserInfo(String mem_id) throws Exception;
		
	// 회원정보 수정
	public void modifyInfo(MemberVO vo) throws Exception;
	
	// 비밀번호 변경
	public void updatePW(MemberDTO dto) throws Exception;
	
	// 회원 탈퇴
	public void deleteMember(String mem_id) throws Exception;

}
