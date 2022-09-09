package com.mine.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mine.mapper.AdminMapper;
import com.mine.model.AttachImageVO;
import com.mine.model.BookVO;
import com.mine.model.CateVO;
import com.mine.model.Criteria;
import com.mine.model.OrderDTO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminMapper adminMapper;

	// 상품등록
	@Transactional
	@Override
	public void bookEnroll(BookVO book) {

		log.info("(service) bookEnroll");

		adminMapper.bookEnroll(book);

		if (book.getImageList() == null || book.getImageList().size() <= 0) {
			return;
		}

		book.getImageList().forEach(attach -> {

			attach.setBookId(book.getBookId());
			adminMapper.imageEnroll(attach);
		});

	}

	@Override
	public List<CateVO> cateList() {

		log.info("(service) cateList......");

		return adminMapper.cateList();
	}

	// 상품리스트
	@Override
	public List<BookVO> bookGetList(Criteria cri) {

		log.info("bookGetTotalList()...");

		return adminMapper.bookGetList(cri);
	}

	// 상품 총 갯수
	@Override
	public int bookGetTotal(Criteria cri) {

		log.info("bookGetTotal()...");

		return adminMapper.bookGetTotal(cri);
	}

	@Override
	public BookVO bookGetDetail(int bookId) {

		log.info("(service) bookGetDetail...");

		return adminMapper.bookGetDetail(bookId);
	}

	// 상품정보 수정
	@Override
	public int bookModify(BookVO vo) {

		int result = adminMapper.bookModify(vo);

		if (result == 1 && vo.getImageList() != null && vo.getImageList().size() > 0) {

			adminMapper.deleteImageAll(vo.getBookId());

			vo.getImageList().forEach(attach -> {

				attach.setBookId(vo.getBookId());
				adminMapper.imageEnroll(attach);
			});

		}

		return result;

	}

	// 상품정보 삭제
	@Override
	@Transactional
	public int bookDelete(int bookId) {

		log.info("bookDelete...");

		adminMapper.deleteImageAll(bookId);

		return adminMapper.bookDelete(bookId);
	}

	// 지정 상품 이미지 정보 얻기
	@Override
	public List<AttachImageVO> getAttachInfo(int bookId) {

		log.info("getAttachInfo......");

		return adminMapper.getAttachInfo(bookId);

	}

	@Override
	public List<OrderDTO> getOrderList(Criteria cri) {
		// TODO Auto-generated method stub
		return null;
	}

	// 주문 총 갯수
	@Override
	public int getOrderTotal(Criteria cri) {
		return adminMapper.getOrderTotal(cri);
	}

}
