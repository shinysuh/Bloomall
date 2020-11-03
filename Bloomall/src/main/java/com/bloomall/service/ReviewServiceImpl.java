package com.bloomall.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bloomall.domain.ReviewVO;
import com.bloomall.persistence.ReviewDAO;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Inject
	private ReviewDAO dao;

	// 해당 상품의 총 상품후기 개수 
	@Override
	public int reviewCount(int prd_idx) throws Exception {
		return dao.reviewCount(prd_idx);
	}

	// 리뷰 쓰기
	@Override
	public void writeRvw(ReviewVO vo, String mem_id) throws Exception {
		vo.setMem_id(mem_id);
		dao.writeRvw(vo);
	}

	// 리뷰 수정
	@Override
	public void updateRvw(ReviewVO vo) throws Exception {
		dao.updateRvw(vo);
	}

	// 리뷰 삭제
	@Override
	public void deleteRvw(int rvw_idx) throws Exception {
		dao.deleteRvw(rvw_idx);
	}

	// 리뷰 평균(평점)
	@Override
	public double rvwAverage(int prd_idx) throws Exception {
		return dao.rvwAverage(prd_idx);
	}
	
	// 리뷰 리스트
	@Override
	public List<ReviewVO> rvwList(Map<String, Object> map) throws Exception {
		return dao.rvwList(map);
	}

	
}
