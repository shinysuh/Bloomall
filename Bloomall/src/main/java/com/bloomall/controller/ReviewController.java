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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bloomall.domain.ReviewVO;
import com.bloomall.dto.MemberDTO;
import com.bloomall.service.ReviewService;
import com.bloomall.util.Criteria;
import com.bloomall.util.PageMaker;

@RestController		// @Controller + @ResponseBody
@RequestMapping("/review/*")
public class ReviewController {

	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

	@Inject
	private ReviewService service;

	
	// 상품 리뷰 쓰기
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public void writeRvw(ReviewVO vo, HttpSession session) throws Exception{
		
		logger.info("======== writeRvw() called ========");
		logger.info(vo.toString());
		
		MemberDTO dto = (MemberDTO)session.getAttribute("user");
		logger.info(dto.toString());
		
		service.writeRvw(vo, dto.getMem_id());
		
		logger.info(vo.toString());
		logger.info(dto.toString());
	}
	
	
	// 리뷰 수정
	@RequestMapping(value = "/update", method=RequestMethod.POST)
	public ResponseEntity<String> updateRvw(ReviewVO vo){
		
		logger.info("======== updateRvw() called ========");
		logger.info(vo.toString());
		
		ResponseEntity<String> entity = null;
		
		try {
			service.updateRvw(vo);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	// 리뷰 삭제
	@RequestMapping(value = "/{rvw_idx}", method=RequestMethod.POST)
	public ResponseEntity<String> deleteRvw(@PathVariable("rvw_idx") int rvw_idx){
		
		logger.info("======== deleteRvw() called ========");
		logger.info("rvw_idx:" + rvw_idx);
		
		ResponseEntity<String> entity = null;
		
		try {
			service.deleteRvw(rvw_idx);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}catch(Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	// 리뷰 리스트(페이징 정보 포함)
	@RequestMapping(value = "{prd_idx}/{page}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> rvwList(@PathVariable("prd_idx") int prd_idx,
													   @PathVariable("page") int page) {
		
		logger.info("======== rvwList() called ========");
		
		ResponseEntity<Map<String, Object>> entity = null;
		
		try {
			Criteria cri = new Criteria();
			cri.setPage(page);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("prd_idx", prd_idx);
			map.put("cri", cri);
			
			List<ReviewVO> rvwList = service.rvwList(map);
			
			// map에 후기 목록(페이징 포함) 추가
			map.put("rvwList", rvwList);
			
			// 총 후기 개수
			pageMaker.setTotalCount(service.reviewCount(prd_idx));
			
			// map에 하단 페이징 작업 추가
			map.put("pageMaker", pageMaker);
			
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
}
