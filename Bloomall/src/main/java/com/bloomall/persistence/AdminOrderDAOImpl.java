package com.bloomall.persistence;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bloomall.domain.AdminOrderListVO;
import com.bloomall.domain.AdminOrderStatVO;
import com.bloomall.domain.OrderVO;

@Repository
public class AdminOrderDAOImpl implements AdminOrderDAO {

	@Inject
	private SqlSession session;
	
	private final static String NS = "com.bloomall.mappers.AdminOrderMapper";

	// 존재하는 주문번호 가져오기
	@Override
	public List<Integer> getOrdIDX() throws Exception {
		return session.selectList(NS + ".getOrdIDX");
	}

	// 주문 목록
	@Override
	public List<AdminOrderListVO> orderList(Map<String, Object> map) throws Exception {
		return session.selectList(NS + ".orderList", map);
	}

	// 주문 총 개수
	@Override
	public int orderTotal(Map<String, Object> map) throws Exception {
		return session.selectOne(NS + ".orderTotal", map);
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

	
	/* 주문정보 상세 페이지 [수정] */
	// 1)수령자정보/주문처리상태 수정 (주문테이블)
	@Override
	public void updateRecipientAndState(OrderVO vo) throws Exception {
		session.update(NS + ".updateRecipientAndState", vo);
	}
	// 2)상품별 수량 수정 (주문상세테이블)
	@Override
	public void updateAmount(Map<String, Object> map) throws Exception {
		session.update(NS + ".updateAmount", map);
	}

	/* 주문정보 상세 페이지 [삭제] */
	// 1)주문상세테이블 삭제
	@Override
	public void deleteDetail(int ord_idx) throws Exception {
		session.delete(NS + ".deleteDetail", ord_idx);
	}
	// 2)주문테이블 삭제
	@Override
	public void deleteOrder(int ord_idx) throws Exception {
		session.delete(NS + ".deleteOrder", ord_idx);
	}
	// 3)회원 포인트 차감
	@Override
	public void retrievePoint(Map<String, Object> map) throws Exception {
		session.update(NS + ".retrievePoint", map);
	}

	// 주문 통계
	@Override
	public List<AdminOrderStatVO> orderStat(Timestamp ord_date) throws Exception {
		return session.selectList(NS + ".orderStat", ord_date);
	}





}
