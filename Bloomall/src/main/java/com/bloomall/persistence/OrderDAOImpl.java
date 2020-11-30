package com.bloomall.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bloomall.domain.BackupOrderVO;
import com.bloomall.domain.CancelledDetailVO;
import com.bloomall.domain.CancelledListVO;
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
	public List<OrderHistoryVO> orderHistoryList(Map<String, Object> map) throws Exception {
		return session.selectList(NS + ".orderHistoryList", map);
	}

	// 주문내역 개수 가져오기
	@Override
	public int orderCount(String mem_id) throws Exception {
		return session.selectOne(NS + ".orderCount", mem_id);
	}

	// 주문 상세 내역 (OrderHistoryDetailVO)
	@Override
	public List<OrderHistoryDetailVO> orderHistoryDetail(int ord_idx) throws Exception {
		return session.selectList(NS + ".orderHistoryDetail", ord_idx);
	}

	// 주문자 정보(주문테이블)
	@Override
	public OrderVO recipientInfo(int ord_idx) throws Exception {
		return session.selectOne(NS + ".recipientInfo", ord_idx);
	}

	// 회원 포인트 적립
	@Override
	public void updatePoint(Map<String, Object> map) throws Exception {
		session.update(NS + ".updatePoint", map);
	}
	
	// 취소/반품 내역 리스트
	@Override
	public List<CancelledListVO> cancelledList(Map<String, Object> map) throws Exception {
		return session.selectList(NS + ".cancelledList", map);
	}

	// 취소/반품 개수
	@Override
	public int cancelled_Count(String mem_id) throws Exception {
		return session.selectOne(NS + ".cancelled_Count", mem_id);
	}

	// 취소/반품 상세
	@Override
	public List<CancelledDetailVO> cancelledDetail(int ord_idx) throws Exception {
		return session.selectList(NS + ".cancelledDetail", ord_idx);
	}

	// 취소/반품자 정보(주문취소(백업)테이블)
	@Override
	public BackupOrderVO cancelled_buyer(int ord_idx) throws Exception {
		return session.selectOne(NS + ".cancelled_buyer", ord_idx);
	}
	
	// 상품당 주문건수 (사용자 상품리스트에서 출력)
	@Override
	public int productSalesCount(int prd_idx) throws Exception {
		return session.selectOne(NS + ".productSalesCount", prd_idx);
	}

}
