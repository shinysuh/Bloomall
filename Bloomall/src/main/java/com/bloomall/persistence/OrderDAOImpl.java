package com.bloomall.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bloomall.domain.OrderDetailVO;
import com.bloomall.domain.OrderHistoryDetailVO;
import com.bloomall.domain.OrderHistoryVO;
import com.bloomall.domain.OrderVO;

@Repository
public class OrderDAOImpl implements OrderDAO {
	
	@Inject
	private SqlSession session;
	
	private static final String NS = "com.bloomall.mappers.OrderMapper";

	// 주문코드 시퀀스
	@Override
	public int getOrderCode() throws Exception {
		return session.selectOne(NS + ".getOrderCode");
	}

	// 주문내역 추가 - 단일 상품
	@Override
	public void addOrderDetailOne(OrderDetailVO detailVO) throws Exception {
		session.insert(NS + ".addOrderDetailInfo", detailVO);
	}
	
	// 주문내역 추가(주문상세테이블) - 여러 상품
	@Override
	public void addOrderDetailList(List<OrderDetailVO> detailList) throws Exception {
		session.insert(NS + ".addOrderDetailInfo", detailList);
	}

	// 주문정보 추가(주문테이블) 
	@Override
	public void addOrderInfo(OrderVO orderVO) throws Exception {
		session.insert(NS + ".addOrderInfo", orderVO);
	}

	// 주문내역리스트 (OrderHistoryVO)
	@Override
	public List<OrderHistoryVO> orderHistoryList(String mem_id) throws Exception {
		return session.selectList(NS + ".orderHistoryList", mem_id);
	}

	// 주문 상세 내역 (OrderHistoryDetailVO)
	@Override
	public List<OrderHistoryDetailVO> orderHistoryDetail(int ord_idx) throws Exception {
		return session.selectOne(NS + ".orderHistoryDetail", ord_idx);
	}

	// 주문자 정보(주문테이블)
	@Override
	public OrderVO recipientInfo(int ord_idx) throws Exception {
		return session.selectOne(NS + ".recipientInfo", ord_idx);
	}

}
