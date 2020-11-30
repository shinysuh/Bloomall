package com.bloomall.domain;

public class CancelledDetailVO {
	/*  취소/반품 상세 VO
	 * >> 주문상세 백업 테이블과 조인
	 * 
		select d.ord_idx, d.prd_idx, p.prd_title, p.prd_img, d.ord_amount, d.ord_price
		from backup_o_detail_tb d
		inner join product_tb p
		    on p.prd_idx = d.prd_idx
		where d.ord_idx=#{ord_idx}
		order by d.prd_idx desc

	 */
	
	private int 	ord_idx;		// 주문번호 - BackupOrderDetailVO
	private int 	prd_idx;   		// 상품코드 - BackupOrderDetailVO
	private String 	prd_title; 		// 주문내역(주문 상품명) - ProductVO
	private String 	prd_img;		// 상품이미지  - ProductVO
	private int 	ord_amount;  	// 각 주문수량 - BackupOrderDetailVO
	private int 	ord_price;  	// 각 상품 주문금액 - BackupOrderDetailVO
	
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
		return "CancelledDetailVO [ord_idx=" + ord_idx + ", prd_idx=" + prd_idx + ", prd_title=" + prd_title
				+ ", prd_img=" + prd_img + ", ord_amount=" + ord_amount + ", ord_price=" + ord_price + "]";
	}

}
