package com.bloomall.domain;

public class UserCartListVO {

	/* 사용자 입장에서 장바구니에 담긴 상품목록을 위한 VO */
	
	private int 	cart_idx;		// 카트 번호
	private int 	cart_amount;	// 구매 수량
	private int 	prd_idx;		// 상품 번호
	private String 	prd_title;		// 상품(책) 제목
	private int 	prd_price;		// 상품 판매가
	private int 	prd_dc_price;	// 상품 할인가
	private String 	prd_img;		// 상품 이미지
	
	public int getCart_idx() {
		return cart_idx;
	}
	public void setCart_idx(int cart_idx) {
		this.cart_idx = cart_idx;
	}
	public int getCart_amount() {
		return cart_amount;
	}
	public void setCart_amount(int cart_amount) {
		this.cart_amount = cart_amount;
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
	public int getPrd_price() {
		return prd_price;
	}
	public void setPrd_price(int prd_price) {
		this.prd_price = prd_price;
	}
	public int getPrd_dc_price() {
		return prd_dc_price;
	}
	public void setPrd_dc_price(int prd_dc_price) {
		this.prd_dc_price = prd_dc_price;
	}
	public String getPrd_img() {
		return prd_img;
	}
	public void setPrd_img(String prd_img) {
		this.prd_img = prd_img;
	}
	
	@Override
	public String toString() {
		return "UserCartListVO [cart_idx=" + cart_idx + ", cart_amount=" + cart_amount + ", prd_idx=" + prd_idx
				+ ", prd_title=" + prd_title + ", prd_price=" + prd_price + ", prd_dc_price=" + prd_dc_price
				+ ", prd_img=" + prd_img + "]";
	}
	
	
}
