package com.mine.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mine.model.AttachImageVO;
import com.mine.model.AuthorVO;
import com.mine.model.BookVO;
import com.mine.model.Criteria;
import com.mine.model.PageDTO;
import com.mine.service.AdminService;
import com.mine.service.AuthorService;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/admin")
@Log4j
public class AdminController {

	@Autowired
	private AuthorService authorService;

	@Autowired
	private AdminService adminService;

	// 도서관리 페이지 접속
	@RequestMapping(value = "bookManage", method = RequestMethod.GET)
	public void bookManageGET(Criteria cri, Model model) throws Exception {

		log.info("도서관리 페이지 접속");

		// 도서 리스트 데이터
		List list = adminService.bookGetList(cri);

		if (!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck", "empty");
			return;
		}

		model.addAttribute("pageMaker", new PageDTO(cri, adminService.bookGetTotal(cri)));
	}

	// 도서등록 페이지 접속
	@RequestMapping(value = "bookEnroll", method = RequestMethod.GET)
	public void bookEnrollGET(Model model) throws Exception {

		log.info("도서등록 페이지 접속");

		ObjectMapper objm = new ObjectMapper();

		List list = adminService.cateList();

		String cateList = objm.writeValueAsString(list);

		model.addAttribute("cateList", cateList);

		log.info("변경 전......" + list);
		log.info("변경 후......" + cateList);

	}

	// 도서조회 페이지
	@GetMapping({ "/bookDetail", "/bookModify" })
	public void bookGetInfoGET(int bookId, Criteria cri, Model model) throws JsonProcessingException {

		log.info("bookGetInfo()..." + bookId);

		ObjectMapper mapper = new ObjectMapper();

		// 카테고리 리스트 데이터
		model.addAttribute("cateList", mapper.writeValueAsString(adminService.cateList()));

		// 목록페이지 조건정보
		model.addAttribute("cri", cri);

		// 조회페이지 정보
		model.addAttribute("bookInfo", adminService.bookGetDetail(bookId));
	}

	// 도서정보 수정
	@PostMapping("/bookModify")
	public String bookModifyPOST(BookVO vo, RedirectAttributes rttr) {

		log.info("bookModifyPOST..." + vo);

		int result = adminService.bookModify(vo);

		rttr.addFlashAttribute("modify_result", result);

		System.out.println("modify_result: " + result);

		return "redirect:/admin/bookManage";

	}

	// 도서정보 삭제
	@PostMapping("/bookDelete")
	public String bookDeletePOST(int bookId, RedirectAttributes rttr) {

		log.info("bookDeletePOST...");
		
		List<AttachImageVO> fileList = adminService.getAttachInfo(bookId);
		
		if(fileList != null) {
			
			List<Path> pathList = new ArrayList();
			
			fileList.forEach(vo -> {
				
				//원본 이미지
				Path path = Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
				pathList.add(path);
				
				// 썸네일 이미지
				path = Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUploadPath() + "_" + vo.getFileName());
				pathList.add(path);
				
			});
			
			pathList.forEach(path ->{
				
				path.toFile().delete();
			});
			
		}

		int result = adminService.bookDelete(bookId);

		rttr.addFlashAttribute("delete_result", result);

		System.out.println("delete_result: " + result);

