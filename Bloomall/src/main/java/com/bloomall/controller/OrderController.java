package com.bloomall.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bloomall.service.OrderService;

@Controller
@RequestMapping("/order/*")
public class OrderController {

	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

	@Inject
	private OrderService service;
	
	/* 
	 * 상품 상세 -> 구매 또는 바로 구매 
	 * 
	 * model로 상품리스트, 수량리스트, 구매자 정보 전달
	 */	
	
	
	public String purchaseNow() throws Exception{
		
		logger.info("======== purchaseNow() called ========");
		
		
		
		
		
		
		
		
		return "order/purchase";
	}
	
}
