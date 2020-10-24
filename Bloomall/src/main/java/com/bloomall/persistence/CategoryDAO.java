package com.bloomall.persistence;

import java.util.List;

import com.bloomall.domain.CategoryVO;
import com.bloomall.util.SearchCriteria;

public interface CategoryDAO {
	
	// 카테고리 등록
	public void register(CategoryVO vo) throws Exception;
	
	// 카테고리 관리(리스트)
	public List<CategoryVO> ctgrList(SearchCriteria cri) throws Exception;
	
	// 카테고리 개수
	public int ctgrTotalCount(SearchCriteria cri) throws Exception;
	
	// 카테고리 수정
	public void ctgrUpdate(CategoryVO vo) throws Exception;
	
	// 카테고리 삭제
	public void ctgrDelete(String ctgr_cd) throws Exception;

}
