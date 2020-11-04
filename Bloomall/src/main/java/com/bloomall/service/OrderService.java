package com.bloomall.service;

import java.util.List;
import java.util.Map;

import com.bloomall.domain.OrderDetailListVO;
import com.bloomall.domain.OrderDetailVO;
import com.bloomall.domain.OrderHistoryDetailVO;
import com.bloomall.domain.OrderHistoryVO;
import com.bloomall.domain.OrderVO;

public interface OrderService {
	
	// [단일상품] - 상품상세/상품리스트
	public int orderOne(OrderVO orderVO, OrderDetailVO detailVO) throws Exception;
	
	// [여러상품(선택상품)] - 상품리스트
	public int orderChk(OrderVO orderVO, OrderDetailListVO detailList) throws Exception;
//	public int orderChk(OrderVO orderVO, List<OrderDetailVO> detailList) throws Exception;
	
	// [단일상품] - 카트
	public int orderCartOne(String mem_id, OrderVO orderVO, OrderDetailVO detailVO) throws Exception;
	
	// [여러상품(선택)] - 카트
	public int orderCartChk(String mem_id, OrderVO orderVO, OrderDetailListVO detailList) throws Exception;
//	public int orderCartChk(String mem_id, OrderVO orderVO, List<OrderDetailVO> detailList) throws Exception;
	
	// [전체상품] - 카트
	public int orderCartAll(String mem_id, OrderVO orderVO, OrderDetailListVO detailList) throws Exception;
//	public int orderCartAll(String mem_id, OrderVO orderVO, List<OrderDetailVO> detailList) throws Exception;
	
	// 주문내역리스트 (OrderHistoryVO)
	public List<OrderHistoryVO> orderHistoryList(Map<String, Object> map) throws Exception;
	
	// 주문내역 개수 가져오기
	public int orderCount(String mem_id) throws Exception;
		
	// 주문 상세 내역 (OrderHistoryDetailVO) 
	public List<OrderHistoryDetailVO> orderHistoryDetail(int ord_idx) throws Exception;
		
	// 주문자 정보(주문테이블)
	public OrderVO recipientInfo(int ord_idx) throws Exception;
	
	// 회원 포인트 적립
	public void updatePoint(String mem_id, int mem_point) throws Exception;
	
}
