package com.mine.service;

import java.util.List;

import com.mine.model.BookVO;
import com.mine.model.CateFilterDTO;
import com.mine.model.CateVO;
import com.mine.model.Criteria;
import com.mine.model.SelectDTO;

public interface BookService {

	// 상품검색
	public List<BookVO> getbookList(Criteria cri);

	// 상품 총 갯수
	public int bookGetTotal(Criteria cri);

	// 국내 카테고리 리스트
	public List<CateVO> getCateCode1();

	// 외국 카테고리 리스트
	public List<CateVO> getCateCode2();

	// 검색결과 카테고리 필터정보
	public List<CateFilterDTO> getCateInfoList(Criteria cri);

	// 상품 정보
	public BookVO getbookInfo(int bookId);

	public List<SelectDTO> likeSelect();

}
