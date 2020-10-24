package com.bloomall.persistence;

import com.bloomall.domain.AdminVO;

public interface AdminDAO {

	// 관리자 로그인
	public AdminVO adminLogin(AdminVO vo) throws Exception;
	
	// 최근접속날짜 업데이트
	public void updateVisit(String ad_id) throws Exception;
		
}
