package com.mine.service;

import org.springframework.stereotype.Service;

import com.mine.model.ReplyDTO;

@Service
public interface ReplyService {

	// 댓글등록
	public int enrollReply(ReplyDTO dto);
	
}
