package com.bloomall.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bloomall.domain.CategoryVO;
import com.bloomall.util.SearchCriteria;

@Repository
public class CategoryDAOImpl implements CategoryDAO {

	@Inject
	private SqlSession session;
	
	private static final String NS = "com.bloomall.mappers.CategoryMapper";

	// 카테고리 등록
	@Override
	public void register(CategoryVO vo) throws Exception {
		session.insert(NS + ".register", vo);
	}

	// 카테고리 관리(리스트)
	@Override
	public List<CategoryVO> ctgrList(SearchCriteria cri) throws Exception {
		return session.selectList(NS + ".ctgrList", cri);
	}
	
	// 카테고리 개수
	@Override
	public int ctgrTotalCount(SearchCriteria cri) throws Exception {
		return session.selectOne(NS + ".ctgrTotalCount", cri);
	}

	// 카테고리 수정
	@Override
	public void ctgrUpdate(CategoryVO vo) throws Exception {
		session.update(NS + ".ctgrUpdate", vo);
	}

	// 카테고리 삭제
	@Override
	public void ctgrDelete(String ctgr_cd) throws Exception {
		session.delete(NS + ".ctgrDelete", ctgr_cd);
	}
}
