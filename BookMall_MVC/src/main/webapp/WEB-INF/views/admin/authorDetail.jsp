<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/script_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/admin/authorDetail.css">
</head>
<body>
	
								<%@include file="../includes/admin/header.jsp" %>
								
			<div class="admin_content_wrap">
				<div class="admin_content_main">
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
											<input class="input_block" name="authorName" readonly="readonly"
												value="<c:out value='${authorInfo.authorName}'/>">
									</div>
							</div>
							<div class="form_section">
									<div class="form_section_title">
											<label>소속국가</label>
									</div>
									<div class="form_section_content">
											<select class="input_block" name="nationId">
													<option value="01" disabled="disabled" <c:out value="${authorInfo.nationId eq '01' ?' selected':''}"/>>국내</option>
													<option value="02" disabled="disabled" <c:out value="${authorInfo.nationId eq '02' ?' selected':''}"/>>국외</option>
											</select>
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
									<button id="modifyBtn" class="btn modify_btn">수정</button>
									<button id="cancelBtn" class="btn">작가목록</button>
							</div>
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
	
	// 작가 관리 페이지 이동 버튼
	$("#cancelBtn").on("click", function(e){
		
		e.preventDefault();
		
		$("input[name=authorId]").remove();
		moveForm.attr("action", "/admin/authorManage");
		moveForm.submit();
	});
	
	// 작가 수정 페이지 이동 버튼
	$("#modifyBtn").on("click", function(e){
		
		e.preventDefault();
		
		moveForm.attr("action", "/admin/authorModify");
		moveForm.submit();
	});
	
	
	
	
	
	
	
</script>
	
	
</body>
</html>