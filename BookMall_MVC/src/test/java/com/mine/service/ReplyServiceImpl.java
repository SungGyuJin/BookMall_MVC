package com.mine.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.mine.mapper.ReplyMapper;
import com.mine.model.ReplyDTO;

public class ReplyServiceImpl implements ReplyService{

	@Autowired
	private ReplyMapper rMapper;
	
	@Override
	public int enrollReply(ReplyDTO dto) {
		
		int result = rMapper.enrollReply(dto);
		
		return result;
	}

}
