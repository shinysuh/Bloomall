package com.bloomall.persistence;

import java.util.List;
import java.util.Map;

import com.bloomall.domain.ReviewVO;

public interface ReviewDAO {

	// 해당 상품의 총 상품후기 개수 
	public int reviewCount(int prd_idx) throws Exception;
	
	// 리뷰 쓰기
	public void writeRvw(ReviewVO vo) throws Exception;
	
	// 리뷰 수정
	public void updateRvw(ReviewVO vo) throws Exception;
	
	// 리뷰 삭제
	public void deleteRvw(int rvw_idx) throws Exception;
	
	// 리뷰 리스트
	public List<ReviewVO> rvwList(Map<String, Object> map) throws Exception;
	
}
