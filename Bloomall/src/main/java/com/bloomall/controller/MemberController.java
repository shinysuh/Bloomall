package com.bloomall.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bloomall.domain.MemberVO;
import com.bloomall.dto.MemberDTO;
import com.bloomall.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Inject
	private MemberService service;
	
	// 암호화 작업
	@Inject
	private BCryptPasswordEncoder cryptPassEnc;	
	

	// 회원가입 뷰(GET)
	@RequestMapping(value = "/join", method=RequestMethod.GET)
	public void join() {
		
	}
		
	// 회원가입 전송(POST)
	@RequestMapping(value = "/join", method=RequestMethod.POST)
	public String joinOk(MemberVO vo, RedirectAttributes rttr) throws Exception{
		
		logger.info(vo.toString());
		
		// 비밀번호 암호화 작업
		vo.setMem_pw(cryptPassEnc.encode(vo.getMem_pw()));
		
		service.join(vo);
		rttr.addFlashAttribute("msg", "MEM_REGISTER_SUCCESS");
		
		return "redirect:/";	// 루트 페이지로 이동
	}
	
	
	
	// 아이디 중복체크(ajax 요청)
	@ResponseBody
	@RequestMapping(value = "/confirmId", method = RequestMethod.POST)
	public ResponseEntity<String> confirmId(@RequestParam("mem_id") String mem_id) {
		
		logger.info("======== confirmID() called ========");
		
		ResponseEntity<String> entity = null;
		
		try {
			String confirm_status = service.confirmId(mem_id);
			
			if(confirm_status != null) {
				// 중복되는 아이디 존재 -> 아이디 사용불가
				entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
			}else {
				// 아이디 사용가능
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);	// 요청에 문제 발생
		}
		return entity;
	}
	
	// 이메일 인증코드 확인 - authentication
	@ResponseBody
	@RequestMapping(value = "/emailAuthConfirm", method=RequestMethod.POST)
	public ResponseEntity<String> emailAuthCode(@RequestParam("code") String code, HttpSession session){
				
		ResponseEntity<String> entity = null;
		
		try {
			// 입력한 코드와 인증코드가 일치. 이메일 인증 성공
			if(code.equals(session.getAttribute("authcode"))) {
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}else {  // 코드 불일치. 인증 실패
				entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
			}
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);	// 요청 오류
		}		
		return entity;
	}
	
	
	// 로그인(GET)
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void login() {
		
	}
	
	// 로그인(POST) - HttpSevletResponse response 파라미터 필요하면 추가
	@RequestMapping(value = "/loginOk", method=RequestMethod.POST)
	public String loginOk(MemberDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception {
		
		logger.info("======== loginOk() called ========");
		
		// DB에서 암호화된 비밀번호 저장
		MemberDTO memDto = service.login(dto);
		
		String url = "";
		
		if(memDto != null) {	// 로그인 성공
			logger.info("로그인 성공");
			
			session.setAttribute("user", memDto);	// 세션에 사용자 정보 저장
			rttr.addFlashAttribute("msg", "LOGIN_SUCCESS");
			
			// 로그인 전에 요청된 주소의 존재 유무 확인
			// 존재하면 해당 주소로 이동
			String destination = (String) session.getAttribute("dest");
			
			url = destination != null ? (String) destination : "/";
			
			return "redirect:" + url;	// 루트
		}else {	// 로그인 실패
			logger.info("로그인 실패");
			
			// 주소 이동 시, "msg"키 노출 안됨
			rttr.addFlashAttribute("msg", "LOGIN_FAIL");
			
			return "redirect:/member/login";	// 다시 로그인 페이지로 이동
		}
	}
	
	
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, RedirectAttributes rttr) {
		
		logger.info("======== logout() called ========");
		
		session.invalidate();	// 세션 삭제. 로그아웃
		rttr.addFlashAttribute("msg", "LOGOUT_SUCCESS");
		
		return "redirect:/";
	}
	
	
	// 마이페이지 뷰
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public void myPage(HttpSession session, Model model) throws Exception {
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		
		String mem_id = dto.getMem_id();
		
		MemberVO vo = service.getUserInfo(mem_id);
		
		model.addAttribute("vo", vo);
		
	}
	
	
	// 비밀번호 재확인 (GET) - 회원 정보 수정용
	@RequestMapping(value = "/checkPW", method = RequestMethod.GET)
	public void checkPW(@ModelAttribute("url") String url) {
		
	}
	
	// 비밀번호 재확인 (POST)
	@RequestMapping(value = "/checkPW", method=RequestMethod.POST)
	public String checkPWOk(@RequestParam("mem_pw") String mem_pw, @RequestParam("url") String url, HttpSession session, Model model) throws Exception{
		
		// 파라미터 url : 이동할 jsp 페이지명
		logger.info("======== checkPWOk() called ========");
		logger.info("url : " + url + ", mem_pw : " + mem_pw);
		
		MemberDTO dto = (MemberDTO)session.getAttribute("user");	// 로그인 시 세션에 저장한 사용자정보
		
		// 입력 비밀번호, 암호화 비밀번호 일치 확인
		if(cryptPassEnc.matches(mem_pw, dto.getMem_pw())) {	// 갱신된 비밀번호 정보를 다시 가져옴
			// 비밀번호 일치 시, url 확인
			/* url에 따라 [회원정보수정-modify]/[비밀번호변경-updatePW]/[회원탈퇴-delete] 페이지로 각각 넘어가는 기능 */
			if(url.equals("modify")) {
				model.addAttribute("vo", service.getUserInfo(dto.getMem_id()));	// 정보 수정을 위한 회원정보 가져오기
				return "/member/modify";	// 회원정보 수정 뷰
			
			}else if(url.equals("updatePW")) {
				return "/member/updatePW";	// 비밀번호 변경 뷰
			
			}else if(url.equals("delete")) {
				return "/member/delete";	// 회원 탈퇴 뷰
			}
		}	
		
		model.addAttribute("url", url);
		model.addAttribute("msg", "NOT_CORRECT_PASSWORD");
		
		return "/member/checkPW";
	}
	
	
	
	// 비밀번호 확인 Ajax - 수정폼에서 한번 더 확인
	@ResponseBody
	@RequestMapping("/checkPW_Ajax")
	public ResponseEntity<String> checkPW_Ajax(@RequestParam("mem_pw") String mem_pw, HttpSession session){
		
		logger.info("------checkPW_Ajax() called------");
		
		ResponseEntity<String> entity = null;
		MemberDTO dto = (MemberDTO)session.getAttribute("user");	// 로그인 시 세션에 저장한 사용자정보
		
		logger.info("mem_pw : " + mem_pw +", dto : " + dto.toString());
		
		if(cryptPassEnc.matches(mem_pw, dto.getMem_pw())) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
		}
		return entity;		
	}
	
	
	
	// 회원정보 수정(POST)
	@RequestMapping(value = "/modify", method=RequestMethod.POST)
	public String modifyInfo(MemberVO vo, RedirectAttributes rttr, HttpSession session) throws Exception {
		
		logger.info(vo.toString());
		
		MemberDTO dto = new MemberDTO();
		
		dto.setMem_id(vo.getMem_id());
		dto.setMem_pw(vo.getMem_pw());
		
		// 일반 비밀번호의 암호화 작업. setter() 메소드로 재저장
		vo.setMem_pw(cryptPassEnc.encode(vo.getMem_pw()));
		service.modifyInfo(vo);
		
		// 변경된 회원정보를 세션에 다시 저장해서 세션정보 갱신
		session.setAttribute("user", service.login(dto));
		
		rttr.addFlashAttribute("msg", "MODIFY_INFO_SUCCESS");
		
		return "redirect:/";
	}
	
	
	
	// 비밀번호 변경(POST)
	@RequestMapping(value = "/updatePW", method=RequestMethod.POST)
	public String updatePW(MemberDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception {
		
		logger.info("======== updatePW() called ========");
		
		// 비밀번호 암호화 후 변경
		dto.setMem_pw(cryptPassEnc.encode(dto.getMem_pw()));
		
		// 비밀번호 변경
		service.updatePW(dto);
		
		/* 세션 비밀번호 재설정. 필수 of 필수s */
		MemberDTO memDto = (MemberDTO)session.getAttribute("user");
		// 변경 후의 비밀번호 정보 재저장(정보 갱신)
		memDto.setMem_pw(dto.getMem_pw());
		// 세션에 dto정보 재저장(정보 갱신)
		session.setAttribute("user", memDto);

		rttr.addFlashAttribute("msg", "PW_UPDATE_SUCCESS");
		
		return "redirect:/";
	}
	
	
		
	// 회원탈퇴(POST)
	@RequestMapping(value = "/delete", method=RequestMethod.POST)
	public String deletMember(String mem_id, RedirectAttributes rttr, HttpSession session) throws Exception {
		
		logger.info("======== deletMember() called ========");
		
		service.deleteMember(mem_id);
		
		session.invalidate();	// 세션 소멸
		rttr.addFlashAttribute("msg", "DELETE_MEMBER_SUCCESS");
				
		return "redirect:/";
	}
	
}
