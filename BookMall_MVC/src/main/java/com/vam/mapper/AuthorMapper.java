package com.vam.mapper;

import java.util.List;

import com.vam.model.AuthorVO;
import com.vam.model.Criteria;

public interface AuthorMapper {

	// 작가등록
	public void authorEnroll(AuthorVO author);
	
	// 작가목록
	public List<AuthorVO> authorGetList(Criteria cri);
	
	// 작가 총 수
	public int authorGetTotal(Criteria cri);
	
	// 작가 상세
	public AuthorVO authorGetDetail(int authorId);
	
	// 작가정보 수정
	public int authorModify(AuthorVO author);
	
	// 작자정보 삭제
	public int authorDelete(int authorId);
	
}
