package com.mine.service;

import com.mine.model.ReplyDTO;

public interface ReplyService {

	// 댓글등록
	public int enrollReply(ReplyDTO dto);

	// 댓글 존재 체크
	public String checkReply(ReplyDTO dto);
}
