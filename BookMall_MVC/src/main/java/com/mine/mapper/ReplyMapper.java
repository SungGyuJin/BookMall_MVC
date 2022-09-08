package com.mine.mapper;

import java.util.List;

import com.mine.model.Criteria;
import com.mine.model.ReplyDTO;
import com.mine.model.UpdateReplyDTO;

public interface ReplyMapper {

	// 댓글등록
	public int enrollReply(ReplyDTO dto);
	
	// 댓글 존재 체크
	public Integer checkReply(ReplyDTO dto);
	
	// 댓글 페이징
	public List<ReplyDTO> getReplyList(Criteria cri);
	
	// 댓글 총 갯수
	public int getReplyTotal(int bookId);
	
	// 댓글 수정
	public int updateReply(ReplyDTO dto);
	
	// 댓글 수정페이지
	public ReplyDTO getUpdateReply(int replyId);
	
	// 댓글 삭제
	public int deleteReply(int replyId);
	
	// 평점평균 계산
	public Double getRatingAverage(int bookId);
	
	// 평점평균 반영
	public int updateRating(UpdateReplyDTO dto);
	
}
