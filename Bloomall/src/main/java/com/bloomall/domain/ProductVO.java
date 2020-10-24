package com.bloomall.domain;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class ProductVO {

	/*
    prd_idx             number                  primary key,                            -- 시퀀스
    ctgr_cd             varchar2(20)            not null references category_tb(ctgr_cd),
    ctgr_prt_cd         varchar2(20)            null,            -- 1차 카테고리 코드
    prd_title           varchar2(50)            not null,
    prd_author          varchar2(50)            not null,
    prd_price           number                  not null,
    prd_dc_price        number                  not null,
    prd_company         varchar2(30)            not null,
    prd_detail          varchar2(4000)          not null,    -- CKEditor 사용해서 상품설명 정보(html 태그형식으로 저장)
    prd_img             varchar2(100)           not null,
    prd_amount          number                  not null,
    prd_in_stock        char(1)                 not null,
    prd_regdate         date default sysdate    not null,
    prd_updatedate      date default sysdate    not null
	 */
	
	private int prd_idx;
	private String ctgr_cd;
	private String ctgr_prt_cd;
	private String prd_title;
	private String prd_author;
	private int prd_price;
	private int prd_dc_price;
	private String prd_company;
	private String prd_detail;
	private String prd_img;
	private int prd_amount;
	private String prd_in_stock;
	private Timestamp prd_regdate;
	private Timestamp prd_updatedate;
	
	private MultipartFile file1;

	public int getPrd_idx() {
		return prd_idx;
	}

	public void setPrd_idx(int prd_idx) {
		this.prd_idx = prd_idx;
	}

	public String getCtgr_cd() {
		return ctgr_cd;
	}

	public void setCtgr_cd(String ctgr_cd) {
		this.ctgr_cd = ctgr_cd;
	}

	public String getCtgr_prt_cd() {
		return ctgr_prt_cd;
	}

	public void setCtgr_prt_cd(String ctgr_prt_cd) {
		this.ctgr_prt_cd = ctgr_prt_cd;
	}

	public String getPrd_title() {
		return prd_title;
	}

	public void setPrd_title(String prd_title) {
		this.prd_title = prd_title;
	}

	public String getPrd_author() {
		return prd_author;
	}

	public void setPrd_author(String prd_author) {
		this.prd_author = prd_author;
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

	public String getPrd_company() {
		return prd_company;
	}

	public void setPrd_company(String prd_company) {
		this.prd_company = prd_company;
	}

	public String getPrd_detail() {
		return prd_detail;
	}

	public void setPrd_detail(String prd_detail) {
		this.prd_detail = prd_detail;
	}

	public String getPrd_img() {
		return prd_img;
	}

	public void setPrd_img(String prd_img) {
		this.prd_img = prd_img;
	}

	public int getPrd_amount() {
		return prd_amount;
	}

	public void setPrd_amount(int prd_amount) {
		this.prd_amount = prd_amount;
	}

	public String getPrd_in_stock() {
		return prd_in_stock;
	}

	public void setPrd_in_stock(String prd_in_stock) {
		this.prd_in_stock = prd_in_stock;
	}

	public Timestamp getPrd_regdate() {
		return prd_regdate;
	}

	public void setPrd_regdate(Timestamp prd_regdate) {
		this.prd_regdate = prd_regdate;
	}

	public Timestamp getPrd_updatedate() {
		return prd_updatedate;
	}

	public void setPrd_updatedate(Timestamp prd_updatedate) {
		this.prd_updatedate = prd_updatedate;
	}

	public MultipartFile getFile1() {
		return file1;
	}

	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}

	@Override
	public String toString() {
		return "ProductVO [prd_idx=" + prd_idx + ", ctgr_cd=" + ctgr_cd + ", ctgr_prt_cd=" + ctgr_prt_cd
				+ ", prd_title=" + prd_title + ", prd_author=" + prd_author + ", prd_price=" + prd_price
				+ ", prd_dc_price=" + prd_dc_price + ", prd_company=" + prd_company + ", prd_img=" + prd_img
				+ ", prd_amount=" + prd_amount + ", prd_in_stock=" + prd_in_stock + ", prd_regdate=" + prd_regdate
				+ ", prd_updatedate=" + prd_updatedate + ", file1=" + file1 + "]";
	}

	
}
