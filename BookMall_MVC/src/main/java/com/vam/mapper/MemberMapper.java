package com.vam.mapper;

import com.vam.model.MemberVO;

public interface MemberMapper {

	// 회원가입
	public void memberJoin(MemberVO member);
	
	// ID 중복검사
	public int idCheck(String memberId);
	
	// 로그인
	public MemberVO memberLogin(MemberVO member);
	
	// 주문자 정보
	public MemberVO getMemberInfo(String memberId);
	
}
