package com.bloomall.domain;

/* 주문 내역 상세 페이지 */
public class OrderHistoryDetailVO {
	
	private int 	ord_idx;		// 주문번호 - OrderVO
	private int 	prd_idx;   		// 상품코드 - OrderDetailVO
	private String 	prd_title; 		// 주문내역(주문 상품명)  - ProductVO
	private String 	prd_img;		// 상품이미지  - ProductVO
	private int 	prd_price;    	// 상품 가격 - ProductVO
	private int 	ord_amount;  	// 각 주문수량 - OrderDetailVO
	private int 	ord_price;  	// 각 상품 주문금액 - OrderDetailVO
	
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
	public int getOrd_price() {
		return ord_price;
	}
	public void setOrd_price(int ord_price) {
		this.ord_price = ord_price;
	}
	
	@Override
	public String toString() {
		return "OrderHistoryDetailVO [ord_idx=" + ord_idx + ", prd_idx=" + prd_idx + ", prd_title=" + prd_title
				+ ", prd_img=" + prd_img + ", prd_price=" + prd_price + ", ord_amount=" + ord_amount + ", ord_price="
				+ ord_price + "]";
	}
}
