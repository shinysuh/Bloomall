package com.bloomall.domain;

import java.sql.Timestamp;

public class AdminVO {

	/*
	ad_id           varchar2(20)            primary key,
    ad_pw           varchar2(20)            not null,
    ad_name         varchar2(30)            not null,
    ad_last_visit   date default sysdate    not null 
	 */
	
	private String ad_id;
	private String ad_pw;
	private String ad_name;
	private Timestamp ad_last_visit;
	
	public String getAd_id() {
		return ad_id;
	}
	public void setAd_id(String ad_id) {
		this.ad_id = ad_id;
	}
	public String getAd_pw() {
		return ad_pw;
	}
	public void setAd_pw(String ad_pw) {
		this.ad_pw = ad_pw;
	}
	public String getAd_name() {
		return ad_name;
	}
	public void setAd_name(String ad_name) {
		this.ad_name = ad_name;
	}
	public Timestamp getAd_last_visit() {
		return ad_last_visit;
	}
	public void setAd_last_visit(Timestamp ad_last_visit) {
		this.ad_last_visit = ad_last_visit;
	}
	
	@Override
	public String toString() {
		return "AdminVO [ad_id=" + ad_id + ", ad_pw=" + ad_pw + ", ad_name=" + ad_name + ", ad_last_visit="
				+ ad_last_visit + "]";
	}
	
	
}
