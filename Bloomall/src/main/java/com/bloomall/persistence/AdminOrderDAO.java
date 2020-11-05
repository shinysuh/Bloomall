package com.bloomall.persistence;

import java.util.List;
import java.util.Map;

import com.bloomall.domain.AdminOrderListVO;
import com.bloomall.domain.OrderHistoryDetailVO;
import com.bloomall.util.SearchCriteria;

public interface AdminOrderDAO {

	// 주문 목록
	public List<AdminOrderListVO> orderList(SearchCriteria cri) throws Exception;
	
	// 주문 총 개수
	public int orderTotal() throws Exception;
	
	// 주문 당 주문상품 종류 개수
	public int productCount(int ord_idx) throws Exception;
	
	// 주문 상태 변경
	public void updateState(Map<String, Object> map) throws Exception;
	
	// 주문 상세 정보 페이지
	public List<OrderHistoryDetailVO> orderDetail(int ord_idx) throws Exception;
	
}
