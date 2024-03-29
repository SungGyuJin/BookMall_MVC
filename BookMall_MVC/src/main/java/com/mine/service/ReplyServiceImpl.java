package com.mine.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mine.mapper.ReplyMapper;
import com.mine.model.Criteria;
import com.mine.model.PageDTO;
import com.mine.model.ReplyDTO;
import com.mine.model.ReplyPageDTO;
import com.mine.model.UpdateReplyDTO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper rMapper;

	// 댓글등록
	@Override
	public int enrollReply(ReplyDTO dto) {

		int result = rMapper.enrollReply(dto);
		
		setRating(dto.getBookId());

		return result;
	}

	@Override
	public String checkReply(ReplyDTO dto) {
		
		Integer result = rMapper.checkReply(dto);
		
		if(result == null) {
			return "0";
		} else {
			return "1";
		}
	}

	@Override
	public ReplyPageDTO replyList(Criteria cri) {
		
		ReplyPageDTO rdto = new ReplyPageDTO();
		
		rdto.setList(rMapper.getReplyList(cri));
		rdto.setPageInfo(new PageDTO(cri, rMapper.getReplyTotal(cri.getBookId())));
		
		return rdto;
	}

	@Override
	public int updateReply(ReplyDTO dto) {
		
		int result = rMapper.updateReply(dto);
		
		setRating(dto.getBookId());
		
		return result;
	}

	@Override
	public ReplyDTO getUpdateReply(int replyId) {
		return rMapper.getUpdateReply(replyId);
	}

	@Override
	public int deleteReply(ReplyDTO dto) {

		int result = rMapper.deleteReply(dto.getReplyId());
		
		setRating(dto.getBookId());
		
		return result;
	}
	
	public void setRating(int bookId) {
		
		Double ratingAvg = rMapper.getRatingAverage(bookId);
		
		if(ratingAvg == null) {
			ratingAvg = 0.0;
		}
		
		ratingAvg = (double) (Math.round(ratingAvg*10));
		ratingAvg = ratingAvg / 10;
		
		UpdateReplyDTO urd = new UpdateReplyDTO();
		
		urd.setBookId(bookId);
		urd.setRatingAvg(ratingAvg);
		
		rMapper.updateRating(urd);
	}

}
