package com.bloomall.service;

import javax.inject.Inject;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bloomall.domain.MemberVO;
import com.bloomall.dto.MemberDTO;
import com.bloomall.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;
	
	@Inject
	private BCryptPasswordEncoder cryptPassEnc;
	
	// 회원가입
	@Override
	public void join(MemberVO vo) throws Exception {
		dao.join(vo);
	}

	// 아이디 중복 체크
	@Override
	public String confirmId(String mem_id) throws Exception {
		return dao.confirmId(mem_id);
	}
	
	// 로그인
	@Transactional
	@Override
	public MemberDTO login(MemberDTO dto) throws Exception {
		
		MemberDTO memDto = dao.login(dto);
		
		if(memDto != null) {
			// 비밀번호가 암호화된 비밀번호와 일치하는지 확인
			if(cryptPassEnc.matches(dto.getMem_pw(), memDto.getMem_pw())) {
				dao.loginDateUpdate(memDto.getMem_id());
			}else {
				// 비밀번호 불일치 시, null 리턴
				memDto = null;
			}
		}
		return memDto;
	}
	
	
	// 회원정보(MemberVO) 가져오기
	@Override
	public MemberVO getUserInfo(String mem_id) throws Exception {
		return dao.getUserInfo(mem_id);
	}

	// 회원정보 수정
	@Override
	public void modifyInfo(MemberVO vo) throws Exception {
		dao.modifyInfo(vo);
	}

	// 비밀번호 변경
	@Override
	public void updatePW(MemberDTO dto) throws Exception {
		dao.updatePW(dto);
	}

	// 회원 탈퇴
	@Override
	public void deleteMember(String mem_id) throws Exception {
		dao.deleteMember(mem_id);
	}




}
