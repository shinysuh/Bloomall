package com.bloomall.util;

import java.util.Collection;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

// 중복 로그인 방지 클래스 - HttpSessionBindingListener 구현
public class LoginBindingManager implements HttpSessionBindingListener {
	
	// 현재 클래스를 싱글톤 패턴으로 구성
	private static LoginBindingManager loginMng = null;
	// 싱글톤 용도 생성자 - 향후의 실수를 방지하기 위해 생성
	private LoginBindingManager() {}
	
	// 다중 요청의 동시 접근을 방지하기 위해 동기화synchronized를 설정
	// 요청에 의한 모든 스레드들을 순차적으로 사용하기 위한 동기화 기능메소드: synchronized
	public static synchronized LoginBindingManager getInstance() {
		// 최초 사용자만 객체를 생성해서 가져가고,
		if(loginMng == null) {
			loginMng = new LoginBindingManager();
		}
		// 두번째 사용자부터는 이미 생성된 객체를 가져간다
		return loginMng;
	}
	
	// 로그인 시 사용자아이디 저장(로그인 한 접속자를 저장)
	// Hashtable -> Hashmap과 비슷한 개념 : Hashtable은 동기화가 지원됨
	private static Hashtable<HttpSession, String> loginUsers = new Hashtable<HttpSession, String>();

	//[세션정보 추가]시 호출되는 이벤트
	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		
		if(event.getSession().getAttribute("admin") != null) {
		}
		loginUsers.put(event.getSession(), event.getName());
		System.out.println(event.getName() + " 로그인 완료");
		System.out.println("현재 접속자 수 : " + getUserCount());
	}

	// [세션소멸(로그아웃)] 시 호출되는 이벤트
	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		loginUsers.remove(event.getSession());
		System.out.println(event.getName() + " 로그아웃 완료");
		System.out.println("현재 접속자 수 : " + getUserCount());
	}
	
	// 로그아웃 시, 접속되어 있던 아이디를 해시테이블에서 삭제
	public void removeSesseion(String userId) {
		Enumeration<HttpSession> enu = loginUsers.keys();
		HttpSession session = null;
		
		while(enu.hasMoreElements()) {
			session = enu.nextElement();
			if(loginUsers.get(session).equals(userId)) {
				// 세션 소멸 시, HttpSessionBindingListener를 구현하는 클래스의 valueUnbound() 호출
				session.invalidate();
			}
		}
	}

	// 현재 접속자 수
	private int getUserCount() {
		return loginUsers.size();
	}
	
	// 아이디 중복 방지 목적으로 체크 - true: 아이디 사용중(접속중) / false: 아이디 미사용중(미접속)
	public boolean isDuplicated(String userId) {
		return loginUsers.containsValue(userId); // 현재 해시테이블이 해당 아이디 정보를 갖고 있는지
	}
	
	// 로그인 후 아이디를 세션형태로 저장 - 이때까지 사용했던 session.setAttribute()
	public void setSession(HttpSession session, String userId) {
		// Session Binding 이벤트가 일어나는 시점
		// name 값으로 userId, value 값으로 자기자신(HttpSessionBindingListner를 구현하는 Object
		session.setAttribute(userId, this);		// login에 자기자신을 집어넣음 => 여기서 userId가 valueBound()에서 event.getName()으로 삽입되는 것
		//여기서 setAttribute 작업을 더 하면??
		
		
	}
	
	// 사용자 아이디 가져오기
	public String getUserID(HttpSession session) {
		return loginUsers.get(session);
	}
	
	// 현재 접속중인 모든 사용자의 아이디를 출력
	public void printLoginUsers() {
		// 단순히 데이터를 순차적으로 읽어오는 구조의 Enumeration<> 객체(Iterator도 마찬가지)
		Enumeration<HttpSession> enu = loginUsers.keys();
		HttpSession session = null;
		System.out.println("=================================================");
		
		int i =0;
		
		while(enu.hasMoreElements()) {
			session = enu.nextElement();
			System.out.println((++i) + ".접속자 : " + loginUsers.get(session));
		}
		System.out.println("=================================================");
	}
	
	// 현재 접속 중인 모든 사용자를 리스트형태로 리턴
	public Collection<String> getUser(){
		
		Collection<String> collection = loginUsers.values();
		
		return collection;
	}
	
	
}

