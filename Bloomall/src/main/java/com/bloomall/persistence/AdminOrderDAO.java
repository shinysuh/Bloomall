package com.bloomall.persistence;

import java.util.List;
import java.util.Map;

import com.bloomall.domain.AdminOrderDetailVO;
import com.bloomall.domain.AdminOrderListVO;
import com.bloomall.util.SearchCriteria;

public interface AdminOrderDAO {

	// 존재하는 주문번호 가져오기
	public List<Integer> getOrdIDX() throws Exception;
	
	// 주문 목록
	public List<AdminOrderListVO> orderList(Map<String, Object> map) throws Exception;
	
	// 주문 총 개수
	public int orderTotal() throws Exception;
	
	// 주문 당 주문상품 종류 개수
	public int productCount(int ord_idx) throws Exception;
	
	// 주문 상태 변경
	public void updateState(Map<String, Object> map) throws Exception;
	
	// 주문 상세 정보 페이지
	public List<AdminOrderDetailVO> orderDetail(int ord_idx) throws Exception;
	
}
