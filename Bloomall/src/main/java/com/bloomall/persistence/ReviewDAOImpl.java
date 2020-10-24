package com.bloomall.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bloomall.domain.ReviewVO;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

	@Inject
	private SqlSession session;
	
	private static final String NS = "com.bloomall.mappers.ReviewMapper";

	// 해당 상품의 총 상품후기 개수 
	@Override
	public int reviewCount(int prd_idx) throws Exception {
		return session.selectOne(NS + ".reviewCount", prd_idx);
	}

	// 리뷰 쓰기
	@Override
	public void writeRvw(ReviewVO vo) throws Exception {
		session.insert(NS + ".writeRvw", vo);
	}

	// 리뷰 수정
	@Override
	public void updateRvw(ReviewVO vo) throws Exception {
		session.update(NS + ".updateRvw", vo);
	}

	// 리뷰 삭제
	@Override
	public void deleteRvw(int rvw_idx) throws Exception {
		session.delete(NS + ".deleteRvw", rvw_idx);
	}

	// 리뷰 리스트
	@Override
	public List<ReviewVO> rvwList(Map<String, Object> map) throws Exception {
		return session.selectList(NS + ".rvwList", map);
	}

	
}
