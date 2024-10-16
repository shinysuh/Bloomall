package com.bloomall.persistence;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.bloomall.domain.AdminOrderListVO;
import com.bloomall.domain.AdminOrderStatVO;
import com.bloomall.domain.OrderVO;

public interface AdminOrderDAO {

	// 존재하는 주문번호 가져오기
	public List<Integer> getOrdIDX() throws Exception;
	
	// 주문 목록
	public List<AdminOrderListVO> orderList(Map<String, Object> map) throws Exception;
	
	// 주문 총 개수
	public int orderTotal(Map<String, Object> map) throws Exception;
	
	// 주문 당 주문상품 종류 개수
	public int productCount(int ord_idx) throws Exception;
	
	// 주문 상태 변경
	public void updateState(Map<String, Object> map) throws Exception;
	
	/* 주문정보 상세 페이지 [수정] */
	// 1)수령자정보/주문처리상태 수정 (주문테이블)
	public void updateRecipientAndState(OrderVO vo) throws Exception;
	// 2)상품별 수량 수정 (주문상세테이블)
	public void updateAmount(Map<String, Object> map) throws Exception;
	
	/* 주문정보 상세 페이지 [삭제] */
	// 1)주문상세테이블 삭제
	public void deleteDetail(int ord_idx) throws Exception;
	// 2)주문테이블 삭제
	public void deleteOrder(int ord_idx) throws Exception;
	// 3)회원 포인트 차감
	public void retrievePoint(Map<String, Object> map) throws Exception;
	
	// 주문 통계
	public List<AdminOrderStatVO> orderStat(Timestamp ord_date) throws Exception;
	
	
}
