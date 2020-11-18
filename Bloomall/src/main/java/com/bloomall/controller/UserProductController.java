package com.bloomall.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bloomall.domain.CategoryVO;
import com.bloomall.domain.ProductVO;
import com.bloomall.service.OrderService;
import com.bloomall.service.ReviewService;
import com.bloomall.service.UserProductService;
import com.bloomall.util.Criteria;
import com.bloomall.util.FileUtils;
import com.bloomall.util.PageMaker;
import com.bloomall.util.SearchCriteria;

@Controller
@RequestMapping("/product/*")
public class UserProductController {

	private static final Logger logger = LoggerFactory.getLogger(UserProductController.class);
	
	@Inject
	private UserProductService service;
	
	@Inject
	private OrderService orderService;				// 상품당 리뷰건수 reviewCount(int prd_idx)
	
	@Inject
	private ReviewService reviewService;			// 상품당 주문건수 productSalesCount(int prd_idx)
	
	// 웹 프로젝트 영역 외부에 파일을 저장할 때 사용할 경로
	@Resource(name="uploadPath")
	private String uploadPath;
	
	
	// 저장된 이미지 파일을 가져와 출력
	@ResponseBody
	@RequestMapping(value = "/fileDisplay", method=RequestMethod.GET)
	public ResponseEntity<byte[]> fileDisplay(String fileName) throws Exception{
		
		return FileUtils.getFile(uploadPath, fileName);
	}
	
	
	// 1차 카테고리에 해당하는 2차 카테고리 출력
	@ResponseBody
	@RequestMapping(value = "/subCategory/{ctgr_cd}", method=RequestMethod.GET)
	public ResponseEntity<List<CategoryVO>> subCategoryList(@PathVariable("ctgr_cd") String ctgr_cd){
		
		logger.info("======== subCategoryList() called ========");
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
		try {
			// 2차 카테고리 리스트 & http 상태코드
			entity = new ResponseEntity<List<CategoryVO>>(service.subCategoryList(ctgr_cd), HttpStatus.OK);
		}catch(Exception e) {
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	
	// 상품 리스트 (카테고리 선택 시) => Criteria 파라미터
	@RequestMapping(value = "/list", method=RequestMethod.GET)
	public String productList(@ModelAttribute("cri") Criteria cri, @ModelAttribute("ctgr_cd") String ctgr_cd,
							  @ModelAttribute("prime_ctgr_cd") String prime_ctgr_cd, Model model) throws Exception{
		
		logger.info("======== productList() called ========");
		logger.info(cri.toString());

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cri", cri);
		map.put("ctgr_cd", ctgr_cd);
		
		// 상품 리스트
		List<ProductVO> productList = null;
		
		// 부모 카테고리 이름 - jsp에서 사용
		String prt_name = service.getPrtName(ctgr_cd);
		
		String title = "";
		int count = 0;
		
		if(ctgr_cd.equals("all")) {
			title = "모든 상품";
			productList = service.productListAll(cri);
			count = service.all_countByCtgr();
			
			logger.info("count :"+count);
		}else {
			if(prime_ctgr_cd.equals("")||prime_ctgr_cd == null) {

				// 상품 리스트 - 2차
				productList = service.productList(map);
				count = service.countByCtgr(ctgr_cd);
				title = service.getCtgrName(ctgr_cd);
				
				logger.info("count :"+count);
			}else{
				// 상품 리스트 - 1차 
				productList = service.primeList(cri, prime_ctgr_cd);
				count = service.prime_countByCtgr(prime_ctgr_cd);
				title = service.getCtgrName(prime_ctgr_cd);
				
				logger.info("카테고리명: " + title);
				logger.info("카테고리코드: " + prime_ctgr_cd);
				
				logger.info("count :"+count);
			}
		}
		
		int prd_idx = 0;
		int rvwCount =0;
		ProductVO vo = null;
		List<Double> rvwAverage = new ArrayList<Double>();
		
		// 리스트의 상품당 주문건수/리뷰건수 저장
		for(int i=0; i < productList.size(); i++) {
			
			vo = productList.get(i);
			prd_idx = vo.getPrd_idx();
			
			vo.setRvw_count(reviewService.reviewCount(prd_idx));
			vo.setOrd_amount(orderService.productSalesCount(prd_idx));
			
			rvwCount = vo.getRvw_count();
			
			if(rvwCount > 0) {
				// 리뷰가 있을 때, 해당 상품의 리뷰 평점
				rvwAverage.add(reviewService.rvwAverage(prd_idx));
			}else {
				rvwAverage.add(0.00);
			}
		}
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(count);
		
		model.addAttribute("prt_name", prt_name);
		model.addAttribute("ctgr_name", title);
		model.addAttribute("productList", productList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("rvwAverage", rvwAverage);
		
		return "/product/list";
	}
	
	
	// 상품 리스트 (검색 시) => SearchCriteria 파라미터		listSearch.jsp
	@RequestMapping(value = "/listSearch", method=RequestMethod.GET)
	public String productListSearch(@ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception{
		
		logger.info("======== productListSearch() called ========");
		logger.info(scri.toString());
		
		List<ProductVO> productList = service.productListSearch(scri);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.countBySearch(scri.getKeyword()));
		
		int prd_idx = 0;
		int rvwCount =0;
		ProductVO vo = null;
		List<Double> rvwAverage = new ArrayList<Double>();
		
		// 리스트의 상품당 주문건수/리뷰건수 저장
		for(int i=0; i < productList.size(); i++) {
			
			vo = productList.get(i);
			prd_idx = vo.getPrd_idx();
			
			vo.setOrd_amount(orderService.productSalesCount(prd_idx));
			vo.setRvw_count(reviewService.reviewCount(prd_idx));
			
			rvwCount = vo.getRvw_count();
			
			if(rvwCount > 0) {
				// 리뷰가 있을 때, 해당 상품의 리뷰 평점
				rvwAverage.add(reviewService.rvwAverage(prd_idx));
			}else {
				rvwAverage.add(0.00);
			}
		}
		
		model.addAttribute("productList", productList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("rvwAverage", rvwAverage);
		
		return "product/listSearch";
	}
	
	
	// 상품 상세정보 페이지(카테고리 선택 시) => Criteria 파라미터		detail.jsp
	// 리뷰 정보 포함
	@RequestMapping(value = "/detail", method=RequestMethod.GET)
	public String productDetail(@ModelAttribute("cri") Criteria cri, @RequestParam("prd_idx") int prd_idx,
								@ModelAttribute("ctgr_cd") String ctgr_cd, @ModelAttribute("prime_ctgr_cd") String prime_ctgr_cd,
								Model model) throws Exception{
		
		logger.info("======== productDetail() called ========");
		
		// 선택한 상품의 이미지 정보를 썸네일에서 원본 이미지 정보로 바꿈
		ProductVO vo = service.productDetail(prd_idx);
		vo.setPrd_img(FileUtils.thumbToOriginalName(vo.getPrd_img()));
		
		// 주문건수 / 리뷰건수 
		vo.setOrd_amount(orderService.productSalesCount(prd_idx));
		vo.setRvw_count(reviewService.reviewCount(prd_idx));
		
		logger.info(vo.toString());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		// 1차&2차 카테고리 이름 - jsp에서 사용
		String prt_name = service.getPrtName(vo.getCtgr_cd());
		String ctgr_name = service.getCtgrName(vo.getCtgr_cd());
		
		// 구매가능 여부 표시
		String in_stock = vo.getPrd_in_stock();
		String on_sale = null;
		
		if(in_stock.equals("Y")) {
			on_sale = "판매중";
		}else {
			on_sale = "품절";
		}
		
		int rvwCount = vo.getRvw_count();
		
		double rvwAverage = 0.00;
		
		if(rvwCount > 0) {
			// 리뷰가 있을 때, 해당 상품의 리뷰 평점
			rvwAverage = reviewService.rvwAverage(prd_idx);
		}else {
			rvwAverage = 0.00;
		}
		
		model.addAttribute("on_sale", on_sale);
		model.addAttribute("ctgr_name", ctgr_name);
		model.addAttribute("prt_name", prt_name);
		model.addAttribute("vo", vo);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("rvwAverage", rvwAverage);
		
		return "product/detail";
	}
	
	
	// 상품 상세정보 페이지(검색 시) => SearchCriteria 파라미터		detailSearch.jsp
	// 리뷰 정보 포함
	@RequestMapping(value = "/detailSearch", method=RequestMethod.GET)
	public String productDetailSearch(@ModelAttribute("scri") SearchCriteria scri, @RequestParam("prd_idx") int prd_idx, Model model) throws Exception{
	
		logger.info("======== productDetailSearch() called ========");
		
		// 선택한 상품의 이미지 정보를 썸네일에서 원본 이미지 정보로 바꿈
		ProductVO vo = service.productDetail(prd_idx);
		vo.setPrd_img(FileUtils.thumbToOriginalName(vo.getPrd_img()));
		
		// 주문건수 / 리뷰건수 
		vo.setOrd_amount(orderService.productSalesCount(prd_idx));
		vo.setRvw_count(reviewService.reviewCount(prd_idx));
		
		logger.info(vo.toString());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		
		// 1차&2차 카테고리 이름 - jsp에서 사용
		String prt_name = service.getPrtName(vo.getCtgr_cd());
		String ctgr_name = service.getCtgrName(vo.getCtgr_cd());
		
		// 구매가능 여부 표시
		String in_stock = vo.getPrd_in_stock();
		String on_sale = null;
		
		if(in_stock.equals("Y")) {
			on_sale = "판매중";
		}else {
			on_sale = "품절";
		}
		
		int rvwCount = vo.getRvw_count();
		
		double rvwAverage = 0.00;
		
		if(rvwCount > 0) {
			// 리뷰가 있을 때, 해당 상품의 리뷰 평점
			rvwAverage = reviewService.rvwAverage(prd_idx);
		}else {
			rvwAverage = 0.00;
		}
		
		model.addAttribute("on_sale", on_sale);
		model.addAttribute("ctgr_name", ctgr_name);
		model.addAttribute("prt_name", prt_name);
		model.addAttribute("vo", vo);
		model.addAttribute("pageMaker", pageMaker);
		// 해당 상품의 리뷰 평점
		model.addAttribute("rvwAverage", rvwAverage);
		
		return "product/detailSearch";
	}
	
	
	
}

