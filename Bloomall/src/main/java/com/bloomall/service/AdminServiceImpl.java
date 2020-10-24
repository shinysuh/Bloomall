package com.bloomall.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bloomall.domain.AdminVO;
import com.bloomall.persistence.AdminDAO;

@Service
public class AdminServiceImpl implements AdminService {

	@Inject
	private AdminDAO dao;
	
//	@Inject
//	private BCryptPasswordEncoder cryptPassEnc;

	// 관리자 로그인
	@Override
	public AdminVO adminLogin(AdminVO vo) throws Exception {

		AdminVO adVO = dao.adminLogin(vo);
		
		if(adVO != null) {
			// 로그인 정보 일치 시
//			if(cryptPassEnc.matches(vo.getAd_pw(), adVO.getAd_pw())) {
//				dao.updateVisit(vo.getAd_id());
//			}else {
//				adVO = null;
//			}
			dao.updateVisit(vo.getAd_id());
		}
		return adVO;
	}
	
	
}
