package com.bloomall.persistence;

import java.util.List;
import java.util.Map;

import com.bloomall.domain.BackupOrderVO;
import com.bloomall.domain.CancelledDetailVO;
import com.bloomall.domain.CancelledListVO;
import com.bloomall.domain.OrderDetailVO;
import com.bloomall.domain.OrderHistoryDetailVO;
import com.bloomall.domain.OrderHistoryVO;
import com.bloomall.domain.OrderVO;

public interface OrderDAO {

	// 주문코드 시퀀스
	public int getOrderCode() throws Exception;
	
	// 주문내역 추가 - 단일 상품
	public void addOrderDetailOne(OrderDetailVO detailVO) throws Exception;
	
	// 주문내역 추가(주문상세테이블) - 여러 상품
	public void addOrderDetailList(List<OrderDetailVO> detailList) throws Exception;
	
	// 주문정보 추가(주문테이블) 
	public void addOrderInfo(OrderVO orderVO) throws Exception;
		
	// 주문내역리스트 (OrderHistoryVO)
	public List<OrderHistoryVO> orderHistoryList(Map<String, Object> map) throws Exception;
	
	// 주문내역 개수 가져오기
	public int orderCount(String mem_id) throws Exception;
		
	// 주문 상세 내역 (OrderHistoryDetailVO) 
	public List<OrderHistoryDetailVO> orderHistoryDetail(int ord_idx) throws Exception;
		
	// 주문자 정보(주문테이블)
	public OrderVO recipientInfo(int ord_idx) throws Exception;
	
	// 회원 포인트 적립
	public void updatePoint(Map<String, Object> map) throws Exception;
	
	// 취소/반품 내역 리스트
	public List<CancelledListVO> cancelledList(Map<String, Object> map) throws Exception;
	
	// 취소/반품 개수
	public int cancelled_Count(String mem_id) throws Exception;
	
	// 취소/반품 상세
	public List<CancelledDetailVO> cancelledDetail(int ord_idx) throws Exception;
	
	// 취소/반품자 정보(주문취소(백업)테이블)
	public BackupOrderVO cancelled_buyer(int ord_idx) throws Exception;
	
	// 상품당 주문건수 (사용자 상품리스트에서 출력)
	public int productSalesCount(int prd_idx) throws Exception;
}
