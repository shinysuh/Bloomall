package com.bloomall.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bloomall.domain.CategoryVO;
import com.bloomall.domain.ProductVO;
import com.bloomall.service.AdminProductService;
import com.bloomall.util.FileUtils;
import com.bloomall.util.PageMaker;
import com.bloomall.util.SearchCriteria;

@Controller
@RequestMapping("/admin/product/*")
public class AdminProductController {

	private static final Logger logger = LoggerFactory.getLogger(AdminProductController.class);

	@Inject
	private AdminProductService service;
	
	// 웹 프로젝트 영역 외부에 파일을 저장할 때 사용할 경로
	@Resource(name="uploadPath")
	private String uploadPath;	// servlet-context.xml에 설정됨
	
	
	// 1차 카테고리에 따른 2차 카테고리
	@ResponseBody
	@RequestMapping(value = "/subCategory/{ctgr_cd}", method=RequestMethod.GET)
	public ResponseEntity<List<CategoryVO>> subCategoryList(@PathVariable("ctgr_cd") String ctgr_cd){
		
		logger.info("======== subCategoryList() called ========");
		
		ResponseEntity<List<CategoryVO>> entity = null;
				
		try {
			entity = new ResponseEntity<List<CategoryVO>>(service.subCategoryList(ctgr_cd), HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	// 파일 출력 - 저장된 파일 가져와서 반환
	@ResponseBody
	@RequestMapping(value = "/fileDisplay", method=RequestMethod.GET)
	public ResponseEntity<byte[]> fileDisplay(String fileName) throws Exception{

		return FileUtils.getFile(uploadPath, fileName);
	}
	
	
	// 이미지 파일 삭제
	public void deleteImg(String fileName) {
		logger.info("Delete fileName : " + fileName);
		
		FileUtils.deleteFile(uploadPath, fileName);
	}
	
	
	// 상품등록(GET)
	@RequestMapping(value = "/register", method=RequestMethod.GET)
	public void productRegi(Model model) throws Exception {
		// 1차 카테고리 리스트 모델작업
		model.addAttribute("ctgrList", service.primaryCtgrList());
	}
	
	// 상품등록(POST) - 1)파일업로드 .(일반적<input> 방식/Ajax-Drag&Drop 방식) 2)DB작업.
	@RequestMapping(value = "/registerOk", method=RequestMethod.POST)
	public String productRegiOk(ProductVO vo, RedirectAttributes rttr) throws IOException, Exception {
		
		logger.info("======== productRegiOk() called ========");
		logger.info(vo.toString());
		
		// prd_img 생성 (업로드된 이미지 파일) - 날짜 폴더에 UUID_파일명으로 저장
		vo.setPrd_img(FileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(), vo.getFile1().getBytes()));;
		
		service.productRegi(vo);
		rttr.addFlashAttribute("msg", "PRODUCT_REGI_SUCCESS");
		
		
		return "redirect:/admin/product/list";
	}
	
	
	// 상품상세(CKEditor) - 파일 업로드 
	/* MultipartFile upload 파라미터명 지정된 것. 바꾸면 X */
	@RequestMapping(value = "/imageUpload", method=RequestMethod.POST)
	public void imageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile upload) {
		
		logger.info("======== imageUpload() called ========");
	
		OutputStream out = null;
		PrintWriter printWriter = null;
		
		// 인코딩 설정
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		try {
			// 전송할 파일 정보
			String fileName = upload.getOriginalFilename();
			byte[] bytes = upload.getBytes();
			
			// 폴더 경로
			String uploadPath = request.getSession().getServletContext().getRealPath("/");
			uploadPath += "resources\\upload\\" + fileName;
			
			logger.info("=== uploadPath : " + uploadPath);
			
			// 출력 스트림 생성
			out = new FileOutputStream(new File(uploadPath));
			// 파일 쓰기
			out.write(bytes);
			
			printWriter = response.getWriter();
			String fileUrl = "/upload/" + fileName;
			
			// CKEditor 4 제공 형식
			printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
			printWriter.flush();	// 클라이언트로 전송(return 역할)
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(out != null) try {out.close();} catch(Exception e) {e.printStackTrace();}
			if(printWriter != null) try {printWriter.close();} catch(Exception e) {e.printStackTrace();}
		}
	}
	
	
	// 상품 리스트(페이징/검색 기능)
	@RequestMapping(value = "/list", method=RequestMethod.GET)
	public String productList(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		
		logger.info("======== productList() called ========");
		logger.info(cri.toString());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.getCri().setPerPageNum(10);
		
		List<ProductVO> productList = service.productList(cri);
		
		int count = service.searchCount(cri);
		pageMaker.setTotalCount(count);

		
		logger.info(pageMaker.toString());
		logger.info("======== 일치하는 상품 개수 : " + count);
		
		model.addAttribute("productList", productList);
		model.addAttribute("pageMaker", pageMaker);
	
		return "/admin/product/list";
	}
	
	
	// 상품 상세 페이지 보기
	@RequestMapping(value = "/detail", method=RequestMethod.GET)
	public String productDetail(@ModelAttribute("cri") SearchCriteria cri,
								@RequestParam("prd_idx") int prd_idx, Model model) throws Exception{
		
		logger.info("======== productDetail() called ========");

		// 선택상품 정보의 날짜 변환
		ProductVO vo = service.productDetail(prd_idx);
		logger.info("=====상품기존정보 : " + vo.toString());
		
		// 썸네일 파일 이름 수정 - 설정 시, 상세페이지에서  썸네일 대신 원본이름 display. BUT 원본 너무 큼. 썸네일로 유지
//		vo.setPrd_img(vo.getPrd_img().substring(vo.getPrd_img().lastIndexOf("_") + 1));
		logger.info("=====변경된 정보 : " + vo.toString());
				
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		model.addAttribute("vo", vo);
		model.addAttribute("pageMaker", pageMaker);
		
		logger.info(cri.toString());
		
		return "/admin/product/detail";
	}
	
	
	// 상품 수정(GET) - jsp로 선택상품정보/1차카테고리/현재2차카테고리/페이징정보/원래파일명 전송
	@RequestMapping(value = "/update", method=RequestMethod.GET)
	public void updateProduct(@ModelAttribute("cri") SearchCriteria cri,
							@RequestParam("prd_idx") int prd_idx, Model model) throws Exception {
		
		logger.info("======== updateProduct() called ========");

		// 선택상품 정보의 날짜 변환
		ProductVO vo = service.productDetail(prd_idx);
		logger.info(vo.toString());
		
		List<CategoryVO> primaryCtgrList = service.primaryCtgrList();
		List<CategoryVO> subCtgrList = service.subCategoryList(vo.getCtgr_prt_cd());
		String originalFile = vo.getPrd_img().substring(vo.getPrd_img().lastIndexOf("_") + 1);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);

		model.addAttribute("vo", vo);
		model.addAttribute("orignalFile", originalFile);
		model.addAttribute("ctgrList", primaryCtgrList);
		model.addAttribute("subCtgrList", subCtgrList);
		model.addAttribute("pageMaker", pageMaker);
	}
	
	
	// 상품 수정(POST)
	@RequestMapping(value = "/update", method=RequestMethod.POST)
	public String updateProductOk(ProductVO vo, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		
		logger.info("======== updateProductOk() called ========");
		logger.info(vo.toString());
		logger.info(cri.toString());
		
		// 파일 사이즈로 새로운 파일등록여부 확인 - 등록 안할 시, null이 아닌 비어있는 쓰레기 파일이 넘어옴
		if(vo.getFile1().getSize() > 0) {
			// 파일 변경시, prd_img를 업로드 파일정보로 설정
			logger.info("=====file not null");
			vo.setPrd_img(FileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(), vo.getFile1().getBytes()));;
		}
		
