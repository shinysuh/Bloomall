package com.bloomall.persistence;

import java.util.List;
import java.util.Map;

import com.bloomall.domain.CategoryVO;
import com.bloomall.domain.ProductVO;
import com.bloomall.util.SearchCriteria;

public interface AdminProductDAO {

	// 1차 카테고리 코드
	public List<CategoryVO> primaryCtgrList() throws Exception;
	
	// 1차에 따른 2차 카테고리 코드
	public List<CategoryVO> subCategoryList(String ctgr_cd) throws Exception;
	
	// 상품 등록
	public void productRegi(ProductVO vo) throws Exception;
	
	// 상품 리스트(검색/페이징 포함)
	public List<ProductVO> productList(SearchCriteria cri) throws Exception;
	
	// 검색 상품 개수(검색 기능 포함)
	public int searchCount(SearchCriteria cri) throws Exception;
	
	// 상품 상세 페이지
	public ProductVO productDetail(int prd_idx) throws Exception;
	
	// 상품 수정
	public void updateProduct(ProductVO vo) throws Exception;
	
	// 상품 삭제
	public void deleteProduct(int prd_idx) throws Exception;
	
	// 선택 상품 수정
	public void updateChked(Map<String, Object> map) throws Exception;
	
}
