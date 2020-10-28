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
	
	/* 상품리스트 */
	// 상품 리스트 - 바로 구매 단일상품

	
	
	// 상품 리스트 - 바로 구매 선택 상품 각각 입력 수량만큼
	
	
	
	/* 카트 */
	// 카트 - [주문하기] 단일상품

	
	
	// 카트 - 선택 상품 구매 / [전체상품 주문하기] => jquery에서 체크박스 다 체크되게 해서 넘기기
	
	
	
	
	
	
	/* 주문관련 페이지s 기능 */
	// 주문 조회 (GET) - 주문 내역 리스트
	
	
	
	
	
	// 주문 상세 조회 (GET) - 주문 내역 상세 페이지
	
	
	
	
	
	
	
	
	
	
	
	
}































