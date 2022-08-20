package com.mine.service;

import java.util.List;

import com.mine.model.AttachImageVO;
import com.mine.model.BookVO;
import com.mine.model.CateVO;
import com.mine.model.Criteria;

public interface AdminService {

	// 상품등록
	public void bookEnroll(BookVO book);

	// 카테고리 리스트
	public List<CateVO> cateList();

	// 상품 리스트
	public List<BookVO> bookGetList(Criteria cri);

	/// 상품 총 개수
	public int bookGetTotal(Criteria cri);

	// 상품 조회 페이지
	public BookVO bookGetDetail(int bookId);

	// 상품수정
	public int bookModify(BookVO vo);

	// 상품정보 삭제
	public int bookDelete(int bookId);

	// 지정 상품 이미지 정보 얻기
	public List<AttachImageVO> getAttachInfo(int bookId);
}
