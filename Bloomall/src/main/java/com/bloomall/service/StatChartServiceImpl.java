package com.bloomall.service;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bloomall.domain.StatChartVO;
import com.bloomall.persistence.StatChartDAO;

@Service
public class StatChartServiceImpl implements StatChartService {

	@Inject
	private StatChartDAO dao;

	// 1차 카테고리 별 매출(전체)
	@Override
	public List<StatChartVO> primaryChart() throws Exception {
		return dao.primaryChart();
	}

	// 1차 카테고리 별 매출 비율(월별)
	@Override
	public List<StatChartVO> primaryChartByMonth(Timestamp ord_date) throws Exception {
		return dao.primaryChartByMonth(ord_date);
	}

	// 2차 카테고리 별 매출(전체)
	@Override
	public List<StatChartVO> secondaryChart() throws Exception {
		return dao.secondaryChart();
	}

	// 2차 카테고리 별 매출(월별)
	@Override
	public List<StatChartVO> secondaryChartByMonth(Timestamp ord_date) throws Exception {
		return dao.secondaryChartByMonth(ord_date);
	}

	// 월별 매출
	@Override
	public List<StatChartVO> monthlyChart(Timestamp ord_date) throws Exception {
		return dao.monthlyChart(ord_date);
	}

	// 매년 총 매출
	@Override
	public List<StatChartVO> yearlySales() throws Exception {
		return dao.yearlySales();
	}
	
	
	
	/* 
	 * JSON 형태로 넘길 때 코드
	 * 
	// 1차 카테고리 별 매출(전체)
	@Override
	public JSONObject primaryChartData() throws Exception {
		
		return (JSONObject) dao.primaryChart();
	}

	// 1차 카테고리 별 매출 비율(월별)
	@Override
	public JSONObject primaryChartByMonthData(Timestamp ord_date) throws Exception {
		return (JSONObject) dao.primaryChartByMonth(ord_date);
	}

	// 2차 카테고리 별 매출(전체)
	@Override
	public JSONObject secondaryChartData() throws Exception {
		return (JSONObject) dao.secondaryChart();
	}

	// 2차 카테고리 별 매출(월별)
	@Override
	public JSONObject secondaryChartByMonthData(Timestamp ord_date) throws Exception {
		return (JSONObject) dao.secondaryChartByMonth(ord_date);
	}

	// 월별 매출
	@Override
	public JSONObject monthlyChartData(Timestamp ord_date) throws Exception {
		return (JSONObject) dao.monthlyChart(ord_date);
	}
	*/
	
	
	
	
}
