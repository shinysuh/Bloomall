package com.bloomall.domain;

public class OrderDetailVO {

	/*
	ord_idx             number              not null references order_tb(ord_idx),
    prd_idx             number              not null references product_tb(prd_idx),
    ord_amount          number              not null,
    ord_price           number              not null,
    constraints ord_d_pk primary key(ord_idx, prd_idx)
	 */
	
	private int ord_idx;
	private int prd_idx;
	private int ord_amount;
	private int ord_price;
	
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
		return "OrderDetailVO [ord_idx=" + ord_idx + ", prd_idx=" + prd_idx + ", ord_amount=" + ord_amount
				+ ", ord_price=" + ord_price + "]";
	}
}
