package com.bloomall.domain;

// 데이터 시각화 차트용 VO
public class StatChartVO {
	
	private String primary_cd;		// 1차 카테고리별 
	private int sales_p;			// 1차별 매출 통계
	private String secondary_cd;	// 2차 카테고리별
	private int sales_s;			// 2차별 매출 통계
	private String month;			// 각 월
	private int monthly_sales;		// 월별 매출
	private String year;			// 각 연도
	private int total;				// 연도별 총매출
	
	public String getPrimary_cd() {
		return primary_cd;
	}
	public void setPrimary_cd(String primary_cd) {
		this.primary_cd = primary_cd;
	}
	public int getSales_p() {
		return sales_p;
	}
	public void setSales_p(int sales_p) {
		this.sales_p = sales_p;
	}
	public String getSecondary_cd() {
		return secondary_cd;
	}
	public void setSecondary_cd(String secondary_cd) {
		this.secondary_cd = secondary_cd;
	}
	public int getSales_s() {
		return sales_s;
	}
	public void setSales_s(int sales_s) {
		this.sales_s = sales_s;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getMonthly_sales() {
		return monthly_sales;
	}
	public void setMonthly_sales(int monthly_sales) {
		this.monthly_sales = monthly_sales;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
	@Override
	public String toString() {
		return "StatChartVO [primary_cd=" + primary_cd + ", sales_p=" + sales_p + ", secondary_cd=" + secondary_cd
				+ ", sales_s=" + sales_s + ", month=" + month + ", monthly_sales=" + monthly_sales + ", year=" + year
				+ ", total=" + total + "]";
	}

}
