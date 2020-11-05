package com.bloomall.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bloomall.domain.AdminOrderListVO;
import com.bloomall.domain.OrderHistoryDetailVO;
import com.bloomall.util.SearchCriteria;

@Repository
public class AdminOrderDAOImpl implements AdminOrderDAO {

	@Inject
	private SqlSession session;
	
	private final static String NS = "com.bloomall.mappers.AdminOrderMapper";

	// 주문 목록
	@Override
	public List<AdminOrderListVO> orderList(SearchCriteria cri) throws Exception {
		return session.selectList(NS + ".orderList", cri);
	}

	// 주문 총 개수
	@Override
	public int orderTotal() throws Exception {
		return session.selectOne(NS + ".orderTotal");
	}
	
	// 주문 당 주문상품 종류 개수
	@Override
	public int productCount(int ord_idx) throws Exception {
		return session.selectOne(NS + ".productCount", ord_idx);
	}
	
	// 주문 상태 변경
	@Override
	public void updateState(Map<String, Object> map) throws Exception {
		session.update(NS + ".updateState", map);
	}

	// 주문 상세 정보 페이지
	@Override
	public List<OrderHistoryDetailVO> orderDetail(int ord_idx) throws Exception {
		return session.selectList(NS + ".orderDetail", ord_idx);
	}

}