		logger.info("=====new info : " + vo.toString());
		
		service.updateProduct(vo);

		rttr.addFlashAttribute("cri", cri);
		rttr.addFlashAttribute("msg", "PRD_UPDATE_SUCCESS");
		
		return "redirect:/admin/product/list";
	}
	
	
	// 상품 삭제(POST)
	@RequestMapping(value = "/delete", method=RequestMethod.POST)
	public String deleteProduct(SearchCriteria cri, @RequestParam("prd_idx") int prd_idx,
								@RequestParam("prd_img") String prd_img, RedirectAttributes rttr) throws Exception {
		
		logger.info("======== deleteProduct() called ========");		
		
		// 이미지 파일 삭제
		deleteImg(prd_img);
	
		// 상품 삭제
		service.deleteProduct(prd_idx);
		
		rttr.addFlashAttribute("cri", cri);
		rttr.addFlashAttribute("msg", "PRD_DELETE_SUCCESS");
		
		return "redirect:/admin/product/list";
	}
	
	
	/*---------------------------------------------*/
	/* 선택 상품 수정 */
	@ResponseBody
	@RequestMapping(value = "/updateChked", method = RequestMethod.POST)
	public ResponseEntity<String> updateChked(@RequestParam("chkArr[]") List<Integer> chkArr,
											@RequestParam("amtArr[]") List<Integer> amtArr,
											@RequestParam("inStockArr[]") List<String> inStockArr){
		
		logger.info("======== updateChked() called ========");
		
		ResponseEntity<String> entity = null;
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			
			for(int i=0; i<chkArr.size(); i++) {
				map.put("prd_idx", chkArr.get(i));
				map.put("prd_amount", amtArr.get(i));
				map.put("prd_in_stock", inStockArr.get(i));
				
				service.updateChked(map);
			}
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	/* 선택 상품 삭제 */
	@ResponseBody
	@RequestMapping(value = "/deleteChked", method=RequestMethod.POST)
	public ResponseEntity<String> deleteChked(@RequestParam("chkArr[]") List<Integer> chkArr,
											  @RequestParam("imgArr[]") List<String> imgArr){

		logger.info("======== deleteChked() called ========");
		
		ResponseEntity<String> entity = null;
		
		try {
			// 체크된 상품 및 상품의 이미지 파일 삭제
			for(int i=0; i<chkArr.size(); i++) {
				deleteImg(imgArr.get(i));;
				service.deleteProduct(chkArr.get(i));
			}
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
}
