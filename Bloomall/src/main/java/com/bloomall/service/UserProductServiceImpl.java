package com.bloomall.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bloomall.domain.CategoryVO;
import com.bloomall.domain.ProductVO;
import com.bloomall.persistence.UserProductDAO;
import com.bloomall.util.Criteria;
import com.bloomall.util.SearchCriteria;

@Service
public class UserProductServiceImpl implements UserProductService {

	@Inject
	private UserProductDAO dao;

	// 1차 카테고리 출력
	@Override
	public List<CategoryVO> primaryCtgrList() throws Exception {
		return dao.primaryCtgrList();
	}

	// 1차 카테고리에 따른 2차 카테고리
	@Override
	public List<CategoryVO> subCategoryList(String ctgr_cd) throws Exception {
		return dao.subCategoryList(ctgr_cd);
	}

	// 카테고리 이름 가져오기
	@Override
	public String getCtgrName(String ctgr_cd) throws Exception {
		return dao.getCtgrName(ctgr_cd);
	}

	// 상품 리스트 (카테고리 선택 시)
	@Override
	public List<ProductVO> productList(Map<String, Object> map) throws Exception {
		return dao.productList(map);
	}
	
	//상품리스트(카테고리 - 1차)
	@Override
	public List<ProductVO> primeList(Criteria cri, String ctgr_prt_cd) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cri", cri);
		map.put("ctgr_prt_cd", ctgr_prt_cd);
		
		return dao.primeList(map);
	}
	
	// 상품리스트 ALL
	@Override
	public List<ProductVO> productListAll(Map<String, Object> map) throws Exception {
		return dao.productListAll(map);
	}

	// 상품 개수 (2차 카테고리 선택 시)
	@Override
	public int countByCtgr(String ctgr_cd) throws Exception {
		return dao.countByCtgr(ctgr_cd);
	}
	
	// 상품 개수 (1차 카테고리 선택 시)
	@Override
	public int prime_countByCtgr(String ctgr_prt_cd) throws Exception {
		return dao.prime_countByCtgr(ctgr_prt_cd);
	}

	// 상품 개수 (전체)
	@Override
	public int all_countByCtgr() throws Exception {
		return dao.all_countByCtgr();
	}

	// 상품 리스트 (검색 시)
	@Override
	public List<ProductVO> productListSearch(SearchCriteria scri) throws Exception {
		return dao.productListSearch(scri);
	}

	// 상품 개수 (검색 시)
	@Override
	public int countBySearch(String keyword) throws Exception {
		return dao.countBySearch(keyword);
	}

	// 상품 상세정보 페이지
	@Override
	public ProductVO productDetail(int prd_idx) throws Exception {
		return dao.productDetail(prd_idx);
	}

	// 부모 카테고리 이름 가져오기
	@Override
	public String getPrtName(String ctgr_cd) throws Exception {
		return dao.getPrtName(ctgr_cd);
	}

	
}
