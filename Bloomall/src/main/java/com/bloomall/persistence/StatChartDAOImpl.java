package com.bloomall.persistence;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bloomall.domain.OrderVO;
import com.bloomall.domain.StatChartVO;

@Repository
public class StatChartDAOImpl implements StatChartDAO {

	@Inject
	private SqlSession session;
	
	private final static String NS = "com.bloomall.mappers.StatChartMapper";

	// 1차 카테고리 별 매출(전체)
	@Override
	public List<StatChartVO> primaryChart() throws Exception {
		return session.selectList(NS + ".primaryChart");
	}
	
	// 1차 카테고리 별 매출(월별)
	@Override
	public List<StatChartVO> primaryChartByMonth(Timestamp ord_date) throws Exception {
		return session.selectList(NS +".primaryChartByMonth", ord_date);
	}

	// 2차 카테고리 별 매출(전체)
	@Override
	public List<StatChartVO> secondaryChart() throws Exception {
		return session.selectList(NS + ".secondaryChart");
	}
	
	// 2차 카테고리 별 매출(월별)
	@Override
	public List<StatChartVO> secondaryChartByMonth(Timestamp ord_date) throws Exception {
		return session.selectList(NS + ".secondaryChartByMonth", ord_date);
	}

	// 월별 매출
	@Override
	public List<OrderVO> monthlyChart(Timestamp ord_date) throws Exception {
		return session.selectList(NS + ".monthlyChart", ord_date);
	}

	
	
	
	
	
}
