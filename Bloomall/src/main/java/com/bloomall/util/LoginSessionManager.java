package com.bloomall.util;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class LoginSessionManager implements HttpSessionListener{

	private static int count;  // 현재 접속자 수
	
	private static int totalCount;  // 전체 방문 수 -> 저장(txt파일, DB) ->"전체방문 수" => 말그대로 방문 수. 세션 생성된 총 개수
	
	public static int getCount() {
		return count;
	}

	public static int getTotalCount() {
		return totalCount;
	}

	// 톰캣 동작 => xml에 직접 코딩된 빈객체들 생성 => 컨트롤러 쪽 @controller / @repository / @service 객체는 요청에 의해 나중에 생성
	@Override
	public void sessionCreated(HttpSessionEvent event) { // 컨트롤러가 실행되기 전(빈객체 생성 전)에 이 메소드가 먼저 호출됨.
		// 세션이 생성될 때 호출
		HttpSession session = event.getSession();
		session.setMaxInactiveInterval(60*20);
		
		count++;
		totalCount++;		// 방문 카운트 +1
		
		// 타겟 컨트롤러 관련 빈객체 생성 전이므로, context.xml 파일들에 xml문법으로 생성한 객체(sqlSession 등)에 직접 접근해서 정보를 가져온다
		session.getServletContext().log(session.getId() + " 세션생성" + ", 접속자 수 : " + count);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		// 세션이 소멸될 때 호출
		count--;  // 세션이 소멸할 때마다 접속사 수 하나씩 감소
		
		if(count < 0)
			count = 0;
		
		HttpSession session = event.getSession();
		session.getServletContext().log(session.getId() + " 세션소멸" + ", 접속자 수 : " + count);
	}

}










