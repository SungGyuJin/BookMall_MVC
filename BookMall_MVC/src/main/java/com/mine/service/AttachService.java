package com.mine.service;

import java.util.List;

import com.mine.model.AttachImageVO;

public interface AttachService {
	
	// 이미지 데이터 반환
	public List<AttachImageVO> getAttachList(int bookId);
	
}
