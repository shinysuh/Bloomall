package com.bloomall.service;

import java.util.List;

import com.bloomall.domain.OrderDetailVO;
import com.bloomall.domain.OrderHistoryDetailVO;
import com.bloomall.domain.OrderHistoryVO;
import com.bloomall.domain.OrderVO;

public interface OrderService {
	
	// [단일상품] - 상품상세/상품리스트/카트
	public void purchaseOne(OrderVO orderVO, OrderDetailVO detailVO) throws Exception;
	
	// [여러상품(선택상품)] - 상품리스트/카트(선택)/카트(전체)
	public void purachseMultiple(OrderVO orderVO, List<OrderDetailVO> detailList) throws Exception;
	

//	// 상품상세/상품리스트 => [바로구매] 단일 상품
//	public void purchaseOne(OrderVO orderVO, OrderDetailVO detailVO) throws Exception;
//	
//	// 상품리스트 => [바로구매] 여러 상품
//	public void purachseMultiple(OrderVO orderVO, List<OrderDetailVO> detailList) throws Exception;
//	
//	// 장바구니 구매 - 선택상품
//	public void purchaseCart(String mem_id, OrderVO orderVO, List<OrderDetailVO> detailList) throws Exception;
//
//	// 장바구니 구매 - 전체상품
//	public void purchaseAllCart(String mem_id, OrderVO orderVO, List<OrderDetailVO> detailList) throws Exception;
	
	// 주문내역리스트 (OrderHistoryVO)
	public List<OrderHistoryVO> orderHistoryList(String mem_id) throws Exception;
		
	// 주문 상세 내역 (OrderHistoryDetailVO) 
	public List<OrderHistoryDetailVO> orderHistoryDetail(int ord_idx) throws Exception;
		
	// 주문자 정보(주문테이블)
	public OrderVO recipientInfo(int ord_idx) throws Exception;
}
