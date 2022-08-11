package com.mine.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mine.mapper.AdminMapper;
import com.mine.mapper.AttachMapper;
import com.mine.mapper.BookMapper;
import com.mine.model.AttachImageVO;
import com.mine.model.BookVO;
import com.mine.model.CateFilterDTO;
import com.mine.model.CateVO;
import com.mine.model.Criteria;
import com.mine.model.SelectDTO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BookServiceImpl implements BookService{

	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
	private AdminMapper adminMapper;
	
	// 상품검색
	@Override
	public List<BookVO> getGoodsList(Criteria cri) {

		log.info("getGoodsList()......");

		String type = cri.getType();
		String[] typeArr = type.split("");
		String[] authorArr = bookMapper.getAuthorIdList(cri.getKeyword());
		
		
		if(type.equals("A") || type.equals("AC") || type.equals("AT") || type.equals("ACT")) {
			if(authorArr.length == 0) {
				return new ArrayList();
			}
		}
		
		for(String t : typeArr) {
			if(t.equals("A")) {
				cri.setAuthorArr(authorArr);
			}
		}
		
		List<BookVO> list = bookMapper.getGoodsList(cri);
		
		list.forEach(book -> {
			
			int bookId = book.getBookId();
			
			List<AttachImageVO> imageList = attachMapper.getAttachList(bookId);
			
			book.setImageList(imageList);
			
		});
		
		return list;
	}

	// 상품 총 갯수
	@Override
	public int goodsGetTotal(Criteria cri) {

		log.info("goodsGetTotal()......");
		
		return bookMapper.goodsGetTotal(cri);
	}

	@Override
	public List<CateVO> getCateCode1() {

		log.info("getCateCode1()......");
		
		return bookMapper.getCateCode1();
	}

	@Override
	public List<CateVO> getCateCode2() {

		log.info("gotCateCode2()......");
		
		return bookMapper.getCateCode2();
	}

	// 검색결과 카테고리 필터정보
	@Override
	public List<CateFilterDTO> getCateInfoList(Criteria cri) {

			
			List<CateFilterDTO> filterInfoList = new ArrayList<CateFilterDTO>();
			
			String[] typeArr = cri.getType().split("");
			String [] authorArr;
			
			for(String type : typeArr) {
				if(type.equals("A")) {
					authorArr = bookMapper.getAuthorIdList(cri.getKeyword());
					if(authorArr.length == 0) {
						
						return filterInfoList;
					}
					cri.setAuthorArr(authorArr);
				}
			}
			
			String[] cateList = bookMapper.getCateList(cri);
			
			String tempCateCode = cri.getCateCode();
			
			for(String cateCode : cateList) {
				
				cri.setCateCode(cateCode);
				CateFilterDTO filterInfo = bookMapper.getCateInfo(cri);
				filterInfoList.add(filterInfo);
			}
			
			cri.setCateCode(tempCateCode);
		
			return filterInfoList;
	}
	
	@Override
	public BookVO getGoodsInfo(int bookId) {
		
		BookVO goodsInfo = bookMapper.getGoodsInfo(bookId);
		goodsInfo.setImageList(adminMapper.getAttachInfo(bookId));

		
		return goodsInfo;
	}

	@Override
	public List<SelectDTO> likeSelect() {
		
		List<SelectDTO> list = bookMapper.likeSelect();
		
		list.forEach(dto ->{
			
			int bookId = dto.getBookId();
			
			List<AttachImageVO> imageList = attachMapper.getAttachList(bookId);
			
			dto.setImageList(imageList);
			
		});
		
		return list;
	}	
	
	
	

}
