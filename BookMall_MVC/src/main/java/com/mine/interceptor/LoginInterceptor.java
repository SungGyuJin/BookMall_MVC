package com.mine.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse respone, Object handler) throws Exception{
		
		System.out.println("로그인 인터셉터 preHandle success");
		
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		return true;
	}
}
