<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/admin/authorModify.css">
</head>
<body>
									<%@include file="../includes/admin/header.jsp" %>
										
					<div class="admin_content_wrap">
						<div class="admin_content_subject"><span>작가수정</span></div>
						<div class="admin_content_main">
							<form id="modifyForm" action="/admin/authorModify" method="post">
											<div class="form_section">
													<div class="form_section_title">
															<label>작가번호</label>
													</div>											
													<div class="form_section_content">
															<input class="input_block" name="authorId" readonly="readonly"
																value="<c:out value='${authorInfo.authorId}'/>">
													</div>
											</div>
											<div class="form_section">
													<div class="form_section_title">
															<label>작가이름</label>
													</div>
													<div class="form_section_content">
															<input name="authorName" value="<c:out value='${authorInfo.authorName}'/>">
															<span id="warn_authorName">작가이름을 입력해주세요.</span>
													</div>
											</div>
											<div class="form_section">
													<div class="form_section_title">
															<label>소속국가</label>
													</div>
													<div class="form_section_content">
															<select name="nationId">
																	<option value="none" disabled="disabled">=== 선택 ===</option>
																	<option value="01" <c:out value="${authorInfo.nationId eq '01' ?'selected':''}"/>>국내</option>
																	<option value="02" <c:out value="${authorInfo.nationId eq '02' ?'selected':''}"/>>국외</option>
															</select>
													</div>
											</div>
											<div class="form_section">
													<div class="form_section_title">
															<label>작가소개</label>
													</div>
													<div class="form_section_content">
															<textarea name="authorIntro"><c:out value='${authorInfo.authorIntro}'/></textarea>
															<span id="warn_authorIntro">작가소개를 입력해주세요.</span>
													</div>
											</div>
											<div class="form_section">
													<div class="form_section_title">
															<label>등록일</label>
													</div>
													<div class="form_section_content">
															<input class="input_block" type="text" readonly="readonly"
																value="<fmt:formatDate value='${authorInfo.regDate}' pattern='yyyy-MM-dd'/>">
													</div>
											</div>
											<div class="form_section">
													<div class="form_section_title">
															<label>수정일</label>
													</div>
													<div class="form_section_content">
															<input class="input_block" type="text" readonly="readonly"
																value="<fmt:formatDate value='${authorInfo.updateDate}' pattern='yyyy-MM-dd'/>">
													</div>
											</div>
											<div class="btn_section">
													<button id="cancelBtn" class="btn">취소</button>
													<button id="modifyBtn" class="btn modify_btn">수정</button>
													<button id="deleteBtn" class="btn delete_btn">삭제</button>
											</div>
							</form>
						</div>
						
					</div>
					
					<form id="moveForm" method="get">
							<input type="hidden" name="authorId" value='<c:out value="${authorInfo.authorId}"/>'>
							<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
							<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
							<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
					</form>
										
										
									<%@include file="../includes/admin/footer.jsp" %>
									
									
									
<script>

	let moveForm = $("#moveForm");
	let modifyForm = $("#modifyForm");
	
	// 작가 상세 페이지 이동 버튼
	$("#cancelBtn").on("click", function(e){
		
		e.preventDefault();
		
		moveForm.attr("action", "/admin/authorDetail");
		moveForm.submit();
		
	});
	
	// 삭제버튼
	$("#deleteBtn").on("click", function(e){
		
		e.preventDefault();
		
		moveForm.find("input").remove();
		moveForm.append('<input type="hidden" name="authorId" value="${authorInfo.authorId}">');
		moveForm.attr("action", "/admin/authorDelete");
		moveForm.attr("method", "post");
		moveForm.submit();
		
	});
	
	// 작가 수정버튼 작동 및 유효성 검사
	$("#modifyBtn").on("click", function(e){
		
		let authorName = $(".form_section_content input[name='authorName']").val();
		let authorIntro = $(".form_section_content textarea").val();
		
		let nameCk = false;
		let introCk = false;
		
		e.preventDefault();
		
		if(!authorName){
			$("#warn_authorName").css("display", "block");
		}else{
			$("#warn_authorName").css("display", "none");
			nameCk = true;
		}
		
		if(!authorIntro){
			$("#warn_authorIntro").css("display", "block");
		}else{
			$("#warn_authroIntro").css("display", "none");
			introCk = true;
		}
		
		if(nameCk && introCk){
			modifyForm.submit();
		}else{
			return false;
		}
	});





</script>
</body>
</html>