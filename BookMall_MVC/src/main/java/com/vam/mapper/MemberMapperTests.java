package com.vam.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.vam.model.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class MemberMapperTests {

	@Autowired
	private MemberMapper membermapper;
	
	// 회원가입 쿼리 테스트 메서트
//	@Test
//	public void memberJoin() throws Exception{
//		
//		MemberVO member = new MemberVO();
//		
//		member.setMemberId("sys");
//		member.setMemberPw("1234");
//		member.setMemberName("spring_join_test");
//		member.setMemberMail("spring_join_test");
//		member.setMemberAddr1("spring_join_test");
//		member.setMemberAddr2("spring_join_test");
//		member.setMemberAddr3("spring_join_test");
//		
//		membermapper.memberJoin(member);
//	}
	
//	@Test
//	public void memberIdChk() throws Exception{
//		
//		String id = "admin"; // 존재 O
//		String id2 = "test123"; // 존재 X
//		
//		membermapper.idCheck(id);
//		membermapper.idCheck(id2);
//	}
	
	@Test
	public void memberLogin() throws Exception{
		
		MemberVO member = new MemberVO();
		
		member.setMemberId("test3");
		member.setMemberPw("test3");
		
		membermapper.memberLogin(member);
		System.out.println("결과 값 : " + membermapper.memberLogin(member));
	}
}
