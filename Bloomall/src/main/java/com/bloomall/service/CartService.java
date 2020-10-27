package com.bloomall.service;

import java.util.List;

import com.bloomall.domain.CartVO;
import com.bloomall.domain.UserCartListVO;

public interface CartService {

	// 장바구니에 상품 추가
	public void addToCart(CartVO vo) throws Exception;
	
	// 장바구니 리스트 가져오기
	public List<UserCartListVO> cartList(String mem_id) throws Exception;
	
	// 장바구니 수량변경
	public void updateCart(CartVO vo) throws Exception;
	
	// 장바구니 삭제
	public void deleteCart(int cart_idx) throws Exception;

}
