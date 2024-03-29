<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/script_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/admin/bookManage.css">
</head>
<body>

	<%@include file="../includes/admin/header.jsp"%>

	<div class="admin_content_wrap">
		<div class="book_table_wrap">
			<!-- 상품 리스트 -->
			<c:if test="${listcheck != 'empty'}">
				<table class="book_table">
					<thead>
						<tr>
							<td class="th_column_1">등록번호</td>
							<td class="th_column_2">도서제목</td>
							<td class="th_column_3">작가</td>
							<td class="th_column_4">장르</td>
							<td class="th_column_5">재고</td>
							<td class="th_column_6">등록날짜</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="list">
							<tr>
								<td><c:out value="${list.bookId}"/></td>
								<td>
									<a class="move" href='<c:out value="${list.bookId}"/>'>
									<c:out value="${list.bookName}"/>
									</a>
								</td>
								<td><c:out value="${list.authorName}"/></td>
								<td><c:out value="${list.cateName}"/></td>
								<td><c:out value="${list.bookStock}"/></td>
								<td><fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			<!-- 상품리스트 X -->
			<c:if test="${listCheck == 'empty'}">
				<div class="table_empty">등록된 도서가 없습니다.</div>
			</c:if>
		</div>
		
		<!-- 검색 영역 -->
		<div class="search_wrap">
			<form id="searchForm" action="/admin/bookManage" method="get">
				<div class="search_input">
					<input type="text" name="keyword"
						value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
					<input type="hidden" name="pageNum"
						value='<c:out value="${pageMaker.cri.pageNum }"></c:out>'>
					<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
					<input type="hidden" name="type" value="G">
					<button class='btn search_btn'>검 색</button>
				</div>
			</form>
		</div>

		<!-- 페이정 처리 -->
		<div class="pageMaker_wrap">
			<ul class="pageMaker">
				<!-- 이전 버튼 -->
				<c:if test="${pageMaker.prev }">
					<li class="pageMaker_btn prev"><a
						href="${pageMaker.pageStart -1}">이전</a></li>
				</c:if>

				<!-- 페이지 번호 -->
				<c:forEach begin="${pageMaker.pageStart}" end="${pageMaker.pageEnd}"
					var="num">
					<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? "active":""}">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>

				<!-- 다음 버튼 -->
				<c:if test="${pageMaker.next}">
					<li class="pageMaker_btn next"><a
						href="${pageMaker.pageEnd + 1 }">다음</a></li>
				</c:if>
			</ul>
		</div>

		<form id="moveForm" action="/admin/bookManage" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
		</form>
	</div>

	<%@include file="../includes/admin/footer.jsp"%>

<script type="text/javascript">

		$(document).ready(function() {
		
			// 이벤트 (등록)
			let eResult = '<c:out value="${enroll_result}"/>';

			checkResult(eResult);

			function checkResult(result) {

				if (result === '') {
					return;
				}

				alert("상품 '" + eResult + "' 을 등록하였습니다.");
			}

			// 이벤트 (수정)
			let modify_result = '${modify_result}';

			if (modify_result == 1) {
				alert("수정완료.");
			}

			// 이벤트 (삭제)
			let delete_result = '${delete_result}';

			if (delete_result == 1) {
				alert("삭제완료.");
			}
		});

		let searchForm = $('#searchForm');
		let moveForm = $('#moveForm');

		// 작가검색 버튼
		$("#searchForm button").on("click", function(e) {

			e.preventDefault();

			// 검색 유효성 검사
			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하십시오.");
				return false;
			}

			searchForm.find("input[name='pageNum']").val("1");
			searchForm.submit();
		});

		// 페이지 이동버튼
		$(".pageMaker_btn a").on("click", function(e) {

			e.preventDefault();

			moveForm.find("input[name='pageNum']").val($(this).attr("href"));
			moveForm.submit();
		});

		// 상품조회 페이지
		$(".move").on("click", function(e) {

			e.preventDefault();

			moveForm.append("<input type='hidden' name='bookId' value='" + $(this).attr("href") + "'>");
			moveForm.attr("action", "/admin/bookDetail");
			moveForm.submit();
		});
		
</script>
</body>
</html>