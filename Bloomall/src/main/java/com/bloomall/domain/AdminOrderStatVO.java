package com.bloomall.domain;

import java.sql.Timestamp;

public class AdminOrderStatVO {
	
	/*
	 * select order_count, order_date, total_sales
		       , (select count(ord_idx) from order_tb where ord_state=3 and TO_CHAR(state_updatedate, 'YYYY/MM/DD') = order_date) shipped
		       ,  (select count(ord_idx) from order_tb where ord_state=4 and TO_CHAR(state_updatedate, 'YYYY/MM/DD') = order_date) delivered
		from (
		        select count(ord_idx) order_count, TO_CHAR(ord_date, 'YYYY/MM/DD') order_date, sum(ord_tot_price) total_sales
		        from order_tb
		        where TO_CHAR(ord_date, 'YYYY/MM') =  TO_CHAR(#{ord_date}, 'YYYY/MM')		-- 연/월 조건에 따라
		        group by TO_CHAR(ord_date, 'YYYY/MM/DD')		-- (일)별로 묶어 출력
		        order by TO_CHAR(ord_date, 'YYYY/MM/DD') asc
			 )
			 
			 
		select order_count, order_date, total_sales, date1, day
		       , (select count(ord_idx) from order_tb where ord_state=3 and TO_CHAR(state_updatedate, 'YYYY/MM/DD') = date1) shipped
		       ,  (select count(ord_idx) from order_tb where ord_state=4 and TO_CHAR(state_updatedate, 'YYYY/MM/DD') = date1) delivered
		from (
		        select count(ord_idx) order_count, TO_CHAR(ord_date, 'YYYY/MM/DD') date1, sum(ord_tot_price) total_sales
        		from order_tb
		        where TO_CHAR(ord_date, 'YYYY/MM') =  TO_CHAR(#{ord_date}, 'YYYY/MM')		-- 연/월 조건에 따라
		        group by TO_CHAR(ord_date, 'YYYY/MM/DD')						-- (일)별로 묶어 출력
		        
		) c right join 
		<![CDATA[
		(select TO_CHAR(#{ord_date} + level -1 , 'YYYY/MM/DD') order_date, to_char(trunc(sysdate, 'IW') + level -1, 'day') day		-- 해당 월의 날짜 전부와 요일
		from dual
		connect by level <= (last_day(#{ord_date}) - trunc (#{ord_date}, 'month') +1)) d
		on c.date1=d.order_date
		]]>
		order by order_date asc
	 */

	private String order_date;		// 일별통계 - yyyy/MM/dd 형태
	private int order_count;		// 일일 주문건수
	private int total_sales;		// 일일 총 매출
	private int delivered;			// 배송건수(배송완료 상태 개수)
	private int shipped;			// 발송건수(배송중)
	private Timestamp state_updatedate;	// 주문처리상태 수정날짜(일일 발송/배송 건수 추적용)
	private String day;				// 요일 출력
	
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public int getOrder_count() {
		return order_count;
	}
	public void setOrder_count(int order_count) {
		this.order_count = order_count;
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
	public Timestamp getState_updatedate() {
		return state_updatedate;
	}
	public void setState_updatedate(Timestamp state_updatedate) {
		this.state_updatedate = state_updatedate;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	
	@Override
	public String toString() {
		return "AdminOrderStatVO [order_date=" + order_date + ", order_count=" + order_count + ", total_sales="
				+ total_sales + ", delivered=" + delivered + ", shipped=" + shipped + ", state_updatedate="
				+ state_updatedate + ", day=" + day + "]";
	}
	
}
