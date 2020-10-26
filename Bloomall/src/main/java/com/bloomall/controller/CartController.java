package com.bloomall.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bloomall.service.CartService;

@Controller
@RequestMapping("/cart/*")
public class CartController {
	
	private static final Logger logger = LoggerFactory.getLogger(CartController.class);

	@Inject
	private CartService service;
	
	
	// 장바구니에 추가 - 상품 1개/수량 1개
	
	
	
	// 장바구니에 추가 - 상품 1개/수량 여러개
	
	
	
	
	
	
	// 장바구니 전체 삭제
	
	
	
	// 장바구니 선택 삭제
	
	
	
	
	
	
	

}
