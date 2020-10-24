package com.bloomall.service;

import com.bloomall.domain.AdminVO;

public interface AdminService {

	// 관리자 로그인
	public AdminVO adminLogin(AdminVO vo) throws Exception;
	
}
