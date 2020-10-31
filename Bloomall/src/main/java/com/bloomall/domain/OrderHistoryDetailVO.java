package com.bloomall.domain;

/* 주문 내역 상세 페이지 */
public class OrderHistoryDetailVO {
	
	private int 	ord_idx;		// 주문번호 - OrderVO
	private int 	prd_idx;   		// 상품코드 - OrderDetailVO
	private String 	prd_title; 		// 주문내역(주문 상품명)  - ProductVO
	private String 	prd_img;		// 상품이미지  - ProductVO
	private int 	prd_price;    	// 상품 가격 - ProductVO
	private int 	ord_amount;  	// 각 주문수량 - OrderDetailVO
	private int 	ord_tot_price;  // 총 주문금액 - OrderVO
	private int 	mem_point;		// 회원 포인트 적립 - MemberVO
	
	public int getOrd_idx() {
		return ord_idx;
	}
	public void setOrd_idx(int ord_idx) {
		this.ord_idx = ord_idx;
	}
	public int getPrd_idx() {
		return prd_idx;
	}
	public void setPrd_idx(int prd_idx) {
		this.prd_idx = prd_idx;
	}
	public String getPrd_title() {
		return prd_title;
	}
	public void setPrd_title(String prd_title) {
		this.prd_title = prd_title;
	}
	public String getPrd_img() {
		return prd_img;
	}
	public void setPrd_img(String prd_img) {
		this.prd_img = prd_img;
	}
	public int getPrd_price() {
		return prd_price;
	}
	public void setPrd_price(int prd_price) {
		this.prd_price = prd_price;
	}
	public int getOrd_amount() {
		return ord_amount;
	}
	public void setOrd_amount(int ord_amount) {
		this.ord_amount = ord_amount;
	}
	public int getOrd_tot_price() {
		return ord_tot_price;
	}
	public void setOrd_tot_price(int ord_tot_price) {
		this.ord_tot_price = ord_tot_price;
	}
	public int getMem_point() {
		return mem_point;
	}
	public void setMem_point(int mem_point) {
		this.mem_point = mem_point;
	}
	
	@Override
	public String toString() {
		return "OrderHistoryDetailVO [ord_idx=" + ord_idx + ", prd_idx=" + prd_idx + ", prd_title=" + prd_title
				+ ", prd_img=" + prd_img + ", prd_price=" + prd_price + ", ord_amount=" + ord_amount
				+ ", ord_tot_price=" + ord_tot_price + ", mem_point=" + mem_point + "]";
	}
}
