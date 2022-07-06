package com.vam.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.vam.model.AuthorVO;
import com.vam.model.Criteria;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class AuthorMapperTests {

	@Autowired
	private AuthorMapper mapper;
	
	// 작가등록 테스트
//	@Test
//	public void authorEnroll() throws Exception{
//		
//		AuthorVO author = new AuthorVO();
//		
//		author.setNationId("01");
//		author.setAuthorName("테스트");
//		author.setAuthorIntro("테스트 소개");
//		
//		mapper.authorEnroll(author);
//	}
	
	// 작가목록 테스트
//	@Test
//	public void authorGetListTest() throws Exception{
//		
//		Criteria cri = new Criteria(3,10);	// 3페이지 & 10개 행 표시
//		
//		cri.setKeyword("유홍준");
//		
//		List<AuthorVO> list = mapper.authorGetList(cri);
//		
//		for(int i = 0; i < list.size(); i++) {
//			System.out.println("list" + i + "........." + list.get(i));
//		}
//	}
	// 작가 총 수
//	@Test
//	public void authorGetTotalTest() throws Exception{
//		
//		Criteria cri = new Criteria();
//		cri.setKeyword("테스트");
//		
//		int total = mapper.authorGetTotal(cri);
//		
//		System.out.println("total......" + total);
//	}
	
	// 작가 상세 페이지
//	@Test
//	public void authorGetDetail() {
//		
//		int authorId = 1;
//		
//		AuthorVO author = mapper.authorGetDetail(authorId);
//		
//		System.out.println("author......" + author);
//	}
	
	// 작가 정보 수정
//	@Test
//	public void authorModifyTest() {
//		
//		AuthorVO author = new AuthorVO();
//		
//		author.setAuthorId(2);
//		
//		author.setAuthorName("수정ㅇㅇ합니다");
//		author.setNationId("01");
//		author.setAuthorIntro("유홍준 수정테스트.");
//		
//		mapper.authorModify(author);
//	}
	
	// 작가정보삭제
//	@Test
//	public void	authorDeleteTest() {
//		
//		int authorId = 3;
//		
//		int result = mapper.authorDelete(authorId);
//		
//		if(result == 1) {
//			System.out.println("삭제완료.");
//		}
//	}
	
	
	
	
	
}
