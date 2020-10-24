package com.bloomall.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bloomall.domain.CategoryVO;
import com.bloomall.persistence.CategoryDAO;
import com.bloomall.util.SearchCriteria;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Inject
	private CategoryDAO dao;

	// 카테고리 등록
	@Override
	public void register(CategoryVO vo) throws Exception {
		dao.register(vo);
	}

	// 카테고리 관리(리스트)
	@Override
	public List<CategoryVO> ctgrList(SearchCriteria cri) throws Exception {
		return dao.ctgrList(cri);
	}
	
	// 카테고리 개수
	@Override
	public int ctgrTotalCount(SearchCriteria cri) throws Exception {
		return dao.ctgrTotalCount(cri);
	}
	
	// 카테고리 수정
	@Override
	public void ctgrUpdate(CategoryVO vo) throws Exception {
		dao.ctgrUpdate(vo);
	}

	// 카테고리 삭제
	@Override
	public void ctgrDelete(String ctgr_cd) throws Exception {
		dao.ctgrDelete(ctgr_cd);
	}
}
