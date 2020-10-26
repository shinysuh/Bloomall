package com.bloomall.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class CartDAOImpl implements CartDAO {

	@Inject
	private SqlSession session;
	
	private static final String NS = "com.bloomall.mappers.CartMapper";
	
	
	
	
	
}
