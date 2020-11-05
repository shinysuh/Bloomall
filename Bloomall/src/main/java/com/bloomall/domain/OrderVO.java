package com.bloomall.domain;

import java.sql.Timestamp;

public class OrderVO {

	/*
	ord_idx             number                  primary key,                           -- 시퀀스
    mem_id              varchar2(50)            not null references member_tb(mem_id),
    ord_recp_name       varchar2(30)            not null,
    ord_recp_zip        char(5)                 not null,
    ord_recp_addr       varchar2(50)            not null,
    ord_recp_addr_d     varchar2(50)            not null,
    ord_recp_tel        varchar2(15)            not null,
    ord_tot_price       number                  not null,
    ord_date            date default sysdate	not null,
    ord_state			number
	 */
	
	private int 	ord_idx;
	private String 	mem_id;
	private String 	ord_recp_name;
	private String 	ord_recp_zip;
	private String 	ord_recp_addr;
	private String 	ord_recp_addr_d;
	private String 	ord_recp_tel;
	private int 	ord_tot_price;
	private Timestamp ord_date;
	private int 	ord_state;		// 주문처리 현황
	
	public int getOrd_idx() {
		return ord_idx;
	}
	public void setOrd_idx(int ord_idx) {
		this.ord_idx = ord_idx;
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
	public String getOrd_recp_zip() {
		return ord_recp_zip;
	}
	public void setOrd_recp_zip(String ord_recp_zip) {
		this.ord_recp_zip = ord_recp_zip;
	}
	public String getOrd_recp_addr() {
		return ord_recp_addr;
	}
	public void setOrd_recp_addr(String ord_recp_addr) {
		this.ord_recp_addr = ord_recp_addr;
	}
	public String getOrd_recp_addr_d() {
		return ord_recp_addr_d;
	}
	public void setOrd_recp_addr_d(String ord_recp_addr_d) {
		this.ord_recp_addr_d = ord_recp_addr_d;
	}
	public String getOrd_recp_tel() {
		return ord_recp_tel;
	}
	public void setOrd_recp_tel(String ord_recp_tel) {
		this.ord_recp_tel = ord_recp_tel;
	}
	public int getOrd_tot_price() {
		return ord_tot_price;
	}
	public void setOrd_tot_price(int ord_tot_price) {
		this.ord_tot_price = ord_tot_price;
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
	
	@Override
	public String toString() {
		return "OrderVO [ord_idx=" + ord_idx + ", mem_id=" + mem_id + ", ord_recp_name=" + ord_recp_name
				+ ", ord_recp_zip=" + ord_recp_zip + ", ord_recp_addr=" + ord_recp_addr + ", ord_recp_addr_d="
				+ ord_recp_addr_d + ", ord_recp_tel=" + ord_recp_tel + ", ord_tot_price=" + ord_tot_price
				+ ", ord_date=" + ord_date + ", ord_state=" + ord_state + "]";
	}
}
