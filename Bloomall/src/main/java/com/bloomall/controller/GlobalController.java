package com.bloomall.controller;

import javax.inject.Inject;


import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.bloomall.service.UserProductService;
/* 톰캣이 구동되면, 다음 Model작업을 DB연동구문이 실행된다.
 * 컨트롤러에서 공통적으로 참조하는 코드를 작업
 * 다른 모든 컨트롤러보다 가장 먼저 실행 돼
 * 지정해둔 패키지 내의 모든 컨트롤러에서 사용되는 JSP파일에서 해당 model 사용가능
 */
@ControllerAdvice(basePackages = {"com.bloomall.controller"})
public class GlobalController {

	@Inject
	private UserProductService service;
	
	// 1차 카테고리 정보를 전역으로 저장하기 위한 작업
	// 톰캣이 시작될 때, 가장 먼저 이 작업이 진행됨. - 1차 카테고리 정보가 DB에서 변경되면 톰캣을 다시 시작해야 한다
	@ModelAttribute
	public void categoryInfo(Model model) throws Exception {
		// 1차 카테고리 뷰에 저장 
		model.addAttribute("userCategory", service.primaryCtgrList());
	}
}
