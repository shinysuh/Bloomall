package com.bloomall.domain;

import java.sql.Timestamp;

public class CancelledListVO {
	/*	취소/반품 내역 리스트 VO
	 *  >> 주문백업 테이블과 조인
	 *  select ord_idx, prd_title, ord_price, ord_tot_price, ord_amount, mem_id, ord_recp_name, ord_date, return_state, cancel_date
		from (select o.ord_idx, p.prd_title, d.ord_price, o.ord_tot_price, d.ord_amount, o.mem_id, o.ord_recp_name, o.ord_date, return_state, cancel_date,
             row_number() over(order by o.ord_idx desc) o_seq
		        from backup_ord_tb o inner join backup_o_detail_tb d
		            on o.ord_idx = d.ord_idx
		        inner join product_tb p
		            on p.prd_idx = d.prd_idx
		        where mem_id=#{mem_id}
		        order by o.ord_idx desc, d.prd_idx desc
		        )
		where o_seq between #{cri.rowStart} and #{cri.rowEnd}
	 */
	
	private int 	ord_idx;		// 주문번호 - BackupOrderVO
	private String 	prd_title; 		// 주문내역(주문 상품명)  - ProductVO
	private int 	ord_price;    	// 상품 판매시 가격 - BackupOrderVO
	private int 	ord_tot_price;  // 총 주문금액 - BackupOrderVO
	private int 	ord_amount;  	// 각 주문수량 - BackupOrderDetailVO
	private String 	mem_id;			// 주문자 - BackupOrderVO
	private String 	ord_recp_name; 	// 수령자 - BackupOrderVO
	private Timestamp ord_date;		// 주문 날짜 - BackupOrderVO
	private int 	return_state;	// 취소/반품 처리 현황 - BackupOrderVO
	private Timestamp cancel_date;	// 취소/반품 접수 날짜 - BackupOrderVO
	
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
	public int getOrd_price() {
		return ord_price;
	}
	public void setOrd_price(int ord_price) {
		this.ord_price = ord_price;
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
	
	@Override
	public String toString() {
		return "CancelledListVO [ord_idx=" + ord_idx + ", prd_title=" + prd_title + ", ord_price=" + ord_price
				+ ", ord_tot_price=" + ord_tot_price + ", ord_amount=" + ord_amount + ", mem_id=" + mem_id
				+ ", ord_recp_name=" + ord_recp_name + ", ord_date=" + ord_date + ", return_state=" + return_state
				+ ", cancel_date=" + cancel_date + "]";
	}
}
