package com.bloomall.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bloomall.domain.MemberVO;
import com.bloomall.dto.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	private SqlSession session;
	
	private static final String NS = "com.bloomall.mappers.MemberMapper";

	// 회원가입
	@Override
	public void join(MemberVO vo) throws Exception {
		session.insert(NS + ".join", vo);
	}

	// 아이디 중복 체크
	@Override
	public String confirmId(String mem_id) throws Exception {
		return session.selectOne(NS + ".confirmId", mem_id);
	}
	
	// 로그인
	@Override
	public MemberDTO login(MemberDTO dto) throws Exception {
		return session.selectOne(NS + ".login", dto);
	}
	
	// 로그인 시간 업데이트(최근 접속시간 - 로그인 성공 시)
	@Override
	public void loginDateUpdate(String mem_id) throws Exception {
		session.update(NS + ".loginDateUpdate", mem_id);
	}
	
	// 회원정보(MemberVO) 가져오기
	@Override
	public MemberVO getUserInfo(String mem_id) throws Exception {
		return session.selectOne(NS + ".getUserInfo", mem_id);
	}

	// 회원정보 수정
	@Override
	public void modifyInfo(MemberVO vo) throws Exception {
		session.update(NS + ".modifyInfo", vo);
	}

	// 비밀번호 변경
	@Override
	public void updatePW(MemberDTO dto) throws Exception {
		session.update(NS + ".updatePW", dto);
	}

	// 회원 탈퇴
	@Override
	public void deleteMember(String mem_id) throws Exception {
		session.delete(NS + ".deleteMember", mem_id);
	}

	
}
