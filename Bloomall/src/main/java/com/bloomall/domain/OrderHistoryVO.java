package com.bloomall.domain;

import java.sql.Timestamp;

/* 주문 내역 리스트 페이지 */
public class OrderHistoryVO {

	private int 	ord_idx;		// 주문번호 - OrderVO
	private String 	prd_title; 		// 주문내역(주문 상품명)  - ProductVO
	private int 	prd_price;    	// 상품 가격 - ProductVO
	private int 	ord_tot_price;  // 총 주문금액 - OrderVO
	private int 	ord_amount;  	// 각 주문수량 - OrderDetailVO
	private String 	mem_id;			// 주문자 - OrderVO
	private String 	ord_recp_name; 	// 수령자 - OrderVO
	private Timestamp ord_date;		// 주문날짜 - OrderVO
	
	public int getOrd_idx() {
		return ord_idx;
	}
	public void setOrd_idx(int ord_idx) {
		this.ord_idx = ord_idx;
	}
	public String getPrd_title() {
		return prd_title;
	}
	public void setPrd_title(String prd_title) {
		this.prd_title = prd_title;
	}
	public int getPrd_price() {
		return prd_price;
	}
	public void setPrd_price(int prd_price) {
		this.prd_price = prd_price;
	}
	public int getOrd_tot_price() {
		return ord_tot_price;
	}
	public void setOrd_tot_price(int ord_tot_price) {
		this.ord_tot_price = ord_tot_price;
	}
	public int getOrd_amount() {
		return ord_amount;
	}
	public void setOrd_amount(int ord_amount) {
		this.ord_amount = ord_amount;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getOrd_recp_name() {
		return ord_recp_name;
	}
	public void setOrd_recp_name(String ord_recp_name) {
		this.ord_recp_name = ord_recp_name;
	}
	public Timestamp getOrd_date() {
		return ord_date;
	}
	public void setOrd_date(Timestamp ord_date) {
		this.ord_date = ord_date;
	}
	
	@Override
	public String toString() {
		return "OrderHistoryVO [ord_idx=" + ord_idx + ", prd_title=" + prd_title + ", prd_price=" + prd_price
				+ ", ord_tot_price=" + ord_tot_price + ", ord_amount=" + ord_amount + ", mem_id=" + mem_id
				+ ", ord_recp_name=" + ord_recp_name + ", ord_date=" + ord_date + "]";
	}
}
