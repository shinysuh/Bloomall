package com.bloomall.domain;

import java.sql.Timestamp;

public class AdminOrderDetailVO {
	/*
		[1번 테이블(상품정보)]
		선택 / 번호 / 상품명 / 수량(수정가능) / 정가 / 판매가격(수정가능) / 소계(가격*수량) / 처리상태 (readonly)(아래에 수정 dropdown)
		[div]
		주문상태 -> 변경		//		(버튼) 이 주문 삭제하기
		[2번 테이블(결제정보)]
		총 주문금액
		총 할인금액
		결제금액 - 쿠폰이나 포인트 사용에 따라 달라질 수 있는 항목
		결제수단
		[3번 테이블(주문자 정보)]	 	/		[4번 테이블(수령자 정보)]
		이름/ID							수령자 이름(수정가능)
		이메일							연락처(ord_recp_tel)(수정가능)
		연락처(user.mem_tel)(수정가능)		주소/우편번호(수정가능)
		주문날짜							상세주소(수정가능)
	 */
	private int ord_idx;			// 주문번호 - OrderVO
	private int ord_state;			// 주문처리상태 - OrderVO
	private String prd_idx;			// 주문 상품번호 - OrderDetailVO
	private String ord_amount;		// 주문 수량 - OrderDetailVO
	private String prd_title;		// 상품명 - ProductVO
	private int prd_price;			// 정가 - ProductVO
	private int prd_dc_price;		// 할인가[판매가격] - ProductVO
	private String mem_id;			// 주문자 아이디 - MemberVO
	private String mem_name;		// 주문자명 - MemberVO
	private String mem_tel;			// 주문자 연락처 - MemberVO
	private String mem_email;		// 주문자 이메일 - MemberVO
	private int ord_tot_price;		// 총 주문 금액 - OrderVO
	private Timestamp ord_date;		// 주문날짜 - OrderVO
	private String ord_recp_name;	// 수령자명 - OrderVO
	private String ord_recp_tel;	// 수령자 연락처 - OrderVO
	private String ord_recp_zip;	// 수령자 우편번호 - OrderVO
	private String ord_recp_addr;	// 수령자 주소 - OrderVO
	private String ord_recp_addr_d;	// 수령자 상세주소 - OrderVO
	
	public int getOrd_idx() {
		return ord_idx;
	}
	public void setOrd_idx(int ord_idx) {
		this.ord_idx = ord_idx;
	}
	public int getOrd_state() {
		return ord_state;
	}
	public void setOrd_state(int ord_state) {
		this.ord_state = ord_state;
	}
	public String getPrd_idx() {
		return prd_idx;
	}
	public void setPrd_idx(String prd_idx) {
		this.prd_idx = prd_idx;
	}
	public String getOrd_amount() {
		return ord_amount;
	}
	public void setOrd_amount(String ord_amount) {
		this.ord_amount = ord_amount;
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
	public String getMem_tel() {
		return mem_tel;
	}
	public void setMem_tel(String mem_tel) {
		this.mem_tel = mem_tel;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
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
	public String getOrd_recp_name() {
		return ord_recp_name;
	}
	public void setOrd_recp_name(String ord_recp_name) {
		this.ord_recp_name = ord_recp_name;
	}
	public String getOrd_recp_tel() {
		return ord_recp_tel;
	}
	public void setOrd_recp_tel(String ord_recp_tel) {
		this.ord_recp_tel = ord_recp_tel;
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
	
	@Override
	public String toString() {
		return "AdminOrderDetailVO [ord_idx=" + ord_idx + ", ord_state=" + ord_state + ", prd_idx=" + prd_idx
				+ ", ord_amount=" + ord_amount + ", prd_title=" + prd_title + ", prd_price=" + prd_price
				+ ", prd_dc_price=" + prd_dc_price + ", mem_id=" + mem_id + ", mem_name=" + mem_name + ", mem_tel="
				+ mem_tel + ", mem_email=" + mem_email + ", ord_tot_price=" + ord_tot_price + ", ord_date=" + ord_date
				+ ", ord_recp_name=" + ord_recp_name + ", ord_recp_tel=" + ord_recp_tel + ", ord_recp_zip="
				+ ord_recp_zip + ", ord_recp_addr=" + ord_recp_addr + ", ord_recp_addr_d=" + ord_recp_addr_d + "]";
	}
}
