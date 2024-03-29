package com.mine.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mine.model.MemberVO;
import com.mine.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping(value = "/member")
public class MemberController {

	@Autowired
	private MemberService memberservice;

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private BCryptPasswordEncoder pwEncoder;

	// 가입페이지 이동
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public void joinGET() {

		log.info("회원가입페이지 진입");

	}

	// 회원가입
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPOST(MemberVO member) throws Exception {

		String rawPw = ""; 		// 인코딩 전 PW
		String encodePw = ""; 	// 인코딩 후 PW

		rawPw = member.getMemberPw(); 		// 인코딩 전 PW
		encodePw = pwEncoder.encode(rawPw); // PW 인코딩
		member.setMemberPw(encodePw); 		// 인코딩된 PW member 객체에 저장

		// 회원가입완료
		memberservice.memberJoin(member);

		return "redirect:/main";
	}

	// 로그인페이지 이동
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void loginGET() {

		log.info("로그인페이지 진입");
	}

	// ID 중복검사
	@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPOST(String memberId) throws Exception {

		int result = memberservice.idCheck(memberId);

		if (result != 0) {

			return "fail"; // 중복ID 존재 O
		} else {

			return "success"; // 중복ID 존재 X
		}
	}

	@RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String email) throws Exception {

		// View로부터 넘어온 데이터 확인
		log.info("이메일 데이터 전송 확인");
		log.info("인증번호: " + email);

		// 인증번호
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;

		log.info("인증번호: " + checkNum);

		String setFrom = "vkdnjwkrk3@gmail.com";
		String toMail = email;
		String title = "회원가입 인증 이메일 입니다.";
		String content = "홈페이지 방문을 환영합니다." + "<br><br>" + "인증번호는 " + checkNum + "입니다." + "<br>" + "인증번호 입력란에 입력해주세요.";

		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

		String num = Integer.toString(checkNum);

		return num;
	}

	// 로그인
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception {

		HttpSession session = request.getSession();
		String pageParam = request.getParameter("pageParam");
		String pageName = request.getParameter("pageName");

		String rawPw = "";
		String encodePw = "";

		MemberVO lvo = memberservice.memberLogin(member); // 제출한 아이디와 일치하는 아이디가 있는가?

		if (lvo != null) { // 일치하는 아이디 존재시

			rawPw = member.getMemberPw(); // 사용자가 제출한 비번
			encodePw = lvo.getMemberPw(); // DB에 저장한 인코딩된 비번

			if (true == pwEncoder.matches(rawPw, encodePw)) { // 비번 일치여부 판단

				lvo.setMemberPw(""); // 인코딩된 비번 정보 지움
				session.setAttribute("member", lvo); // session에 사용자의 정보 저장
				if (pageParam.equals("main") || pageName.equals("main")) {
					return "redirect:/main"; // main으로 이동
				} else if (pageName.equals("bookDetail")) {
					return "redirect:/" + pageName + "/pageParam=" + pageParam + ""; // bookDetail으로 이동
				} else if (pageName.equals("search")) {
					return "redirect:/" + pageName + "?type=T&keyword=";
				}
				return "redirect:/main"; // 메인페이지 이동

			} else { // 아이디는 존재하는데 비밀번호가 틀릴시

				rttr.addFlashAttribute("result", 0);
				if (pageParam.equals("main") || pageName.equals("main")) {
					return "redirect:/main";
				} else if (pageName.equals("bookDetail")) {
					return "redirect:/" + pageName + "/pageParam=" + pageParam + "";
				} else if (pageName.equals("search")) {
					return "redirect:/" + pageName + "?type=T&keyword=";
				}

				return "redirect:/main";
			}

		} else { // 아이디자체가 존재하지 않을시 로그엔 페이지로 이동

			rttr.addFlashAttribute("result", 0);
			if (pageParam.equals("main") || pageName.equals("main")) {
				return "redirect:/main";
			} else if (pageName.equals("bookDetail")) {
				return "redirect:/" + pageName + "/pageParam=" + pageParam + "";
			} else if (pageName.equals("search")) {
				return "redirect:/" + pageName + "?type=T&keyword=";
			}

			return "redirect:/main";
		}

	}

	// 메인페이지 로그아웃
	/*
	 * @RequestMapping(value="logout.do", method=RequestMethod.GET) public String
	 * logoutMainGET(HttpServletRequest request) throws Exception{
	 * 
	 * log.info("logoutMainGET 메서드 진입");
	 * 
	 * System.out.println("logoutMainGET 메서드 진입");
	 * 
	 * HttpSession session = request.getSession();
	 * 
	 * session.invalidate();
	 * 
	 * return "redirect:/main";
	 * 
	 * }
	 */

	@RequestMapping(value = "logout.do", method = RequestMethod.POST)
	@ResponseBody
	public void logoutPOST(HttpServletRequest request) throws Exception {

		HttpSession session = request.getSession();

		session.invalidate();

	}

}
