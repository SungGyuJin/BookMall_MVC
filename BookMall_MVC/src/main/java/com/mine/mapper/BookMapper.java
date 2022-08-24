package com.mine.mapper;

import java.util.List;

import com.mine.model.BookVO;
import com.mine.model.CateFilterDTO;
import com.mine.model.CateVO;
import com.mine.model.Criteria;
import com.mine.model.SelectDTO;

public interface BookMapper {

	// 상품검색
	public List<BookVO> getbookList(Criteria cri);

	// 상품 총 갯수
	public int bookGetTotal(Criteria cri);

	// 작가 id 리시트 요청
	public String[] getAuthorIdList(String keyword);

	// 국내 카테고리 리스트
	public List<CateVO> getCateCode1();

	// 외국 카테고리 리스트
	public List<CateVO> getCateCode2();

	// 검색 대상 카테고리 리스트
	public String[] getCateList(Criteria cri);

	// 카테고리 정보(+검색 대상 갯수)
	public CateFilterDTO getCateInfo(Criteria cri);

	// 상품정보
	public BookVO getbookInfo(int bookId);

	// 상품 id
	public BookVO getBookIdName(int bookId);
	
	public List<SelectDTO> likeSelect();

}
