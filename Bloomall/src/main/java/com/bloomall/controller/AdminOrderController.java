package com.bloomall.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bloomall.domain.AdminOrderListVO;
import com.bloomall.domain.MemberVO;
import com.bloomall.domain.OrderHistoryDetailVO;
import com.bloomall.domain.OrderVO;
import com.bloomall.service.AdminOrderService;
import com.bloomall.service.MemberService;
import com.bloomall.service.OrderService;
import com.bloomall.util.PageMaker;
import com.bloomall.util.SearchCriteria;

@Controller
@RequestMapping("/admin/order/*")
public class AdminOrderController {

	private static final Logger logger = LoggerFactory.getLogger(AdminOrderController.class);
	
	@Inject
	private AdminOrderService service;
	
	@Inject
	private OrderService orderService;		// 주문정보 상세 페이지
	
	@Inject
	private MemberService memberService;	// 주문정보 상세 페이지
	
	// 주문목록 - /admin/order/orderList		- SearchCriteria
	@RequestMapping(value = "/orderList", method=RequestMethod.GET)
	public String orderList(@RequestParam(required=false) String state,
							@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		
		logger.info("======== orderList() called ========");
		
		PageMaker pageMaker = new PageMaker();
		cri.setPerPageNum(20);
		pageMaker.setCri(cri);

		logger.info(cri.toString());
		
		List<String> stateList = new ArrayList<String>();
		
		if(state == null || state == "") {
			stateList.add("noSel");
			logger.info("state1 : " + state);
		}else if(state != null) {
			
			cri.setSearchType("state");
			String[] stateArr = state.split(",");
			
			for(int i =0; i < stateArr.length; i++) {
				stateList.add(stateArr[i]);
			}
			logger.info("state2 : " + state);
		}
		model.addAttribute("stateList", stateList);
		
		// 주문상태 매퍼에서 사용할 거 - mybatis foreach
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cri", cri);
		map.put("stateList", stateList);
		
		logger.info("searchType: " + cri.getSearchType());
		// 주문목록 리스트
		List<AdminOrderListVO> orderList = service.orderList(map);
		
		logger.info("orderList : " + orderList.size());
		
		int count = service.orderTotal(map);
		pageMaker.setTotalCount(count);
		
		logger.info("===========총 주문 개수 : " + count);
		logger.info(pageMaker.toString());
		logger.info("state :" + state);
		
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/admin/order/orderList";
	}
	
	
	
	//==========================================================================================================
	// 주문처리 검색 연습용(입력칸 사용. 체크박스 X)
	@RequestMapping(value = "/orderList_prac", method=RequestMethod.GET)
	public String orderList_prac(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		
		logger.info("======== orderList_prac() called ========");
		
		PageMaker pageMaker = new PageMaker();
		cri.setPerPageNum(20);
		pageMaker.setCri(cri);

		logger.info(cri.toString());
		
		// 주문상태 매퍼에서 사용할 거 - mybatis foreach
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cri", cri);
		
		logger.info("searchType: " + cri.getSearchType());
		// 주문목록 리스트
		List<AdminOrderListVO> orderList = service.orderList(map);
		
		logger.info("orderList : " + orderList.size());
		
		int count = service.orderTotal(map);
		pageMaker.setTotalCount(count);
		
		logger.info("===========총 주문 개수 : " + count);
		logger.info(pageMaker.toString());
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/admin/order/orderList_prac";
	}
	//==========================================================================================================

	
	
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
	public String orderDetail(@RequestParam(required=false) String state, @ModelAttribute("cri") SearchCriteria cri, int ord_idx, Model model) throws Exception{
		
		logger.info("======== orderDetail() called ========");
		logger.info("ord_idx : " + ord_idx);
		logger.info(cri.toString());
		
		// 주문상품 정보
		List<OrderHistoryDetailVO> orderDetail = orderService.orderHistoryDetail(ord_idx);
		// 주문/수령자 정보
		OrderVO order = orderService.recipientInfo(ord_idx);
		// 주문자 정보
		MemberVO member = memberService.getUserInfo(order.getMem_id());
		
		
		List<String> stateList = new ArrayList<String>();
		
		if(state == null || state == "") {
			stateList.add("noSel");
			logger.info("state1 : " + state);
		}else if(state != null) {
			
			cri.setSearchType("state");
			String[] stateArr = state.split(",");
			
			for(int i =0; i < stateArr.length; i++) {
				stateList.add(stateArr[i]);
			}
			logger.info("state2 : " + state);
		}
		model.addAttribute("stateList", stateList);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.getCri().setPerPageNum(20);
		
		model.addAttribute("orderDetail", orderDetail);
		model.addAttribute("order", order);
		model.addAttribute("member", member);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/admin/order/orderDetail";
	}
	
	
	
