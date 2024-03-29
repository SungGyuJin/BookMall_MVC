<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/script_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/admin/authorModify.css">
</head>
<body>

	<%@include file="../includes/admin/header.jsp"%>

	<div class="admin_content_wrap">
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
						<input name="authorName"
							value="<c:out value='${authorInfo.authorName}'/>"> <span
							id="warn_authorName">작가이름을 입력해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>소속국가</label>
					</div>
					<div class="form_section_content">
						<select name="nationId">
							<option value="01"
								<c:out value="${authorInfo.nationId eq '01' ?'selected':''}"/>>국내</option>
							<option value="02"
								<c:out value="${authorInfo.nationId eq '02' ?'selected':''}"/>>국외</option>
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
					<button id="modifyBtn" class="btn modify_btn">수정완료</button>
					<button id="cancelBtn" class="btn">취소</button>
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

	<%@include file="../includes/admin/footer.jsp"%>

<script type="text/javascript">

		let moveForm = $("#moveForm");
		let modifyForm = $("#modifyForm");

		// 버튼 (수정완료)
		$("#modifyBtn").on("click", function(e) {

			let authorName = $(".form_section_content input[name='authorName']").val();

			let nameCk = false;

			e.preventDefault();

			if (!authorName) {
				$("#warn_authorName").css("display", "block");
			}else {
				
				$("#warn_authorName").css("display", "none");
				nameCk = true;
			}

			if (nameCk) {
				modifyForm.submit();
			} else {
				return false;
			}
		});
		
		// 버튼 (취소)
		$("#cancelBtn").on("click", function(e) {

			e.preventDefault();

			moveForm.attr("action", "/admin/authorDetail");
			moveForm.submit();
		});

		// 버튼 (삭제)
		$("#deleteBtn").on("click", function(e) {

			e.preventDefault();

			moveForm.find("input").remove();
			moveForm.append('<input type="hidden" name="authorId" value="${authorInfo.authorId}">');
			moveForm.attr("action", "/admin/authorDelete");
			moveForm.attr("method", "post");
			moveForm.submit();
		});
		
</script>
</body>
</html>