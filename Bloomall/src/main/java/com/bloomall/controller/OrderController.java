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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bloomall.domain.OrderDetailVO;
import com.bloomall.domain.OrderHistoryDetailVO;
import com.bloomall.domain.OrderHistoryVO;
import com.bloomall.domain.OrderVO;
import com.bloomall.domain.ProductVO;
import com.bloomall.dto.MemberDTO;
import com.bloomall.service.MemberService;
import com.bloomall.service.OrderService;
import com.bloomall.service.UserProductService;
import com.bloomall.util.Criteria;
import com.bloomall.util.PageMaker;

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
	
	/*
	 * 항목별 서비스에서 가져온 메소드. - 카트 비우기 코드는 서비스에 적용돼 있음
	 * 
	 	[상품상세 리스트]
			상품상세/상품리스트 - orderOne() [단일상품]
			상품리스트 - orderChk() [여러상품(선택상품)]
		
		[카트]
			[단일상품] - orderCartOne() , cartService.emptyCart() 
			[여러상품(선택상품)] - orderCartChk(), cartService.emptyCart() 
			[장바구니전체] - orderCartAll(), cartService.emptyCartAll()  
	 */
	
	// 주문 완료 페이지
	@RequestMapping(value = "/complete", method=RequestMethod.GET)
	public void orderComplete() {
		
	}
	 
	
	// [단일]
	//상품 상세/상품리스트 -> [바로 구매] 단일상품 - 수량만큼
	/* Param : prd_idx, ord_amount, httpsession, model  */
	@RequestMapping(value = "/one", method=RequestMethod.GET)
	public String purchaseOne(@RequestParam int prd_idx, @RequestParam int ord_amount, HttpSession session, Model model) throws Exception{
		
		logger.info("======== purchaseOne() called ========");
		
		// 모델 attribute명 - 카트 메소드 attribute명과 일치시켜 줌
		ProductVO product = productService.productDetail(prd_idx);
		int amount = ord_amount;
		
		// jsp에서 [리스트] or [카트] 상품 구매여부를 구별하기 위한 값 (리스트단일:1 / 카트단일:2)
		int type = 1;
		
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		model.addAttribute("user", memberService.getUserInfo(dto.getMem_id()));
		model.addAttribute("product", product);
		model.addAttribute("amount", amount);
		model.addAttribute("type", type);
		
		return "/order/purchaseOne";
	}
	
	// 구매
	@RequestMapping(value = "/orderOne", method=RequestMethod.POST)
	public String orderOne(OrderVO orderVO, OrderDetailVO detailVO, @RequestParam int mem_point, RedirectAttributes rttr, HttpSession session) throws Exception{
		
		logger.info("======== orderOne() called ========");
		logger.info(orderVO.toString());
		logger.info(detailVO.toString());
		
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		String mem_id = dto.getMem_id();
		
		// 구매 & 주문번호 저장
		int ord_idx = service.orderOne(orderVO, detailVO);
		rttr.addFlashAttribute("ord_idx", ord_idx);

		// 포인트 업데이트
		service.updatePoint(mem_id, mem_point);
		
		return "redirect:/order/complete";
	}
	
	//-------------------------------------------------------------------------------------------
	// [단일]
	// 카트 - [주문하기] 단일상품
	/* Param : prd_idx, ord_amount, httpsession, model  */
	@RequestMapping(value = "/cartOne", method=RequestMethod.GET)
	public String cartOne(@RequestParam int prd_idx, @RequestParam int cart_amount, HttpSession session, Model model) throws Exception{
		
		logger.info("======== cartOne() called ========");
		
		// 모델 attribute명 - 리스트 메소드 attribute명과 일치시켜 줌
		ProductVO product = productService.productDetail(prd_idx);
		int amount = cart_amount;
		
		// jsp에서 [리스트] or [카트] 상품 구매여부를 구별하기 위한 값 (리스트단일:1 / 카트단일:2)
		int type = 2;
		
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		model.addAttribute("user", memberService.getUserInfo(dto.getMem_id()));
		model.addAttribute("product", product);
		model.addAttribute("amount", amount);
		model.addAttribute("type", type);
	
		return "/order/purchaseOne";
	}
	
	// 구매
	@RequestMapping(value = "/orderCartOne", method=RequestMethod.POST)
	public String orderCartOne(OrderVO orderVO, OrderDetailVO detailVO, @RequestParam int mem_point, HttpSession session, RedirectAttributes rttr) throws Exception{
		
		logger.info("======== orderOne() called ========");
		logger.info(orderVO.toString());
		logger.info(detailVO.toString());
		
		// 구매 - 현재 세션의 아이디 파라미터로 가져옴
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		String mem_id = dto.getMem_id();
		
		// 구매 & 주문번호 저장
		int ord_idx = service.orderCartOne(mem_id, orderVO, detailVO);
		rttr.addFlashAttribute("ord_idx", ord_idx);
		
		// 포인트 업데이트
		service.updatePoint(mem_id, mem_point);
		
		return "redirect:/order/complete";
	}
		

	//-------------------------------------------------------------------------------------------
	// [복수]
	// 상품리스트 => [바로구매] 여러 상품	
	/* Param : chkArr[], ord_amount[], httpsession, model  */
	// 체크박스의 value를 인덱스로 주면 for문 안에 if(chkArr.get(i) == prd_idxArr.get(i))로 사용가능
	// https://jetalog.net/20  forEach index 문법
	// 아니면 ajax
	@RequestMapping(value = "/productChk", method=RequestMethod.POST)
	public String productChk(@RequestParam("check") List<Integer> chkArr,
									 @RequestParam("prd_idx") List<Integer> prd_idxArr,
								     @RequestParam("ord_amount") List<Integer> ord_amtArr,
								     HttpSession session, Model model) throws Exception{
		
		logger.info("======== productChk() called ========");
		
		// 모델 attribute명 - 단일상품 메소드 attribute명과 일치시켜 줌
		List<ProductVO> productList = new ArrayList<ProductVO>();
		List<Integer> amountList = new ArrayList<Integer>();
		
		// jsp에서 <form>태그의 action을 구별하기 위한 값 (리스트:1 / 카트선택:2 / 카트전체:3)
		int type = 1;
		
		logger.info("check : " + chkArr);
		logger.info("prd_idx : " + prd_idxArr);
		
		// 상품리스트에서 체크된 값만 선택하여 List 추가
		for(int i=0; i < prd_idxArr.size(); i++) {		// if(chkArr.get(i) == prd_idxArr.get(i))
			for(int j=0; j<chkArr.size();j++) {
				if(chkArr.get(j) == prd_idxArr.get(i)) {
				productList.add(productService.productDetail((int)prd_idxArr.get(i)));
				amountList.add(ord_amtArr.get(i));
				}
			}
		}
		
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		model.addAttribute("user", memberService.getUserInfo(dto.getMem_id()));
		model.addAttribute("productList", productList);
		model.addAttribute("amountList", amountList);
		model.addAttribute("type", type);
		
		return "/order/purchaseMultiple";
	}
	
	// 구매
	@RequestMapping(value = "/orderChk", method=RequestMethod.POST)
	public String orderChk(OrderVO orderVO, List<OrderDetailVO> detailList, @RequestParam int mem_point, RedirectAttributes rttr, HttpSession session) throws Exception{
		
		logger.info("======== orderChk() called ========");
		logger.info(orderVO.toString());
		logger.info("detailList.size() : " + detailList.size());
				
		// 구매 & 주문번호 저장
		int ord_idx = service.orderChk(orderVO, detailList);
		rttr.addFlashAttribute("ord_idx", ord_idx);
		
		// 포인트 업데이트
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		service.updatePoint(dto.getMem_id(), mem_point);
		
		return "redirect:/order/complete";
	}

	//-------------------------------------------------------------------------------------------
	// [복수]
	// 카트 => [선택상품주문] 여러 상품
	/* Param : chkArr[], prd_idxArr[], cart_amtArr[], httpsession, model  */
	@RequestMapping(value = "/cartChk", method=RequestMethod.POST)
	public String cartChk(@RequestParam("cart_idx") List<Integer> cart_idxArr, 
								  @RequestParam("check") List<Integer> chkArr,
								  @RequestParam("prd_idx") List<Integer> prd_idxArr,
								  @RequestParam("cart_amount") List<Integer> cart_amtArr,
								  HttpSession session, Model model) throws Exception{
		
		logger.info("======== cartChk() called ========");
		
		// 모델 attribute명 - 단일상품 메소드 attribute명과 일치시켜 줌
		List<ProductVO> productList = new ArrayList<ProductVO>();
		List<Integer> amountList = new ArrayList<Integer>();
		
		// 카트 목록에서 체크된 값만 선택하여 List 추가
		for(int i=0; i < cart_idxArr.size(); i++) {		// if(chkArr.get(i) == prd_idxArr.get(i))
			for(int j=0; j<chkArr.size();j++) {
				if(chkArr.get(j) == cart_idxArr.get(i)) {
				productList.add(productService.productDetail((int)prd_idxArr.get(i)));
				amountList.add(cart_amtArr.get(i));
				}
			}
		}
		
		// jsp에서 <form>태그의 action을 구별하기 위한 값 (리스트:1 / 카트선택:2 / 카트전체:3)
		int type = 2;
		
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		model.addAttribute("user", memberService.getUserInfo(dto.getMem_id()));
		model.addAttribute("productList", productList);
		model.addAttribute("amountList", amountList);
		model.addAttribute("type", type);

		return "/order/purchaseMultiple";
	}
	
	// 구매
	@RequestMapping(value = "/orderCartChk", method=RequestMethod.POST)
	public String orderCartChk(OrderVO orderVO, List<OrderDetailVO> detailList, @RequestParam int mem_point, HttpSession session, RedirectAttributes rttr) throws Exception{
		
		logger.info("======== orderCartChk() called ========");
		
		// 구매 - 현재 세션의 아이디 파라미터로 가져옴
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		String mem_id = dto.getMem_id();
		
		// 구매 & 주문번호 저장
		int ord_idx = service.orderCartChk(mem_id, orderVO, detailList);
		rttr.addFlashAttribute("ord_idx", ord_idx);
		
		logger.info("ord_idx : " + ord_idx);
		
		// 포인트 업데이트
		service.updatePoint(mem_id, mem_point);
		
		return "redirect:/order/complete";
	}
	
	
	//-------------------------------------------------------------------------------------------
	// 카트 => [전체상품구매] (장바구니 비우기) => jquery에서 체크박스 다 체크되게 해서 넘기기
	/* Param : cart_idxArr[], prd_idxArr[], cart_amtArr[], httpsession, model  */
	@RequestMapping(value = "/cartAll", method=RequestMethod.POST)
	public String cartAll(@RequestParam("cart_idx") List<Integer> cart_idxArr,
								  @RequestParam("prd_idx") List<Integer> prd_idxArr,
								  @RequestParam("cart_amount") List<Integer> cart_amtArr,
								  HttpSession session, Model model) throws Exception{
		
		logger.info("======== cartAll() called ========");
		
		// 모델 attribute명 - 단일상품 메소드 attribute명과 일치시켜 줌
		List<ProductVO> productList = new ArrayList<ProductVO>();
		List<Integer> amountList = new ArrayList<Integer>();
		
		for(int i=0; i < cart_idxArr.size(); i++) {
			productList.add(productService.productDetail((int)prd_idxArr.get(i)));
			amountList.add(cart_amtArr.get(i));
		}
		
		// jsp에서 <form>태그의 action을 구별하기 위한 값 (리스트:1 / 카트선택:2 / 카트전체:3)
		int type = 3;
		
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		model.addAttribute("user", memberService.getUserInfo(dto.getMem_id()));
		model.addAttribute("productList", productList);
		model.addAttribute("amountList", amountList);
		model.addAttribute("type", type);

		return "/order/purchaseMultiple";
	}
	
	// 구매
	@RequestMapping(value = "/orderCartAll", method=RequestMethod.POST)
	public String orderCartAll(OrderVO orderVO, List<OrderDetailVO> detailList, @RequestParam int mem_point, HttpSession session, RedirectAttributes rttr) throws Exception{
		
		logger.info("======== orderCartAll() called ========");
		
		// 구매 - 현재 세션의 아이디 파라미터로 가져옴
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		String mem_id = dto.getMem_id();

		// 구매 & 주문번호 저장
		int ord_idx = service.orderCartAll(mem_id, orderVO, detailList);
		rttr.addFlashAttribute("ord_idx", ord_idx);
		
		logger.info("ord_idx : " + ord_idx);
		
		// 포인트 업데이트
		service.updatePoint(mem_id, mem_point);
		
		return "redirect:/order/complete";
	}
	
	
	//===========================================================================================
	/* 주문관련 페이지s 기능 */
	// 주문 조회 (GET) - 주문 내역 리스트		/order/orderHistory		service.orderHistoryList()
	@RequestMapping(value = "/orderHistory", method=RequestMethod.GET)
	public String orderHistory(@ModelAttribute("cri") Criteria cri, Model model, HttpSession session) throws Exception{
		
		logger.info("======== orderHistory() called ========");

		// map 작업 전에 perPageNum 작업부터 먼저 => 아니면 자꾸 perPageNum 5개로 시작됨
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.getCri().setPerPageNum(10);

		logger.info(cri.toString());

		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		String mem_id = dto.getMem_id();
		pageMaker.setTotalCount(service.orderCount(mem_id));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_id", mem_id);
		map.put("cri", cri);
		
		List<OrderHistoryVO> orderHistory = service.orderHistoryList(map);
		
		model.addAttribute("orderHistory", orderHistory);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/order/orderHistory";
	}
	
	
	
	
	// 주문 상세 조회 (GET) - 주문 내역 상세 페이지		/order/orderDetail		service.orderHistoryDetail() / recipientInfo()
	@RequestMapping(value = "/orderDetail", method=RequestMethod.GET)
	public String orderDetail(@ModelAttribute Criteria cri, int ord_idx, Model model, HttpSession session) throws Exception{
		
		logger.info("======== orderDetail() called ========");
		
		List<OrderHistoryDetailVO> orderDetail = service.orderHistoryDetail(ord_idx);
		OrderVO buyer = service.recipientInfo(ord_idx);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.getCri().setPerPageNum(10);
		
		model.addAttribute("orderDetail", orderDetail);
		model.addAttribute("buyer", buyer);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/order/orderDetail";
	}
	
}































