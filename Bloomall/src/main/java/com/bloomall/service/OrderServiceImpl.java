package com.bloomall.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bloomall.persistence.OrderDAO;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Inject
	private OrderDAO dao;

	
	
	
	

}
