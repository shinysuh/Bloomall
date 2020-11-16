package com.bloomall.persistence;

import java.util.List;
import java.util.Map;

import com.bloomall.domain.CategoryVO;
import com.bloomall.domain.ProductVO;
import com.bloomall.util.Criteria;
import com.bloomall.util.SearchCriteria;

public interface UserProductDAO {

	// 1차 카테고리 출력
	public List<CategoryVO> primaryCtgrList() throws Exception;
	
	// 1차 카테고리에 따른 2차 카테고리
	public List<CategoryVO> subCategoryList(String ctgr_cd) throws Exception;
	
	// 카테고리 이름 가져오기
	public String getCtgrName(String ctgr_cd) throws Exception;
	
	// 부모 카테고리 이름 가져오기
	public String getPrtName(String ctgr_cd) throws Exception;
	
	// 상품 리스트 (카테고리 선택 시)
	public List<ProductVO> productList(Map<String, Object> map) throws Exception;
	
	// 상품리스트(카테고리 - 1차)
	public List<ProductVO> primeList(Map<String, Object> map) throws Exception;
	
	// 상품리스트 ALL
	public List<ProductVO> productListAll(Criteria cri) throws Exception;
	
	// 상품 개수 (2차 카테고리 선택 시)
	public int countByCtgr(String ctgr_cd) throws Exception;
	
	// 해당되는 상품 개수(1차 카테고리)
	public int prime_countByCtgr(String ctgr_prt_cd) throws Exception;
	
	// 해당되는 상품 개수(전체)
	public int all_countByCtgr() throws Exception;
	
	// 상품 리스트 (검색 시)
	public List<ProductVO> productListSearch(SearchCriteria scri) throws Exception;
	
	// 상품 개수 (검색 시)
	public int countBySearch(String keyword) throws Exception;
	
	// 상품 상세정보 페이지
	public ProductVO productDetail(int prd_idx) throws Exception;
	
	
}
