package com.mine.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mine.mapper.AttachMapper;
import com.mine.model.AttachImageVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AttachServiceImpl implements AttachService{

	@Autowired
	private AttachMapper attachMapper;
	
	// 이미지 데이터 변환
	@Override
	public List<AttachImageVO> getAttachList(int bookId) {
		
		log.info("getAttachList...");
		
		return attachMapper.getAttachList(bookId);
	}

	
}
