package com.bloomall.domain;

import java.sql.Timestamp;

public class BackupOrderVO {
	/*	주문 백업 테이블
	 *  ord_idx             number                  primary key,                           
	    mem_id              varchar2(50)            not null references member_tb(mem_id),
	    ord_recp_name       varchar2(30)            not null,
	    ord_recp_zip        char(5)                 not null,
	    ord_recp_addr       varchar2(50)            not null,
	    ord_recp_addr_d     varchar2(50)            not null,
	    ord_recp_tel        varchar2(15)            not null,
	    ord_tot_price       number                  not null,
	    ord_date            date default sysdate    not null,
	    ord_state           number default 1,
	    ord_count           number default 1,
	    ord_updatedate      date default sysdate,
	    state_updatedate    date default sysdate,
	    return_state        number default 7        not null,       -- 취소/환불상태 '주문취소(7)/환불처리중(8)/환불완료(9)'
	    cancel_date         date default sysdate    not null,       -- 주문취소 접수 날짜
	    cancel_updatedate   date default sysdate    not null       -- 취소/환불상태 변경날짜 (개발단 처리)
	    --, cancel_user         varchar2(20)            not null        -- 주문취소 접수자(관리자 중) 아이디
	 */
	private int ord_idx;
	private String mem_id;
	private String ord_recp_name;
	private String ord_recp_zip;
	private String ord_recp_addr;
	private String ord_recp_addr_d;
	private String ord_recp_tel;
	private int ord_tot_price;
	private Timestamp ord_date;
	private int ord_state;
	private int ord_count;
	private Timestamp ord_updatedate;
	private Timestamp state_updatedate;
	private int return_state;
	private Timestamp cancel_date;
	private Timestamp cancel_updatedate;
	
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
	public int getOrd_count() {
		return ord_count;
	}
	public void setOrd_count(int ord_count) {
		this.ord_count = ord_count;
	}
	public Timestamp getOrd_updatedate() {
		return ord_updatedate;
	}
	public void setOrd_updatedate(Timestamp ord_updatedate) {
		this.ord_updatedate = ord_updatedate;
	}
	public Timestamp getState_updatedate() {
		return state_updatedate;
	}
	public void setState_updatedate(Timestamp state_updatedate) {
		this.state_updatedate = state_updatedate;
	}
	public int getReturn_state() {
		return return_state;
	}
	public void setReturn_state(int return_state) {
		this.return_state = return_state;
	}
	public Timestamp getCancel_date() {
		return cancel_date;
	}
	public void setCancel_date(Timestamp cancel_date) {
		this.cancel_date = cancel_date;
	}
	public Timestamp getCancel_updatedate() {
		return cancel_updatedate;
	}
	public void setCancel_updatedate(Timestamp cancel_updatedate) {
		this.cancel_updatedate = cancel_updatedate;
	}
	
	@Override
	public String toString() {
		return "BackupOrderVO [ord_idx=" + ord_idx + ", mem_id=" + mem_id + ", ord_recp_name=" + ord_recp_name
				+ ", ord_recp_zip=" + ord_recp_zip + ", ord_recp_addr=" + ord_recp_addr + ", ord_recp_addr_d="
				+ ord_recp_addr_d + ", ord_recp_tel=" + ord_recp_tel + ", ord_tot_price=" + ord_tot_price
				+ ", ord_date=" + ord_date + ", ord_state=" + ord_state + ", ord_count=" + ord_count
				+ ", ord_updatedate=" + ord_updatedate + ", state_updatedate=" + state_updatedate + ", return_state="
				+ return_state + ", cancel_date=" + cancel_date + ", cancel_updatedate=" + cancel_updatedate + "]";
	}
}
