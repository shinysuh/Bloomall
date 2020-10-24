package com.bloomall.domain;

public class CategoryVO {
	/*
	ctgr_cd             varchar2(20)            primary key,
    ctgr_prt_cd         varchar2(20)            null references category_tb(ctgr_cd),
    ctgr_name           varchar2(50)            not null
	 */

	private String ctgr_cd;
	private String ctgr_prt_cd;
	private String ctgr_name;
	
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
	public String getCtgr_name() {
		return ctgr_name;
	}
	public void setCtgr_name(String ctgr_name) {
		this.ctgr_name = ctgr_name;
	}
	
	@Override
	public String toString() {
		return "CategoryVO [ctgr_cd=" + ctgr_cd + ", ctgr_prt_cd=" + ctgr_prt_cd + ", ctgr_name=" + ctgr_name + "]";
	}
		
}
