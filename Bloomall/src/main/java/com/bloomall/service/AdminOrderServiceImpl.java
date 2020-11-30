package com.bloomall.service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bloomall.domain.AdminOrderListVO;
import com.bloomall.domain.AdminOrderStatVO;
import com.bloomall.domain.OrderVO;
import com.bloomall.persistence.AdminOrderDAO;

@Service
public class AdminOrderServiceImpl implements AdminOrderService {

	@Inject
	private AdminOrderDAO dao;

	// 존재하는 주문번호 가져오기
	@Override
	public List<Integer> getOrdIDX() throws Exception {
		return dao.getOrdIDX();
	}
	
	// 주문 목록
	@Override
	public List<AdminOrderListVO> orderList(Map<String, Object> map) throws Exception {
		return dao.orderList(map);
	}

	// 주문 총 개수
	@Override
	public int orderTotal(Map<String, Object> map) throws Exception {
		return dao.orderTotal(map);
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

	/* 주문정보 상세 페이지 [수정] */
	// 1)수령자정보/주문처리상태 수정 (주문테이블)
	public void updateRecipientAndState(OrderVO vo) throws Exception{
		dao.updateRecipientAndState(vo);
	}
	// 2)상품별 수량 수정 (주문상세테이블)
	@Override
	public void updateAmount(int ord_idx, int prd_idx, int ord_amount) throws Exception {
		
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("ord_idx", ord_idx);
		map.put("prd_idx", prd_idx);
		map.put("ord_amount", ord_amount);
		
		dao.updateAmount(map);
	}

	
	
	/* 주문정보 상세 페이지 [삭제] */
	@Override
	public void deleteOrder(int ord_idx, String mem_id, int mem_point) throws Exception {
		// 1)주문상세 삭제
		dao.deleteDetail(ord_idx);
		// 2)주문 삭제
		dao.deleteOrder(ord_idx);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_id", mem_id);
		map.put("mem_point", mem_point);
		
		// 3)회원포인트 차감
		dao.retrievePoint(map);
	}

	// 주문 통계
	@Override
	public List<AdminOrderStatVO> orderStat(Timestamp ord_date) throws Exception {
		return dao.orderStat(ord_date);
	}


}
