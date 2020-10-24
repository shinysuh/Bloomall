package com.bloomall.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bloomall.domain.CategoryVO;
import com.bloomall.service.CategoryService;
import com.bloomall.util.PageMaker;
import com.bloomall.util.SearchCriteria;

@Controller
@RequestMapping("/admin/category/*")
public class CategoryController {

	private static final Logger logger = LoggerFactory.getLogger(CategoryController.class);

	@Inject
	private CategoryService service;
	
	// 카테고리 등록 (GET)
	@RequestMapping(value = "/register", method=RequestMethod.GET)
	public void register() {
		
	}
	
	// 카테고리 등록 (POST)
	@RequestMapping(value = "/registerOk", method=RequestMethod.POST)
	public String register(CategoryVO vo, RedirectAttributes rttr) throws Exception {
		
		logger.info(vo.toString());
		
		service.register(vo);
		rttr.addFlashAttribute("msg", "CTGR_REGISTER_SUCCESS");
		
		return "redirect:/admin/category/manage";
	}
	
	// 카테고리 관리 페이지(리스트)
	@RequestMapping(value = "/manage", method=RequestMethod.GET)
	public String ctgrManage(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

		logger.info("======== confirmID() called ========");
		
		List<CategoryVO> ctgrList = service.ctgrList(cri);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		int count = service.ctgrTotalCount(cri);
		pageMaker.setTotalCount(count);
		
		logger.info("===== 일치하는 카테고리 개수 : " + count);
		
		model.addAttribute("ctgrList", ctgrList);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/admin/category/manage";
	}
	
	// 카테고리 수정 (GET)
	@RequestMapping(value = "/update", method=RequestMethod.GET)
	public void ctgrUpdate() {
		
	}
	
	// 카테고리 수정
	@RequestMapping(value = "/updateOk", method=RequestMethod.POST)
	public String ctgrUpdateOk(@ModelAttribute("vo") CategoryVO vo, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		
		logger.info("======== ctgrUpdateOk() called ========");
		logger.info("=====기존 카테고리 정보 : " + vo.toString());
		logger.info(cri.toString());
		
		service.ctgrUpdate(vo);
		logger.info("=====변경된 카테고리 정보 : " + vo.toString());

		rttr.addFlashAttribute("cri", cri);
		rttr.addFlashAttribute("msg", "CTGR_UPDATE_SUCCESS");
		
		return "redirect:/admin/category/manage";
	}
	
	
	// 카테고리 삭제
	@RequestMapping(value = "/delete", method=RequestMethod.POST)
	public String ctgrDelete(@RequestParam("ctgr_cd") String ctgr_cd, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		
		logger.info("======== ctgrDelete() called ========");
		
		service.ctgrDelete(ctgr_cd);
		
		rttr.addFlashAttribute("cri", cri);
		rttr.addFlashAttribute("msg", "CTGR_DELETE_SUCCESS");
		
		return "redirect:/admin/category/manage";
	}
}
