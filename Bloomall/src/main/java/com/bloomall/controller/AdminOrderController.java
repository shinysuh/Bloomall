package com.bloomall.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bloomall.domain.AdminOrderDetailVO;
import com.bloomall.domain.AdminOrderListVO;
import com.bloomall.domain.OrderVO;
import com.bloomall.service.AdminOrderService;
import com.bloomall.service.OrderService;
import com.bloomall.util.PageMaker;
import com.bloomall.util.SearchCriteria;

@Controller
@RequestMapping("/admin/order/*")
public class AdminOrderController {

	private static final Logger logger = LoggerFactory.getLogger(AdminOrderController.class);
	
	@Inject
	private AdminOrderService service;
	
//	@Inject
//	private OrderService orderService;
	
	// 주문목록 - /admin/order/orderList		- SearchCriteria
	@RequestMapping(value = "/orderList", method=RequestMethod.GET)
	public String orderList(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		
		logger.info("======== orderList() called ========");
		logger.info(cri.toString());
		
		PageMaker pageMaker = new PageMaker();
		cri.setPerPageNum(20);
		pageMaker.setCri(cri);
		
		List<AdminOrderListVO> orderList = service.orderList(cri);
		
		int count = service.orderTotal();
		pageMaker.setTotalCount(count);
		
		logger.info("===========총 주문 개수 : " + count);
		logger.info(pageMaker.toString());
		
		// 주문 당 주문 상품 종류 개수
		List<Integer> productCount = new ArrayList<Integer>();

		for(int i =0; i < orderList.size(); i ++) {
			productCount.add(service.productCount(orderList.get(i).getOrd_idx()));
		}
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("productCount", productCount);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/admin/order/orderList";
	}
	
	
	// 주문처리상태 변경
	@ResponseBody
	@RequestMapping(value = "/updateState", method=RequestMethod.POST)
	public ResponseEntity<String> updateState(@RequestParam int ord_idx, @RequestParam int ord_state, Model model){
		
		logger.info("======== updateState() called ========");
		
		ResponseEntity<String> entity = null;
		
		// ord_state 를 String으로 가져와서 형변환 시켜주기
		
		try {
			service.updateState(ord_idx, ord_state);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// 주문처리상태 [선택] 개별 변경
	@ResponseBody
	@RequestMapping(value = "/updateStateChk", method=RequestMethod.POST)
	public ResponseEntity<String> updateStateChk(@RequestParam("chkArr[]") List<Integer> chkArr,
												 @RequestParam("stateArr[]") List<Integer> stateArr, Model model){
		
		logger.info("======== updateStateChk() called ========");
		
		ResponseEntity<String> entity = null;
		
		logger.info("chkArr :" + chkArr);
		logger.info("stateArr :" + stateArr);
		try {
			int ord_idx = 0;
			int ord_state = 0;
			
			for(int i=0; i < chkArr.size(); i++) {
				ord_idx = chkArr.get(i);
				ord_state = stateArr.get(i);
				
				service.updateState(ord_idx, ord_state);
			}
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// 주문처리상태 [선택] 위에서 한번에 설정 변경
	@ResponseBody
	@RequestMapping(value = "/chk_all", method=RequestMethod.POST)
	public ResponseEntity<String> updateChkAllTogether(@RequestParam("chkArr[]") List<Integer> chkArr,
												 	   @RequestParam int ord_state, Model model){
		
		logger.info("======== updateChkAllTogether() called ========");
		
		ResponseEntity<String> entity = null;
		
		try {
			int ord_idx = 0;
			
			for(int i=0; i < chkArr.size(); i++) {
				ord_idx = chkArr.get(i);
				
				service.updateState(ord_idx, ord_state);
			}
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	// 주문 상세 정보 페이지
	@RequestMapping(value = "/orderDetail", method=RequestMethod.GET)
	public String orderDetail(@ModelAttribute SearchCriteria cri, int ord_idx, Model model) throws Exception{
		
		logger.info("======== orderDetail() called ========");
		logger.info("ord_idx : " + ord_idx);
		
		List<AdminOrderDetailVO> orderDetail = service.orderDetail(ord_idx);
//		OrderVO buyer = orderService.recipientInfo(ord_idx);		// AdminOrderDetailVO 에 주문자 정보도 다 들어있음
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.getCri().setPerPageNum(20);
		
		model.addAttribute("orderDetail", orderDetail);
//		model.addAttribute("buyer", buyer);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/admin/order/orderDetail";
	}
	
	
	
	// 주문상세정보 페이지 - 수정
	
	
	
	// 주문상세정보 페이지 - 주문 삭제
	
	
}































