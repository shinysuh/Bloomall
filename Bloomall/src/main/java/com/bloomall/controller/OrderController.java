package com.bloomall.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bloomall.domain.OrderDetailVO;
import com.bloomall.domain.OrderHistoryDetailVO;
import com.bloomall.domain.OrderHistoryVO;
import com.bloomall.domain.OrderVO;
import com.bloomall.domain.ProductVO;
import com.bloomall.dto.MemberDTO;
import com.bloomall.service.CartService;
import com.bloomall.service.MemberService;
import com.bloomall.service.OrderService;
import com.bloomall.service.UserProductService;

@Controller
@RequestMapping("/order/*")
public class OrderController {

	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

	@Inject
	private OrderService service;
	
	@Inject
	private UserProductService productService;
	
	@Inject
	private MemberService memberService;
	
	@Inject
	private CartService cartService;	// 장바구니 주문 후, 장바구니 비우기 기능
	
	/*
	 	[단일상품]
			상품상세/상품리스트 - puchaseOne()
			카트 - purchaseOne() , cartService.emptyCart()
		
		[여러상품(선택상품)]
			상품리스트 - purchaseMultiple()
			카트 - purchaseMultiple(), cartService.emptyCart()	
		
		[장바구니전체]
			purchaseMultiple(), cartService.emptyCartAll()
		
		
			* DB 작업에서 장바구니 물건삭제 코드 사용
			>> DB 작업코드 1 (상품상세/상품리스트)
			>> DB 작업코드 2 (카트-단일/선택)
			>> DB 작업코드 3 (카트 전체)
	 */
	 
	
	// [단일]
	//상품 상세/상품리스트 -> [바로 구매] 단일상품 - 수량만큼
	/* Param : prd_idx, ord_amount, httpsession, model  */
	@RequestMapping(value = "/one", method=RequestMethod.GET)
	public String purchaseOne(@RequestParam int prd_idx, @RequestParam int ord_amount, HttpSession session, Model model) throws Exception{
		
		logger.info("======== purchaseOne() called ========");
		
		// 모델 attribute명 - 여러상품 메소드 attribute명과 일치시켜 줌
		ProductVO productList = productService.productDetail(prd_idx);
		int amountList = ord_amount;
		
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		model.addAttribute("user", memberService.getUserInfo(dto.getMem_id()));
		
		model.addAttribute("productList", productList);
		model.addAttribute("amountList", amountList);
		
		return "/order/purchase";
	}
	
	// 구매
	@RequestMapping(value = "/orderOne", method=RequestMethod.POST)
	public String orderOne(OrderVO orderVO, OrderDetailVO detailVO) throws Exception{
		
		logger.info("======== orderOne() called ========");
		logger.info(orderVO.toString());
		logger.info(detailVO.toString());

		// 구매
		service.purchaseOne(orderVO, detailVO);
		
		return "/order/complete";
	}
	
	//-------------------------------------------------------------------------------------------
	// [단일]
	// 카트 - [주문하기] 단일상품
	/* Param : prd_idx, ord_amount, httpsession, model  */
	@RequestMapping(value = "/cartOne", method=RequestMethod.GET)
	public String cartOne(@RequestParam int prd_idx, @RequestParam int cart_amount, HttpSession session, Model model) throws Exception{
		
		logger.info("======== cartOne() called ========");
		
		// 모델 attribute명 - 여러상품 메소드 attribute명과 일치시켜 줌
		ProductVO productList = productService.productDetail(prd_idx);
		int amountList = cart_amount;
		
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		model.addAttribute("user", memberService.getUserInfo(dto.getMem_id()));

		model.addAttribute("productList", productList);
		model.addAttribute("amountList", amountList);
	
		return "/order/purchaseCart";
	}
	
	// 구매
	@RequestMapping(value = "/orderCartOne", method=RequestMethod.POST)
	public String orderCartOne(OrderVO orderVO, OrderDetailVO detailVO, HttpSession session) throws Exception{
		
		logger.info("======== orderOne() called ========");
		logger.info(orderVO.toString());
		logger.info(detailVO.toString());
		
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prd_idx", detailVO.getPrd_idx());
		map.put("mem_id", dto.getMem_id());
		
		// 구매
		service.purchaseOne(orderVO, detailVO);
		// 해당 상품 카트에서 삭제
		cartService.emptyCart(map);
		
		return "/order/complete";
	}
	
	//-------------------------------------------------------------------------------------------
	// [복수]
	// 상품리스트 => [바로구매] 여러 상품	
	/* Param : chkArr[], prd_idxArr[], ord_amount[], httpsession, model  */
	@RequestMapping(value = "/productChk", method=RequestMethod.GET)
	public String productChk(@RequestParam("chkArr[]") List<Integer> chkArr,
								     @RequestParam("prd_idxArr[]") List<Integer> prd_idxArr,
								     @RequestParam("ord_amount[]") List<Integer> ord_amount,
								     HttpSession session, Model model) throws Exception{
		
		logger.info("======== productChk() called ========");
		
		// 모델 attribute명 - 단일상품 메소드 attribute명과 일치시켜 줌
		List<ProductVO> productList = new ArrayList<ProductVO>();
		List<Integer> amountList = new ArrayList<Integer>();
		
		// 상품리스트에서 체크된 값만 선택하여 List 추가
		for(int i=0; i < chkArr.size(); i++) {
			productList.add(productService.productDetail((int)prd_idxArr.get(i)));
			amountList.add(ord_amount.get(i));
		}
		
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		model.addAttribute("user", memberService.getUserInfo(dto.getMem_id()));
		model.addAttribute("productList", productList);
		model.addAttribute("amountList", amountList);
		
		return "/order/purchase";
	}
	
