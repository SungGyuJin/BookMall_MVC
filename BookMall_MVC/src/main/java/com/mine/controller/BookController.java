package com.mine.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mine.mapper.AttachMapper;
import com.mine.model.AttachImageVO;
import com.mine.model.BookVO;
import com.mine.model.Criteria;
import com.mine.model.PageDTO;
import com.mine.model.ReplyDTO;
import com.mine.service.BookService;
import com.mine.service.ReplyService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class BookController {

	@Autowired
	private AttachMapper attachMapper;

	@Autowired
	private BookService bookService;
	
	@Autowired
	private ReplyService replyService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String startMain(Model model) {

		model.addAttribute("cate1", bookService.getCateCode1());
		model.addAttribute("cate2", bookService.getCateCode2());
		model.addAttribute("mainList", bookService.likeSelect());

		return "/main";
	}

	// 메인페이지 이동
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public void mainPageGET(Model model) {

		log.info("main.jsp 진입");

		model.addAttribute("cate1", bookService.getCateCode1());
		model.addAttribute("cate2", bookService.getCateCode2());
		model.addAttribute("mainList", bookService.likeSelect());

	}

	// 이미지 출력
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName) {

		log.info("getImage()" + fileName);

		File file = new File("c:\\upload\\" + fileName);

		ResponseEntity<byte[]> result = null;

		try {

			HttpHeaders header = new HttpHeaders();

			header.add("Content-type", Files.probeContentType(file.toPath()));

			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);

		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;

	}

	// 이미지 정보 반환
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> getAttachList(int bookId) {

		log.info("getAttachList...");

		return new ResponseEntity<List<AttachImageVO>>(attachMapper.getAttachList(bookId), HttpStatus.OK);

	}

	// 도서 검색
	@GetMapping("/search")
	public String searchbookGET(Criteria cri, Model model, HttpServletRequest request) {

		String searchParam = request.getParameter("searchParam");

		model.addAttribute("searchParam", searchParam);

		model.addAttribute("cate1", bookService.getCateCode1());
		model.addAttribute("cate2", bookService.getCateCode2());
		log.info("cri : " + cri);

		List<BookVO> list = bookService.getbookList(cri);
		log.info("pre list : " + list);
		if (!list.isEmpty()) {
			model.addAttribute("list", list);
			log.info("list : " + list);
		} else {
			model.addAttribute("listcheck", "empty");

			return "search";
		}

		model.addAttribute("pageMaker", new PageDTO(cri, bookService.bookGetTotal(cri)));

		String[] typeArr = cri.getType().split("");

		for (String s : typeArr) {
			if (s.equals("T") || s.equals("A") || s.equals("TC")) {
				model.addAttribute("filter_info", bookService.getCateInfoList(cri));
			}
		}

		return "search";

	}

	// 도서상세
	@GetMapping("/bookDetail/pageParam={bookId}")
	public String bookDetailGet(@PathVariable("bookId") int bookId, Model model) {

		log.info("bookDetailGET()......");

		model.addAttribute("buy_chk", bookId);

		model.addAttribute("bookInfo", bookService.getbookInfo(bookId));
		model.addAttribute("pageParam", bookId);

		return "/bookDetail";
	}
	
	// 리뷰쓰기
	@GetMapping("/reply/{memberId}")
	public String replyEnrollWindowGET(@PathVariable("memberId") String memberId, int bookId, Model model) {
		
		BookVO book = bookService.getBookIdName(bookId);
		
		model.addAttribute("bookInfo", book);
		model.addAttribute("memberId", memberId);
		
		return "/reply";
	}
	
	// 리뷰 수정
	@GetMapping("/replyUpdate")
	public String replyUpdateGET(ReplyDTO dto, Model model) {
		
		BookVO book = bookService.getBookIdName(dto.getBookId());
		
		model.addAttribute("bookInfo", book);
		model.addAttribute("replyInfo", replyService.getUpdateReply(dto.getReplyId()));
		model.addAttribute("memberId", dto.getMemberId());
		
		return "/replyUpdate";
	}
	

}
