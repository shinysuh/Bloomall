package com.bloomall.domain;

import java.sql.Timestamp;

public class AdminOrderStatVO {
	
	/*
	 * select count(ord_idx) order_count, TO_CHAR(ord_date, 'YYYY/MM/DD') order_date, sum(ord_tot_price) total_sales
		        , (select count(ord_idx) from order_tb where ord_state=4) delivered                 -- 걸러낼 조건 더 필요
		        , (select count(ord_idx) from order_tb where ord_state=3 or ord_state=4) shipped    -- 걸러낼 조건 더 필요
		from order_tb
		--where TO_CHAR(ord_date, 'YYYY/MM') =  #{ord_date}          -- '2020/11'          -- 연/월 조건에 따라
		group by TO_CHAR(ord_date, 'YYYY/MM/DD') -- 수치들 (일)로 묶어서 출력
		
		order by TO_CHAR(ord_date, 'YYYY/MM/DD') asc
	 */

	private String order_date;		// 일별통계 - yyyy/MM/dd 형태
	private int order_count;		// 일일 주문건수
	private int total_sales;		// 일일 총 매출
	private int delivered;			// 배송건수(배송완료 상태 개수)
	private int shipped;			// 발송건수(배송중)
	private Timestamp ord_updatedate;	// 주문정보 수정 날짜
	
	public int getOrder_count() {
		return order_count;
	}
	public void setOrder_count(int order_count) {
		this.order_count = order_count;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public int getTotal_sales() {
		return total_sales;
	}
	public void setTotal_sales(int total_sales) {
		this.total_sales = total_sales;
	}
	public int getDelivered() {
		return delivered;
	}
	public void setDelivered(int delivered) {
		this.delivered = delivered;
	}
	public int getShipped() {
		return shipped;
	}
	public void setShipped(int shipped) {
		this.shipped = shipped;
	}
	public Timestamp getOrd_updatedate() {
		return ord_updatedate;
	}
	public void setOrd_updatedate(Timestamp ord_updatedate) {
		this.ord_updatedate = ord_updatedate;
	}
	
	@Override
	public String toString() {
		return "AdminOrderStatVO [order_date=" + order_date + ", order_count=" + order_count + ", total_sales="
				+ total_sales + ", delivered=" + delivered + ", shipped=" + shipped + ", ord_updatedate="
				+ ord_updatedate + "]";
	}
	
}
