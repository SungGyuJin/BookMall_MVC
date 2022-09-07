package com.mine.service;

import com.mine.model.Criteria;
import com.mine.model.ReplyDTO;
import com.mine.model.ReplyPageDTO;

public interface ReplyService {

	// 댓글등록
	public int enrollReply(ReplyDTO dto);

	// 댓글 존재 체크
	public String checkReply(ReplyDTO dto);
	
	// 댓글 페이징
	public ReplyPageDTO replyList(Criteria cri);
	
	// 댓글수정
	public int updateReply(ReplyDTO dto);
	
	// 댓글 수정페이지 
	public ReplyDTO getUpdateReply(int replyId);
	
	// 댓글 삭제
	public int deleteReply(ReplyDTO dto);
}
