package com.mine.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mine.model.Criteria;
import com.mine.model.ReplyDTO;
import com.mine.model.ReplyPageDTO;
import com.mine.service.ReplyService;

@RestController
@RequestMapping("/reply")
public class ReplyController {
	
	@Autowired
	private ReplyService rService;
	
	@PostMapping("/enroll")
	public void enrollReplyPOST(ReplyDTO dto) {
		rService.enrollReply(dto);
	}
	
	@PostMapping("/check")
	public String replyCheckPOST(ReplyDTO dto) {
		return rService.checkReply(dto);
	}
	
	// 댓글 페이징 처리
	@GetMapping(value="/list", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ReplyPageDTO replyListPOST(Criteria cri) {
		return rService.replyList(cri);
	}
	
	// 댓글수정
	@PostMapping("/update")
	public void replyModifyPOST(ReplyDTO dto) {
		rService.updateReply(dto);
	}
	
}
