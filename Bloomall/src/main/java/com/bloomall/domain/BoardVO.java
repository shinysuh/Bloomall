package com.bloomall.domain;

import java.sql.Timestamp;

public class BoardVO {
	/*
	brd_idx         number                  primary key,                           -- 시퀀스
    mem_id          varchar2(50)            not null references member_tb(mem_id),
    brd_title       varchar2(100)           not null,
    brd_content     varchar2(4000)          not null,
    brd_regdate     date default sysdate    not null
	 */

	private int    brd_idx;
	private String mem_id;
	private String brd_title;
	private String brd_content;
	private Timestamp brd_regdate;
	
	public int getBrd_idx() {
		return brd_idx;
	}
	public void setBrd_idx(int brd_idx) {
		this.brd_idx = brd_idx;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getBrd_title() {
		return brd_title;
	}
	public void setBrd_title(String brd_title) {
		this.brd_title = brd_title;
	}
	public String getBrd_content() {
		return brd_content;
	}
	public void setBrd_content(String brd_content) {
		this.brd_content = brd_content;
	}
	public Timestamp getBrd_regdate() {
		return brd_regdate;
	}
	public void setBrd_regdate(Timestamp brd_regdate) {
		this.brd_regdate = brd_regdate;
	}
	
	@Override
	public String toString() {
		return "BoardVO [brd_idx=" + brd_idx + ", mem_id=" + mem_id + ", brd_title=" + brd_title + ", brd_content="
				+ brd_content + ", brd_regdate=" + brd_regdate + "]";
	}
}