		return "redirect:/admin/bookManage";
	}

	// 작가등록 페이지 접속
	@RequestMapping(value = "authorEnroll", method = RequestMethod.GET)
	public void authorEnrollGET() throws Exception {

		log.info("작가등록 페이지 접속");

	}

	// 작가관리 페이지 접속
	@RequestMapping(value = "authorManage", method = RequestMethod.GET)
	public void authorManageGET(Criteria cri, Model model) throws Exception {

		log.info("작가관리 페이지 접속......." + cri);

		// 작가목록 출력 데이터
		List list = authorService.authorGetList(cri);

		if (!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck", "empty");
		}

		// 페이지 이동 인터페이스 데이터
		model.addAttribute("pageMaker", new PageDTO(cri, authorService.authorGetTotal(cri)));

	}

	// 작가등록
	@RequestMapping(value = "authorEnroll", method = RequestMethod.POST)
	public String authorEnrollGET(AuthorVO author, RedirectAttributes rttr) throws Exception {

		log.info("authorEnroll : " + author);

		authorService.authorEnroll(author); // 작가등록 쿼리 수행

		rttr.addFlashAttribute("enroll_result", author.getAuthorName()); // 등록성공 메시지(작가이름)

		return "redirect:/admin/authorManage";
	}

	// 작가 상세페이지, 수정페이지
	@GetMapping({ "/authorDetail", "/authorModify" })
	public void authorGetInfoGET(int authorId, Criteria cri, Model model) throws Exception {

		log.info("authorDetail......" + authorId);

		// 작가 관리페이지 정보
		model.addAttribute("cri", cri);

		// 선택 작가정보
		model.addAttribute("authorInfo", authorService.authorGetDetail(authorId));
	}

	// 작가정보 수정
	@PostMapping("/authorModify")
	public String authorModifyPOST(AuthorVO author, RedirectAttributes rttr) throws Exception {

		log.info("authorModifyPOST......" + author);

		int result = authorService.authorModify(author);

		rttr.addFlashAttribute("modify_result", result);

		return "redirect:/admin/authorManage";
	}

	// 작가정보 삭제
	@PostMapping("/authorDelete")
	public String authorDeletePOST(int authorId, RedirectAttributes rttr) {

		log.info("authorDeletePOST...");

		int result = 0;

		try {

			result = authorService.authorDelete(authorId);
		} catch (Exception e) {
			e.printStackTrace();
			result = 2;
			rttr.addFlashAttribute("delete_result", result);

			return "redirect:/admin/authorManage";
		}

		rttr.addFlashAttribute("delete_result", result);

		return "redirect:/admin/authorManage";
	}

	// 도서등록
	@PostMapping("/bookEnroll")
	public String bookEnrollPOST(BookVO book, RedirectAttributes rttr) {

		log.info("bookEnrollPOST......" + book);

		adminService.bookEnroll(book);

		rttr.addFlashAttribute("enroll_result", book.getBookName());

		return "redirect:/admin/bookManage";
	}

	// 작가 검색 팝업창
	@GetMapping("/authorPop")
	public void authorPopGET(Criteria cri, Model model) throws Exception {

		log.info("authorPopGET......");

		cri.setAmount(5);

		// 게시물 출력
		List list = authorService.authorGetList(cri);

		if (!list.isEmpty()) {
			model.addAttribute("list", list); // 작가 존재하는 경우
		} else {
			model.addAttribute("listCheck", "empty"); // 작가 존재하지 않는 경우
		}

		// 페이지이동 인터페이스
		model.addAttribute("pageMaker", new PageDTO(cri, authorService.authorGetTotal(cri)));
	}

	// 첨부파일 업로드
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> uploadAjaxActionPOST(MultipartFile[] uploadFile) {

		log.info("uploadAjaxActionPOST......");
		
		// 이미지 파일체크
		for(MultipartFile multipartFile : uploadFile) {
			
			File checkfile = new File(multipartFile.getOriginalFilename());
			String type = null;
			
			try {
				type = Files.probeContentType(checkfile.toPath());
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			if(!type.startsWith("image")) {
				
				List<AttachImageVO> list = null;
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
				
			}
			
			
		}

		String uploadFolder = "C:\\upload";

		// 날짜 폴더 경로
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();

		String str = sdf.format(date);

		String datePath = str.replace("-", File.separator);

		// 폴더 생성
		File uploadPath = new File(uploadFolder, datePath);

		if (uploadPath.exists() == false) {

			uploadPath.mkdirs();
		}

		// 이미지 정보 담븐 객체
		List<AttachImageVO> list = new ArrayList();
		
		// 향상된 for
		for (MultipartFile multipartFile : uploadFile) {
			
			// 이미지 정보객체
			AttachImageVO vo = new AttachImageVO();

			// 파일이름
			String uploadFileName = multipartFile.getOriginalFilename();
			
			vo.setFileName(uploadFileName);
			vo.setUploadPath(datePath);

			// uuid 적용
			String uuid = UUID.randomUUID().toString();
			vo.setUuid(uuid);

			uploadFileName = uuid + "_" + uploadFileName;

			// 파일위치, 파일 이름을 합친 File 객체
			File saveFile = new File(uploadPath, uploadFileName);

			// 파일저장
			try {
				System.out.println("이미지 저장성공");
				multipartFile.transferTo(saveFile);
				
				/*
				// 썸네일 생성
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				
				BufferedImage bo_image = ImageIO.read(saveFile);
					
					// 비율
					double ratio = 3;
					
					// 넓이, 높이
					int width = (int) (bo_image.getWidth() / ratio);
					int height = (int) (bo_image.getHeight() / ratio);
				
				BufferedImage bt_image = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);
				
				Graphics2D graphic = bt_image.createGraphics();
				
				graphic.drawImage(bo_image, 0, 0, width, height, null);
				
				ImageIO.write(bt_image,  "jpg", thumbnailFile);
				 */
				
				// 방법
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				
				BufferedImage bo_image = ImageIO.read(saveFile);
				
				// 비율
				double ratio = 3;
				
				// 넓이, 높이
				int width = (int) (bo_image.getWidth() / ratio);
				int height = (int) (bo_image.getHeight() / ratio);
				
				Thumbnails.of(saveFile)
				.size(width, height)
				.toFile(thumbnailFile);
				
			} catch (Exception e) {
				
				e.printStackTrace();
				
			}
			
			list.add(vo);
			
		} // end for
		
		ResponseEntity<List<AttachImageVO>> result = new ResponseEntity<List<AttachImageVO>>(list, HttpStatus.OK);
		
		return result;
	}

	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName){
		
		 log.info("deleteFile......" + fileName);
		 
		 File file = null;
		 
		 try {
			 
			 // 썸네일파일 삭제
			 file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			 
			 file.delete();
			 
			 // 원본파일 삭제
			 String originFileName = file.getAbsolutePath().replace("s_", "");
			 
			 log.info("originFileName : " + originFileName);
			 
			 file = new File(originFileName);
			 
			 file.delete();
			 
			 
		 }catch(Exception e) {
			 e.printStackTrace();
			 
			 return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
		 }
		 
		 return new ResponseEntity<String>("success", HttpStatus.OK);
		 
	}
	
	
	
	
	
	
	
	
	
	
}
