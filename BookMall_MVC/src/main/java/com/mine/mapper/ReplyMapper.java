package com.mine.mapper;

import com.mine.model.ReplyDTO;

public interface ReplyMapper {

	// 댓글등록
	public int enrollReply(ReplyDTO dto);
	
	// 댓글 존재 체크
	public Integer checkReply(ReplyDTO dto);
}
