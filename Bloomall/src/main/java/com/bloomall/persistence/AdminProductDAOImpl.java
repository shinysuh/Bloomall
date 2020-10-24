package com.bloomall.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bloomall.domain.CategoryVO;
import com.bloomall.domain.ProductVO;
import com.bloomall.util.SearchCriteria;

@Repository
public class AdminProductDAOImpl implements AdminProductDAO {
	
	@Inject
	private SqlSession session;
	
	private static final String NS = "com.bloomall.mappers.AdminProductMapper";

	// 1차 카테고리 코드
	@Override
	public List<CategoryVO> primaryCtgrList() throws Exception {
		return session.selectList(NS + ".primaryCtgrList");
	}

	// 1차에 따른 2차 카테고리 코드
	@Override
	public List<CategoryVO> subCategoryList(String ctgr_cd) throws Exception {
		return session.selectList(NS + ".subCategoryList", ctgr_cd);
	}

	// 상품 등록
	@Override
	public void productRegi(ProductVO vo) throws Exception {
		session.insert(NS + ".productRegi", vo);
	}

	// 상품 리스트(검색/페이징 포함)
	@Override
	public List<ProductVO> productList(SearchCriteria cri) throws Exception {
		return session.selectList(NS + ".productList", cri);
	}

	// 검색 상품 개수(검색 기능 포함)
	@Override
	public int searchCount(SearchCriteria cri) throws Exception {
		return session.selectOne(NS + ".searchCount", cri);
	}

	// 상품 상세 페이지
	@Override
	public ProductVO productDetail(int prd_idx) throws Exception {
		return session.selectOne(NS + ".productDetail", prd_idx);
	}

	// 상품 수정
	@Override
	public void updateProduct(ProductVO vo) throws Exception {
		session.update(NS + ".updateProduct", vo);
	}

	// 상품 삭제
	@Override
	public void deleteProduct(int prd_idx) throws Exception {
		session.delete(NS + ".deleteProduct", prd_idx);
	}

	// 선택 상품 수정
	@Override
	public void updateChked(Map<String, Object> map) throws Exception {
		session.update(NS + ".updateChked", map);
	}
	
	

	
	

}
