package com.bloomall.domain;

// 데이터 시각화 차트용 VO
public class StatChartVO {
	/*
		-- 1차 카테고리 별 매출
		select p.ctgr_prt_cd primary_cd, sum(d.ord_amount * d.ord_price) sales_p
		from product_tb p, ord_detail_tb d
		where p.prd_idx=d.prd_idx
		group by p.ctgr_prt_cd
		order by p.ctgr_prt_cd
		
		-- 2차 카테고리 별 매출
		select c.ctgr_name c_group, sum(sales) sales_s
		from category_tb c
		inner join (select p.ctgr_cd secondary_cd, sum(d.ord_amount * d.ord_price) sales
		            from product_tb p, ord_detail_tb d
		            where p.prd_idx=d.prd_idx
		            group by p.ctgr_cd) a
		on c.ctgr_cd = a.secondary_cd
		group by c.ctgr_name
	 */
	
	private String primary_cd;		// 1차 카테고리별 
	private int sales_p;			// 1차별 매출 통계
	private String c_group;			// 2차 카테고리별
	private int sales_s;			// 2차별 매출 통계
	
	public String getPrimary_cd() {
		return primary_cd;
	}
	public void setPrimary_cd(String primary_cd) {
		this.primary_cd = primary_cd;
	}
	public int getSales_p() {
		return sales_p;
	}
	public void setSales_p(int sales_p) {
		this.sales_p = sales_p;
	}
	public String getC_group() {
		return c_group;
	}
	public void setC_group(String c_group) {
		this.c_group = c_group;
	}
	public int getSales_s() {
		return sales_s;
	}
	public void setSales_s(int sales_s) {
		this.sales_s = sales_s;
	}
	
	@Override
	public String toString() {
		return "StatChartVO [primary_cd=" + primary_cd + ", sales_p=" + sales_p + ", c_group=" + c_group + ", sales_s="
				+ sales_s + "]";
	}
	
}
