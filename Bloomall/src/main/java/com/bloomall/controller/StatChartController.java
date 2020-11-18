package com.bloomall.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bloomall.service.StatChartService;

@Controller
@RequestMapping(value = "/admin/chart/*")
public class StatChartController {

	private static final Logger logger = LoggerFactory.getLogger(StatChartController.class);

	@Inject
	private StatChartService service;

	
	// 통계 차트 페이지 GET
	@RequestMapping(value = "/orderChart", method = RequestMethod.GET)
	public String chart() throws Exception{
		
		
		
		
		return "/admin/chart/orderChart";
	} 
	
	
}
