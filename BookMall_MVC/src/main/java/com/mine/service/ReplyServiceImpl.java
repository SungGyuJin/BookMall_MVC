package com.mine.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mine.mapper.ReplyMapper;
import com.mine.model.ReplyDTO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper rMapper;

	@Override
	public int enrollReply(ReplyDTO dto) {

		int result = rMapper.enrollReply(dto);

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

}
