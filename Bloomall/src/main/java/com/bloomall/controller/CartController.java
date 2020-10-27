package com.bloomall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bloomall.domain.CartVO;
import com.bloomall.domain.UserCartListVO;
import com.bloomall.dto.MemberDTO;
import com.bloomall.service.CartService;

@Controller		// @RestController 사용 가능 컨트롤러
@RequestMapping("/cart/*")
public class CartController {
	
	private static final Logger logger = LoggerFactory.getLogger(CartController.class);

	@Inject
	private CartService service;
	
	
	// 장바구니에 추가 - 상품 1개/수량 무관
	@ResponseBody
	@RequestMapping(value = "/add", method=RequestMethod.POST)
	public ResponseEntity<String> addToCart(int prd_idx, int cart_amount, HttpSession session){
		
		logger.info("======== addToCart() called ========");
		logger.info("======prd_idx : " + prd_idx);
		
		ResponseEntity<String> entity = null;
		
		CartVO vo = new CartVO();
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		vo.setMem_id(dto.getMem_id());
		vo.setPrd_idx(prd_idx);
		vo.setCart_amount(cart_amount);
		
		logger.info(vo.toString());
		
		try {
			service.addToCart(vo);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	// 선택 상품 장바구니에 추가 => 각각 선택 수량만큼
	@ResponseBody
	@RequestMapping(value = "/addchk", method=RequestMethod.POST)
	public ResponseEntity<String> addChecked(@RequestParam("chkArr[]") List<Integer> chkArr,
											 @RequestParam("amtArr[]") List<Integer> amtArr,
											 HttpSession session){
		
		logger.info("======== addChecked() called ========");
		
		ResponseEntity<String> entity = null;
		
		try {
			CartVO vo = new CartVO();
			MemberDTO dto = (MemberDTO) session.getAttribute("user");
			vo.setMem_id(dto.getMem_id());
			
			for(int i=0; i < chkArr.size(); i++) {
				vo.setPrd_idx(chkArr.get(i));
				vo.setCart_amount(amtArr.get(i));
				service.addToCart(vo);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	
	// 장바구니 목록
	@RequestMapping(value = "/list", method=RequestMethod.GET)
	public String cartList(HttpSession session, Model model) throws Exception{
		
		logger.info("======== cartList() called ========");
		
		// 로그인 정보 가져오기
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		
		// 회원의 카트 목록 가져오기
		List<UserCartListVO> cartList = service.cartList(dto.getMem_id());
		
		// 모델 저장
		model.addAttribute("cartList", cartList);
	
		return "/cart/list";
	}
	
	
	// 장바구니 수량 수정
	@ResponseBody
	@RequestMapping(value = "/update", method=RequestMethod.POST)
	public ResponseEntity<String> updateCart(CartVO vo){
		
		logger.info("======== updateCart() called ========");
		
		ResponseEntity<String> entity = null;
		
		try {
			service.updateCart(vo);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	// 장바구니 전체 삭제
	@ResponseBody
	@RequestMapping(value = "/empty", method=RequestMethod.POST)
	public ResponseEntity<String> emptyCart(int cart_idx){
		
		logger.info("======== emptyCart() called ========");
		logger.info("=====cart_idx : " + cart_idx);
		
		ResponseEntity<String> entity = null;
		
		try {
			service.deleteCart(cart_idx);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	
	// 장바구니 선택 삭제 - 배열[] 전송
	@ResponseBody
	@RequestMapping(value = "/deleteChk", method=RequestMethod.POST)
	public ResponseEntity<String> deleteCartChked(@RequestParam("chkArr[]") List<Integer> chkArr){
		
		logger.info("======== deleteCartChked() called ========");
		
		ResponseEntity<String> entity = null;
		
		try {
			for(int cart_idx: chkArr) {
				service.deleteCart(cart_idx);
			}
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}






























