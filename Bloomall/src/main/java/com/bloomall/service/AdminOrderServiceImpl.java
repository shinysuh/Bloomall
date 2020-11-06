package com.bloomall.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bloomall.domain.AdminOrderDetailVO;
import com.bloomall.domain.AdminOrderListVO;
import com.bloomall.persistence.AdminOrderDAO;
import com.bloomall.util.SearchCriteria;

@Service
public class AdminOrderServiceImpl implements AdminOrderService {

	@Inject
	private AdminOrderDAO dao;
	
	// 주문 목록
	@Override
	public List<AdminOrderListVO> orderList(SearchCriteria cri) throws Exception {
		return dao.orderList(cri);
	}

	// 주문 총 개수
	@Override
	public int orderTotal() throws Exception {
		return dao.orderTotal();
	}

	// 주문 당 주문상품 종류 개수
	@Override
	public int productCount(int ord_idx) throws Exception {
		return dao.productCount(ord_idx);
	}
	
	// 주문 상태 변경
	@Override
	public void updateState(int ord_idx, int ord_state) throws Exception {
		
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("ord_state", ord_state);
		map.put("ord_idx", ord_idx);
		
		dao.updateState(map);
	}

	// 주문 상세 정보 페이지
	@Override
	public List<AdminOrderDetailVO> orderDetail(int ord_idx) throws Exception {
		return dao.orderDetail(ord_idx);
	}
}
