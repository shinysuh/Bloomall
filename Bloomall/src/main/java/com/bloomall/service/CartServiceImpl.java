package com.bloomall.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bloomall.domain.CartVO;
import com.bloomall.domain.UserCartListVO;
import com.bloomall.persistence.CartDAO;

@Service
public class CartServiceImpl implements CartService {
	
	@Inject
	private CartDAO dao;

	// 장바구니에 상품 추가
	@Override
	public void addToCart(CartVO vo) throws Exception {
		dao.addToCart(vo);
	}

	// 장바구니 리스트 가져오기
	@Override
	public List<UserCartListVO> cartList(String mem_id) throws Exception {
		return dao.cartList(mem_id);
	}

	// 장바구니 수량변경
	@Override
	public void updateCart(CartVO vo) throws Exception {
		dao.updateCart(vo);
	}

	// 장바구니 삭제
	@Override
	public void deleteCart(int cart_idx) throws Exception {
		dao.deleteCart(cart_idx);
	}


}
