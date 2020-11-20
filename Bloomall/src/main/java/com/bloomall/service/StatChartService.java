package com.bloomall.service;

import java.sql.Timestamp;
import java.util.List;

import com.bloomall.domain.StatChartVO;

public interface StatChartService {

	// 1차 카테고리 별 매출(전체)
	public List<StatChartVO> primaryChart() throws Exception;
	
	// 1차 카테고리 별 매출 비율(월별)
	public List<StatChartVO> primaryChartByMonth(Timestamp ord_date) throws Exception;
	
	// 2차 카테고리 별 매출(전체)
	public List<StatChartVO> secondaryChart() throws Exception;
	
	// 2차 카테고리 별 매출(월별)
	public List<StatChartVO> secondaryChartByMonth(Timestamp ord_date) throws Exception;
	
	// 월별 매출
	public List<StatChartVO> monthlyChart(Timestamp ord_date) throws Exception;
	
	// 매년 총 매출
	public List<StatChartVO> yearlySales() throws Exception;
	
	/*
	 * JSON 형태로 보낼때는 아래 코드들로 처리
	 * 
	// 1차 카테고리 별 매출(전체)
	public JSONObject primaryChartData() throws Exception;
	
	// 1차 카테고리 별 매출 비율(월별)
	public JSONObject primaryChartByMonthData(Timestamp ord_date) throws Exception;
	
	// 2차 카테고리 별 매출(전체)
	public JSONObject secondaryChartData() throws Exception;
	
	// 2차 카테고리 별 매출(월별)
	public JSONObject secondaryChartByMonthData(Timestamp ord_date) throws Exception;
	
	// 월별 매출
	public JSONObject monthlyChartData(Timestamp ord_date) throws Exception; 
	 */
	
}