	// 주문상세정보 페이지 - 수정 POST		/admin/order/updateDetail
	@RequestMapping(value = "/updateDetail", method=RequestMethod.POST)
	public String updateDetail(@RequestParam int ord_idx, @RequestParam int ord_state,
							   @RequestParam("prd_idx") List<Integer> prd_idxArr,
							   @RequestParam("ord_amount") List<Integer> amtArr,
							   @RequestParam(required=false) String state,
							   SearchCriteria cri,
							   RedirectAttributes rttr, OrderVO vo) throws Exception{
		
		logger.info("======== updateDetail() called ========");
		
		logger.info("ord_idx : "+ord_idx);
		logger.info("state : " + state);
		logger.info(vo.toString());
		// 수령자 정보 & 주문상태 업데이트
		service.updateRecipientAndState(vo);
		
		// 주문수량 업데이트 - for문
		for(int i=0; i < amtArr.size(); i++) {
			service.updateAmount(ord_idx, prd_idxArr.get(i), amtArr.get(i));
		}
		
		cri.setPerPageNum(20);
		
		state = state.replace("[", "").replace("]", "");
		
		//state = URLEncoder.encode(state);
		
//		state = URLDecoder.decode(state);
		
		logger.info("state 12: " + state);

		
		rttr.addAttribute("state", state);
		
		rttr.addAttribute("ord_idx", ord_idx);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/order/orderDetail";
	}
	
	
	
	// 주문상세정보 페이지 - 주문 삭제  POST
	@ResponseBody
	@RequestMapping(value = "/deleteOrder", method=RequestMethod.POST)
	public ResponseEntity<String> deleteOrder(@RequestParam("ord_idx") int ord_idx,
											  @RequestParam("mem_id") String mem_id,
											  @RequestParam("mem_point") int mem_point) throws Exception{
		
		logger.info("======== deleteOrder() called ========");
		
		ResponseEntity<String> entity = null;
		
		try {
			service.deleteOrder(ord_idx, mem_id, mem_point);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	// 주문 통계 페이지
	@RequestMapping(value = "/orderStat", method = RequestMethod.GET)
	public String orderStat(String year, String month, Model model) throws Exception{
		
		logger.info("======== orderStat() called ========");
		
		// 현재 달 정보를 기본으로 가져옴
		Timestamp currentDate = new Timestamp(System.currentTimeMillis());
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM");
		String orderDate = format.format(currentDate);	// 현재 날짜를 달까지만 뽑아서 '2020/11' 형태로 저장
		
		logger.info("year1 : " + year + " // month1 : " + month);
		
		if(year == null || year == ""){
			year = orderDate.substring(0,4);
		}else{}

		if(month==null || month == ""){
			month = orderDate.substring(5,7);
		}else{}
		
		logger.info("orderDate : " + orderDate);
		logger.info("year : " + year + " // month : " + month);
		
		// Timestamp 형식으로 지정한 뒤 형변환 
		String dateValue = year + "-" + month + "-01 00:00:00.000";
		
		Timestamp ord_date = Timestamp.valueOf(dateValue);
		
		logger.info("ord_date : " + ord_date);
		
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("stat", service.orderStat(ord_date));
		
		return "/admin/order/orderStat";
	}
	
	
	// 주문통계 페이지 날짜 검색 기능
	@RequestMapping(value = "/statByDate", method=RequestMethod.POST)
	public String statByDate(@RequestParam("year") String year, @RequestParam("month") String month, RedirectAttributes rttr){
		
		
		logger.info("======== statByDate() called ========");
		
		// Timestamp 형식으로 지정한 뒤 형변환 
		String dateValue = year + "-" + month + "-01 00:00:00.000";
		
		Timestamp ord_date = Timestamp.valueOf(dateValue);
		
		logger.info("orderDate : " + ord_date);
		logger.info("year : " + year + " // month : " + month);
		
		//rttr.addAttribute("stat", service.orderStat(ord_date));		// 필요 없음. year랑 month 값만 넘겨주면 됨
		rttr.addAttribute("year", year);
		rttr.addAttribute("month", month);
		
		return "redirect:/admin/order/orderStat";
	}
	
	/*
	// 주문통계 페이지 날짜 검색 기능
	@ResponseBody
	@RequestMapping(value = "/statByDate", method=RequestMethod.POST)
	public ResponseEntity<String> statByDate(@RequestParam("year") String year, @RequestParam("month") String month) throws Exception{
		
		logger.info("======== statByDate() called ========");
		
		ResponseEntity<String> entity = null;
		
		try {
			
			String dateValue = year + "-" + month + "-01 00:00:00.000";
			Timestamp ord_date = Timestamp.valueOf(dateValue);
			
			entity = new ResponseEntity<String>(HttpStatus.OK); 
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
			 */
	
	
	
}































