<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/script_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/admin/authorEnroll.css">
</head>
<body>

	<%@include file="../includes/admin/header.jsp"%>

	<div class="admin_content_wrap">
		<div class="admin_content_main">
			<form action="/admin/authorEnroll.do" method="post" id="enrollForm">
				<div class="form_section">
					<div class="form_section_title">
						<label>작가이름</label>
					</div>
					<div class="form_section_content">
						<input name="authorName"> 
						<span id="warn_authorName">작가이름을 입력해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>소속국가</label>
					</div>
					<div class="form_section_content">
						<select name="nationId">
							<option value="none" selected>== 선택 ==</option>
							<option value="01">국내</option>
							<option value="02">국외</option>
						</select> <span id="warn_nationId">소속국적를 선택해주세요.</span>
					</div>
				</div>
			</form>
			<div class="btn_section">
				<button id="enrollBtn" class="btn enroll_btn">등 록</button>
				<button id="cancelBtn" class="btn">취 소</button>
			</div>
		</div>
	</div>

	<%@include file="../includes/admin/footer.jsp"%>

<script type="text/javascript">

		// 버튼 (등록) & 유효성 검사
	$("#enrollBtn").click(function() {
			
		let nameCheck = false; 	 	// 작가이름
		let nationCheck = false; 	// 소속국가

		// 입력값 변수
		let authorName = $('input[name=authorName]').val(); 	// 작가이름
		let nationId = $('select[name=nationId]').val(); 		// 소속국가

		let wAuthorName = $('#warn_authorName');
		let wNationId = $('#warn_nationId');
			
		// 유효성 (작가이름)
		if (authorName === '') {
			wAuthorName.css('display', 'block');
			nameCheck = false;
		} else {
			wAuthorName.css('display', 'none');
			nameCheck = true;
		}
		
		// 유효성 (소속국가)
		if (nationId === 'none') {
			wNationId.css('display', 'block');
			nationCheck = false;
		} else {
			wNationId.css('display', 'none');
			nationCheck = true;
		}

		// 유효성 (최종검사)
		if (nameCheck && nationCheck) {
			$("#enrolForm").submit();
		} else {
			return;
		}
			
		$("#enrollForm").submit();
	});

	// 버튼 (취소)
	$("#cancelBtn").click(function() {
		
		location.href = "/admin/authorManage";
	});
		
</script>
</body>
</html>