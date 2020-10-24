package com.bloomall.domain;

public class CartVO {
	/*
	cart_idx        number          primary key,                           -- 시퀀스
    prd_idx         number          not null references product_tb(prd_idx),
    mem_id          varchar2(50)    not null references member_tb(mem_id),
    cart_amount     number          not null
	 */

	private int 	cart_idx;
	private int 	prd_idx;
	private String 	mem_id;
	private int 	cart_amount;
	
	public int getCart_idx() {
		return cart_idx;
	}
	public void setCart_idx(int cart_idx) {
		this.cart_idx = cart_idx;
	}
	public int getPrd_idx() {
		return prd_idx;
	}
	public void setPrd_idx(int prd_idx) {
		this.prd_idx = prd_idx;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getCart_amount() {
		return cart_amount;
	}
	public void setCart_amount(int cart_amount) {
		this.cart_amount = cart_amount;
	}
	
	@Override
	public String toString() {
		return "CartVO [cart_idx=" + cart_idx + ", prd_idx=" + prd_idx + ", mem_id=" + mem_id + ", cart_amount="
				+ cart_amount + "]";
	}
	
}
