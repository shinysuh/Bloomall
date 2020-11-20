package com.bloomall.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bloomall.domain.StatChartVO;
import com.bloomall.service.StatChartService;

@Controller
@RequestMapping(value = "/admin/chart/*")
public class StatChartController {

	private static final Logger logger = LoggerFactory.getLogger(StatChartController.class);

	@Inject
	private StatChartService service;

	
	// (전체)통계 차트 페이지 GET
	@RequestMapping(value = "/overall", method = RequestMethod.GET)
	public ModelAndView overallChart() throws Exception{
		
		logger.info("======== overallChart() called ========");
		
		ModelAndView mv = new ModelAndView();
		
		// 1차 카테고리 데이터
		List<StatChartVO> prime_list = service.primaryChart();
		
		String str_p = "[['1차 카테고리', '매출'], ";
		
		int i = 0;
		
		for(StatChartVO vo : prime_list) {
			
			str_p += "['" + vo.getPrimary_cd() + "', " + vo.getSales_p() + "]";
			
			i++;
			
			if(i < prime_list.size()) {
				str_p += ",";
			}
		}
		
		str_p += "]";
		//------------------------------------------------------------------------------------
		// 2차 카테고리 데이터
		List<StatChartVO> second_list = service.secondaryChart();
		
		String str_s = "[['2차 카테고리', '매출'], ";
		
		int j = 0;
		
		for(StatChartVO vo : second_list) {
			
			str_s += "['" + vo.getSecondary_cd() + "', " + vo.getSales_s() + "]";
			
			j++;
			
			if(j < second_list.size()) {
				str_s += ",";
			}
		}
		
		str_s += "]";
		
		//------------------------------------------------------------------------------------
		// 연도별 총매출
		List<StatChartVO> year_list = service.yearlySales();
		
		String str_y = "[['연도', '총매출'], ";
		
		int k = 0;
		
		for(StatChartVO vo : year_list) {
			
			str_y += "['" + vo.getYear() + "', " + vo.getTotal() + "]";
			
			k++;
			
			if(k < year_list.size()) {
				str_y += ",";
			}
		}
		
		str_y += "]";
		
		
		//------------------------------------------------------------------------------------
		mv.addObject("prime_list", prime_list);
		mv.addObject("second_list", second_list);
		mv.addObject("year_list", year_list);
		mv.addObject("str_p", str_p);
		mv.addObject("str_s", str_s);
		mv.addObject("str_y", str_y);
		mv.setViewName("/admin/chart/overall");
		
		logger.info(str_p);
		logger.info(str_s);
		logger.info(str_y);
		
		return mv;
	} 
	
	
	// (월별)통계 차트 페이지 GET
	@RequestMapping(value = "/monthlyOrder")
	public ModelAndView monthlyOrderChart(String year, String month, Model model) throws Exception{
		
		logger.info("======== monthlyOrderChart() called ========");
	
		ModelAndView mv = new ModelAndView();
		
		// 현재 달 정보를 기본으로 가져오기
		Timestamp currentDate = new Timestamp(System.currentTimeMillis());
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM");
		String targetDate = format.format(currentDate);
	
		if(year == null || year == "") {
			year = targetDate.substring(0, 4); 
		}else {}
		
		if(month == null || month == "") {
			month = targetDate.substring(5,7);
		}else {}
		
		logger.info("targetDate : " + targetDate);
		logger.info("year : " + year + "// month : " + month);
		
		// Timestamp 형식으로 지정한뒤 형변환
		String dateValue = year + "-" + month + "-01 00:00:00.000";
		
		Timestamp ord_date = Timestamp.valueOf(dateValue);
		
		//------------------------------------------------------------------------------------
		// 1차 카테고리 데이터
		List<StatChartVO> prime_list = service.primaryChartByMonth(ord_date);
		
		String str_p = "[['1차 카테고리', '매출'], ";
		
		int i = 0;
		
		for(StatChartVO vo : prime_list) {
			
			str_p += "['" + vo.getPrimary_cd() + "', " + vo.getSales_p() + "]";
			
			i++;
			
			if(i < prime_list.size()) {
				str_p += ",";
			}
		}
		
		str_p += "]";
		
		//------------------------------------------------------------------------------------
		// 2차 카테고리 데이터
		List<StatChartVO> second_list = service.secondaryChartByMonth(ord_date);
		
		
		String str_s = "[['2차 카테고리', '매출'], ";
		
		int j = 0;
		
		for(StatChartVO vo : second_list) {
			
			str_s += "['" + vo.getSecondary_cd() + "', " + vo.getSales_s() + "]";
			
			j++;
			
			if(j < second_list.size()) {
				str_s += ",";
			}
		}
		
		str_s += "]";
		
		//------------------------------------------------------------------------------------
		// 해당 연도 월별 총매출
		// 2차 카테고리 데이터
		List<StatChartVO> monthly_list = service.monthlyChart(ord_date);
		
		
		String str_m = "[['월', '총 매출'], ";
		
		int k = 0;
		
		for(StatChartVO vo : monthly_list) {
			
			str_m += "['" + vo.getMonth() + "', " + vo.getMonthly_sales() + "]";
			
			k++;
			
			if(k < monthly_list.size()) {
				str_m += ",";
			}
		}
		
		str_m += "]";
		//------------------------------------------------------------------------------------
		mv.addObject("prime_list", prime_list);
		mv.addObject("second_list", second_list);
		mv.addObject("second_list", monthly_list);
		mv.addObject("str_p", str_p);
		mv.addObject("str_s", str_s);
		mv.addObject("str_m", str_m);
		mv.setViewName("/admin/chart/monthlyOrder");
		
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		
		logger.info(str_p);
		logger.info(str_s);
		logger.info(str_m);
		
		return mv;
	}
	
	// (월별)통계 차트 페이지 날짜변경 POST
	@RequestMapping(value = "/updateChartDate", method = RequestMethod.POST)
	public String updateChartDate(@RequestParam("year") String year, @RequestParam("month") String month, RedirectAttributes rttr) {
		
		logger.info("======== updateChartDate() called ========");
		
		String dateValue = year + "-" + month + "-01 00:00:00.000";
		
		Timestamp targetDate = Timestamp.valueOf(dateValue);
		
		logger.info("targetDate : " + targetDate);
		logger.info("year : " + year + " // month : " + month);
		
		rttr.addAttribute("year", year);
		rttr.addAttribute("month", month);
		
		return "redirect:/admin/chart/monthlyOrder";
	}
	
	
	
}
