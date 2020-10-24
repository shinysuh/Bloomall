package com.bloomall.domain;

import java.sql.Timestamp;

public class ReviewVO {
	/*
	rvw_idx             number                  primary key,                           -- 시퀀스
    mem_id              varchar2(50)            not null references member_tb(mem_id),
    prd_idx             number                  not null references product_tb(prd_idx),
    rvw_content         varchar2(200)           not null,
    rvw_rating          number                  not null,
    rvw_regdate         date default sysdate    not null
	 */

	private int 	rvw_idx;
	private String 	mem_id;
	private int 	prd_idx;
	private String 	rvw_content;
	private int 	rvw_rating;
	private Timestamp rvw_regdate;
	
	public int getRvw_idx() {
		return rvw_idx;
	}
	public void setRvw_idx(int rvw_idx) {
		this.rvw_idx = rvw_idx;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getPrd_idx() {
		return prd_idx;
	}
	public void setPrd_idx(int prd_idx) {
		this.prd_idx = prd_idx;
	}
	public String getRvw_content() {
		return rvw_content;
	}
	public void setRvw_content(String rvw_content) {
		this.rvw_content = rvw_content;
	}
	public int getRvw_rating() {
		return rvw_rating;
	}
	public void setRvw_rating(int rvw_rating) {
		this.rvw_rating = rvw_rating;
	}
	public Timestamp getRvw_regdate() {
		return rvw_regdate;
	}
	public void setRvw_regdate(Timestamp rvw_regdate) {
		this.rvw_regdate = rvw_regdate;
	}
	
	@Override
	public String toString() {
		return "ReviewVO [rvw_idx=" + rvw_idx + ", mem_id=" + mem_id + ", prd_idx=" + prd_idx + ", rvw_content="
				+ rvw_content + ", rvw_rating=" + rvw_rating + ", rvw_regdate=" + rvw_regdate + "]";
	}
	
}