	// 구매
	@RequestMapping(value = "/orderChk", method=RequestMethod.POST)
	public String orderChk(OrderVO orderVO, List<OrderDetailVO> detailList) throws Exception{
		
		logger.info("======== orderChk() called ========");
		logger.info(orderVO.toString());
				
		// 구매
		service.purachseMultiple(orderVO, detailList);
		
		return "/order/complete";
	}
	
	//-------------------------------------------------------------------------------------------
	// [복수]
	// 카트 => [선택상품주문] 여러 상품
	/* Param : chkArr[], prd_idxArr[], cart_amtArr[], cart_codeArr[],  httpsession, model  */
	@RequestMapping(value = "/cartChk", method=RequestMethod.GET)
	public String cartChk(@RequestParam("chkArr[]") List<Integer> chkArr,
								  @RequestParam("prd_idxArr[]") List<Integer> prd_idxArr,
								  @RequestParam("cart_amtArr[]") List<Integer> cart_amtArr,
								  HttpSession session, Model model) throws Exception{
		
		logger.info("======== cartChk() called ========");
		
		// 모델 attribute명 - 단일상품 메소드 attribute명과 일치시켜 줌
		List<ProductVO> productList = new ArrayList<ProductVO>();
		List<Integer> amountList = new ArrayList<Integer>();
		
		// 카트 목록에서 체크된 값만 선택하여 List 추가
		for(int i=0; i < chkArr.size(); i++) {
			productList.add(productService.productDetail((int)prd_idxArr.get(i)));
			amountList.add(cart_amtArr.get(i));
		}
		
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		model.addAttribute("user", memberService.getUserInfo(dto.getMem_id()));
		model.addAttribute("productList", productList);
		model.addAttribute("amountList", amountList);

		return "/order/purchaseCart";
	}
	
	// 구매
	@RequestMapping(value = "/orderCartChk", method=RequestMethod.POST)
	public String orderCartChk(OrderVO orderVO, List<OrderDetailVO> detailList, HttpSession session) throws Exception{
		
		logger.info("======== orderCartChk() called ========");
		
		// 구매
		service.purachseMultiple(orderVO, detailList);
		
		// 주문완료 상품 장바구니에서 삭제 작업
		Map<String, Object> map = new HashMap<String, Object>();
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		map.put("mem_id", dto.getMem_id());
		
		for(int i=0; i < detailList.size(); i++) {
			
			OrderDetailVO detailVO = new OrderDetailVO();
			
			map.put("prd_idx", detailVO.getPrd_idx());
			// 주문 상품 장바구니에서 삭제
			cartService.emptyCart(map);
		}
		return "/order/complete";
	}
	
	
	//-------------------------------------------------------------------------------------------
	// 카트 => [전체상품구매] (장바구니 비우기) => jquery에서 체크박스 다 체크되게 해서 넘기기
	/* Param : mem_id, prd_idxArr[], cart_amtArr[], cart_codeArr[], httpsession, model  */
	@RequestMapping(value = "/cartAll", method=RequestMethod.GET)
	public String cartAll(

			
			
								  HttpSession session, Model model) throws Exception{
		
		logger.info("======== cartAll() called ========");
		
		
		
		
		
		
		return "/order/purchaseCart";
	}
	
	// 구매
	@RequestMapping(value = "/orderCartAll", method=RequestMethod.POST)
	public String orderCartAll(OrderVO orderVO, List<OrderDetailVO> detailList, HttpSession session) throws Exception{
		
		logger.info("======== orderCartAll() called ========");
		
		// 구매
		service.purachseMultiple(orderVO, detailList);

		// 장바구니 비우기
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		cartService.emptyCartAll(dto.getMem_id());
	
		return "/order/complete";
	}
	
	
	//===========================================================================================
	/* 주문관련 페이지s 기능 */
	// 주문 조회 (GET) - 주문 내역 리스트		/order/orderHistory		service.orderHistoryList()
	@RequestMapping(value = "/orderHistory", method=RequestMethod.GET)
	public String orderHistory(Model model, HttpSession session) throws Exception{
		
		logger.info("======== orderHistory() called ========");
		
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		List<OrderHistoryVO> orderHistory = service.orderHistoryList(dto.getMem_id());
		
		model.addAttribute("orderHistory", orderHistory);
		
		return "/order/orderHistory";
	}
	
	
	
	
	// 주문 상세 조회 (GET) - 주문 내역 상세 페이지		/order/orderDetail		service.orderHistoryDetail() / recipientInfo()
	@RequestMapping(value = "/orderDetail", method=RequestMethod.GET)
	public String orderDetail(int ord_idx, Model model, HttpSession session) throws Exception{
		
		logger.info("======== orderDetail() called ========");
		
		List<OrderHistoryDetailVO> orderDetail = service.orderHistoryDetail(ord_idx);
		OrderVO buyer = service.recipientInfo(ord_idx);
		
		model.addAttribute("orderDetail", orderDetail);
		model.addAttribute("buyer", buyer);
		
		return "/order/orderDetail";
	}
	
}































