package com.bloomall.persistence;

import java.sql.Timestamp;
import java.util.List;

import com.bloomall.domain.OrderVO;
import com.bloomall.domain.StatChartVO;

public interface StatChartDAO {

	// 1차 카테고리 별 매출(전체)
	public List<StatChartVO> primaryChart() throws Exception;
	
	// 1차 카테고리 별 매출 비율(월별)
	public List<StatChartVO> primaryChartByMonth(Timestamp ord_date) throws Exception;
	
	// 2차 카테고리 별 매출(전체)
	public List<StatChartVO> secondaryChart() throws Exception;
	
	// 2차 카테고리 별 매출(월별)
	public List<StatChartVO> secondaryChartByMonth(Timestamp ord_date) throws Exception;
	
	// 월별 매출
	public List<OrderVO> monthlyChart(Timestamp ord_date) throws Exception;
	
	
}
