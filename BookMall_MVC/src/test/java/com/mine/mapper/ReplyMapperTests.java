package com.mine.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.mine.model.ReplyDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ReplyMapperTests {

	@Autowired
	private ReplyMapper rMapper;
	
	@Test
	public void replyEnroll() {
		
		String id = "admin";
		int bookId = 1;
		double rating = 3.5;
		String content = "reply test";
		
		ReplyDTO dto = new ReplyDTO();
		
		dto.setBookId(bookId);
		dto.setMemberId(id);
		dto.setRating(rating);
		dto.setContent(content);
		
		rMapper.enrollReply(dto);
		
	}
	
}
