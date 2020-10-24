package com.bloomall.util;

public class Criteria {

	private int page;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 5;
	}
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
		}
		this.page = page;
	}
	public int getPerPageNum() {
		return perPageNum;
	}
	public void setPerPageNum(int perPageNum) {
		if(perPageNum <= 0) {
			perPageNum = 5;
		}
		this.perPageNum = perPageNum;
	}
	public int getRowStart() {
		return ((page - 1) * perPageNum) + 1;
	}
	public int getRowEnd() {
		return getRowStart() + perPageNum - 1;
	}
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", getRowStart()=" + getRowStart()
				+ ", getRowEnd()=" + getRowEnd() + "]";
	}
	
	
}
