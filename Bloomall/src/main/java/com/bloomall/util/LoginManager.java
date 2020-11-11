package com.bloomall.util;

import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

public class LoginManager implements HttpSessionBindingListener {
	
	// 현재 클래스를 싱글톤 패턴으로 구성
	private static LoginManager loginMng = null;
	// 싱글톤 용도 생성자 - 향후의 실수를 방지하기 위해 생성
	private LoginManager() {}
	
	// 다중 요청의 동시 접근을 방지하기 위해 동기화synchronized를 설정
	// 요청에 의한 모든 스레드들을 순차적으로 사용하기 위한 동기화 기능메소드: synchronized
	public static synchronized LoginManager getInstance() {
		// 최초 사용자만 객체를 생성해서 가져가고,
		if(loginMng == null) {
			loginMng = new LoginManager();
		}
		// 두번째 사용자부터는 이미 생성된 객체를 가져간다
		return loginMng;
	}
	
	
	// 로그인 시 사용자아이디 저장
	private static Hashtable<HttpSession, String> loginUsers = new Hashtable<HttpSession, String>();

	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub

	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub

	}

}
