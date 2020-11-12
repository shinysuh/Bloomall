package com.bloomall.domain;

import java.sql.Timestamp;

/* 주문 내역 리스트 페이지 */
public class AdminOrderListVO {

	private int 	ord_idx;		// 주문번호 - OrderVO
	private String 	prd_title; 		// 주문내역(주문 상품명)  - ProductVO
	private int 	prd_price;    	// 상품 가격 - ProductVO
	private String	prd_company;	// 출판사 - ProductVO
	private int 	ord_tot_price;  // 총 주문금액 - OrderVO
	private int 	ord_amount;  	// 각 주문수량 - OrderDetailVO
	private String 	mem_id;			// 주문자 - OrderVO
	private String 	mem_name;		// 주문자명 - MemberVO
	private String 	ord_recp_name; 	// 수령자 - OrderVO
	private Timestamp ord_date;		// 주문날짜 - OrderVO
	private int 	ord_state;		// 주문처리 현황 - OrderVO
	private int 	ord_count;
	private Timestamp ord_updatedate;
	
	public int getOrd_count() {
		return ord_count;
	}
	public void setOrd_count(int ord_count) {
		this.ord_count = ord_count;
	}
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
	public String getPrd_company() {
		return prd_company;
	}
	public void setPrd_company(String prd_company) {
		this.prd_company = prd_company;
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
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
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
	public int getOrd_state() {
		return ord_state;
	}
	public void setOrd_state(int ord_state) {
		this.ord_state = ord_state;
	}
	public Timestamp getOrd_updatedate() {
		return ord_updatedate;
	}
	public void setOrd_updatedate(Timestamp ord_updatedate) {
		this.ord_updatedate = ord_updatedate;
	}
	
	@Override
	public String toString() {
		return "AdminOrderListVO [ord_idx=" + ord_idx + ", prd_title=" + prd_title + ", prd_price=" + prd_price
				+ ", prd_company=" + prd_company + ", ord_tot_price=" + ord_tot_price + ", ord_amount=" + ord_amount
				+ ", mem_id=" + mem_id + ", mem_name=" + mem_name + ", ord_recp_name=" + ord_recp_name + ", ord_date="
				+ ord_date + ", ord_state=" + ord_state + ", ord_count=" + ord_count + ", ord_updatedate="
				+ ord_updatedate + "]";
	}
}
