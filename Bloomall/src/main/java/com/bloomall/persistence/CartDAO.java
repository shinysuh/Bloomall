package com.bloomall.persistence;

import java.util.List;
import java.util.Map;

import com.bloomall.domain.CartVO;
import com.bloomall.domain.UserCartListVO;

public interface CartDAO {

	// 장바구니에 상품 추가
	public void addToCart(CartVO vo) throws Exception;
	
	// 장바구니 리스트 가져오기
	public List<UserCartListVO> cartList(String mem_id) throws Exception;
	
	// 장바구니 수량변경
	public void updateCart(CartVO vo) throws Exception;
	
	// 장바구니 삭제
	public void deleteCart(int cart_idx) throws Exception;
	
	// 선택상품 주문 시 장바구니에서 구매상품 삭제
	public void emptyCart(Map<String, Object> map) throws Exception;
	
	// 전체 주문 시 장바구니 전체 비우기
	public void emptyCartAll(String mem_id) throws Exception;
	
}
