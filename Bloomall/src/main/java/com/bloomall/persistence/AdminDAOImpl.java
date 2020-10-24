package com.bloomall.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bloomall.domain.AdminVO;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Inject
	private SqlSession session;
	
	private static final String NS = "com.bloomall.mappers.AdminMapper";

	// 관리자 로그인
	@Override
	public AdminVO adminLogin(AdminVO vo) throws Exception {
		return session.selectOne(NS + ".adminLogin", vo);
	}

	// 최근접속날짜 업데이트
	@Override
	public void updateVisit(String ad_id) throws Exception {
		session.update(NS + ".updateVisit", ad_id);
	}
	
	
	
}
