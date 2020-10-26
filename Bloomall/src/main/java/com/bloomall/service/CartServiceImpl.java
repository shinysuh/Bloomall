package com.bloomall.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bloomall.persistence.CartDAO;

@Service
public class CartServiceImpl implements CartService {
	
	@Inject
	private CartDAO dao;
	

}
