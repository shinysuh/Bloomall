package com.bloomall.domain;

import java.util.List;

public class OrderDetailListVO {

	private List<OrderDetailVO> orderDetailList;

	public List<OrderDetailVO> getOrderDetailList() {
		return orderDetailList;
	}

	public void setOrderDetailList(List<OrderDetailVO> orderDetailList) {
		this.orderDetailList = orderDetailList;
	}

	@Override
	public String toString() {
		return "OrderDetailListVO [orderDetailList=" + orderDetailList + "]";
	}
	
	
}
