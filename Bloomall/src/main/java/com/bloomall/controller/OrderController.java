package com.bloomall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/order/*")
public class OrderController {

	
	
	/* 
	 * 상품 상세 -> 구매 또는 바로 구매 
	 * 
	 * model로 상품리스트, 수량리스트, 구매자 정보 전달
	 */	
	
	public String purchaseNow() throws Exception{
		
		
		
		
		
		return "order/purchase";
	}
	
}
