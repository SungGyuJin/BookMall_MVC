package com.mine.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mine.model.ReplyDTO;
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
}
