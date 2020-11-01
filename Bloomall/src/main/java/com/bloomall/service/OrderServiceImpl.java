package com.bloomall.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bloomall.domain.OrderDetailVO;
import com.bloomall.domain.OrderHistoryDetailVO;
import com.bloomall.domain.OrderHistoryVO;
import com.bloomall.domain.OrderVO;
import com.bloomall.persistence.OrderDAO;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Inject
	private OrderDAO dao;

	@Inject
	private CartService cartService;	// 장바구니 주문 후, 장바구니 비우기 기능
	
	// [단일상품] - 상품상세/상품리스트
	@Transactional
	@Override
	public void orderOne(OrderVO orderVO, OrderDetailVO detailVO) throws Exception {
		
		// 주문정보, 주문상세정보에 동일한 주문번호 적용을 위해 주문번호를 먼저 따로 가져옴
		int ord_idx = dao.getOrderCode();
		
		// 1)주문정보 저장(주문테이블)
		// 주문정보에 주문번호 적용
		orderVO.setOrd_idx(ord_idx);
		dao.addOrderInfo(orderVO);
		
		// 2)주문상세 정보 저장(주문상세테이블)
		detailVO.setOrd_idx(ord_idx);
		dao.addOrderDetailOne(detailVO);
	}

	// [여러상품(선택상품)] - 상품리스트/카트(선택)/카트(전체)
	@Transactional
	@Override
	public void orderChk(OrderVO orderVO, List<OrderDetailVO> detailList) throws Exception {
		
		// 시퀀스 가져오기
		int ord_idx = dao.getOrderCode();

		// 1)주문정보 저장(주문테이블)
		// 주문정보에 주문번호 적용
		orderVO.setOrd_idx(ord_idx);
		dao.addOrderInfo(orderVO);
		
		// 2)주문상세정보 저장(주문상세 테이블) - 각 상품 주문 정보(주문상세)는 리스트 형태로 받음 - 파라미터 detailList
		// 주문상세 건 수 만큼 반복
		for(int i=0; i < detailList.size(); i++) {

			OrderDetailVO detailVO = detailList.get(i);
			// 주문상세 항목마다 주문번호 적용
			detailVO.setOrd_idx(ord_idx);
			// 주문상세리스트에 주문상세정보 추가
			detailList.add(detailVO);
		}
		// 주문상세정보 리스트로 저장
		dao.addOrderDetailList(detailList);
	}
	
	
	// [단일상품] - 카트
	@Transactional
	@Override
	public void orderCartOne(String mem_id, OrderVO orderVO, OrderDetailVO detailVO) throws Exception {
		
		// 주문정보, 주문상세정보에 동일한 주문번호 적용을 위해 주문번호를 먼저 따로 가져옴
		int ord_idx = dao.getOrderCode();
		
		// 1)주문정보 저장(주문테이블)
		// 주문정보에 주문번호 적용
		orderVO.setOrd_idx(ord_idx);
		dao.addOrderInfo(orderVO);
		
		// 2)주문상세 정보 저장(주문상세테이블)
		detailVO.setOrd_idx(ord_idx);
		dao.addOrderDetailOne(detailVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_id", mem_id);
		map.put("prd_idx", detailVO.getPrd_idx());
		
		// 장바구니에서 해당 상품 삭제
		cartService.emptyCart(map);
	}
	
	// [여러상품(선택)] - 카트
	@Transactional
	@Override
	public void orderCartChk(String mem_id, OrderVO orderVO, List<OrderDetailVO> detailList) throws Exception {
		
		// 주문번호 시퀀스
		int ord_idx = dao.getOrderCode();
		
		// 1)주문정보 저장(주문테이블)
		// 주문정보에 주문번호 적용
		orderVO.setOrd_idx(ord_idx);
		dao.addOrderInfo(orderVO);
		
		// 2)주문상세정보 저장(주문상세 테이블) - 각 상품 주문 정보(주문상세)는 리스트 형태로 받음 - 파라미터 detailList
		// 주문상세 건 수 만큼 반복
		for(int i=0; i < detailList.size(); i++) {

			OrderDetailVO detailVO = detailList.get(i);
			// 주문상세 항목마다 주문번호 적용
			detailVO.setOrd_idx(ord_idx);
			// 주문상세리스트에 주문상세정보 추가
			detailList.add(detailVO);

			// 장바구니에서 전체상품 주문 시, 장바구니 비울 때, 회원 아이디만 있어도 됨(for문 사용 필요 X)
			// 선택상품만 주문 시, 구매하지 않은 상품들은 장바구니에 남아있어야 하므로 구매한 상품들만 삭제해야 함
			// 이때, 구매 상품의 상품번호 필요
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("mem_id", mem_id);
			map.put("prd_idx", detailVO);
			
			// 장바구니에서 주문한 상품들 지우기
			cartService.emptyCart(map);
		}
		// 주문상세정보 리스트로 저장
		dao.addOrderDetailList(detailList);
	}
	
	// [전체상품] - 카트
	@Transactional
	@Override
	public void orderCartAll(String mem_id, OrderVO orderVO, List<OrderDetailVO> detailList) throws Exception {
		
		int ord_idx = dao.getOrderCode();
		
		orderVO.setOrd_idx(ord_idx);
		dao.addOrderInfo(orderVO);
		
		for(int i=0; i < detailList.size(); i++) {

			OrderDetailVO detailVO = detailList.get(i);
			// 주문상세 항목마다 주문번호 적용
			detailVO.setOrd_idx(ord_idx);
			// 주문상세리스트에 주문상세정보 추가
			detailList.add(detailVO);
		}
		// 주문상세정보 리스트로 저장
		dao.addOrderDetailList(detailList);

		// 장바구니 전체 비우기
		cartService.emptyCartAll(mem_id);
	}
	

	// 주문내역리스트 (OrderHistoryVO)
	@Override
	public List<OrderHistoryVO> orderHistoryList(Map<String, Object> map) throws Exception {
		return dao.orderHistoryList(map);
	}

	// 주문내역 개수 가져오기
	@Override
	public int orderCount(String mem_id) throws Exception {
		return dao.orderCount(mem_id);
	}
	
	// 주문 상세 내역 (OrderHistoryDetailVO)
	@Override
	public List<OrderHistoryDetailVO> orderHistoryDetail(int ord_idx) throws Exception {
		return dao.orderHistoryDetail(ord_idx);
	}

	// 주문자 정보(주문테이블)
	@Override
	public OrderVO recipientInfo(int ord_idx) throws Exception {
		return dao.recipientInfo(ord_idx);
	}


}
