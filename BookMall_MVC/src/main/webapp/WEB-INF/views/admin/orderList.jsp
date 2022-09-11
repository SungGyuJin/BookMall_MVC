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
<link rel="stylesheet" href="/resources/css/admin/.css">
</head>
<body>

	<%@include file="../includes/admin/header.jsp"%>

	<div class="admin_content_wrap">
		<div class="admin_content_wrap"><span>주문현황</span></div>
		<div class="author_table_wrap">
			<!-- 게시물 O -->
			<c:if test="${listCheck != 'empty'}">
				<table class="order_table">
	            	<colgroup>
	                	<col width="21%">
	                    <col width="20%">
	                    <col width="20%">
	                    <col width="20%">
	                    <col width="19%%">
	                </colgroup>
	                <thead>
	                	<tr>
	                    	<td class="th_column_1">주문 번호</td>
	                    	<td class="th_column_2">주문 아이디</td>
	                    	<td class="th_column_3">주문 날짜</td>
	                    	<td class="th_column_4">주문 상태</td>
	                    	<td class="th_column_5">취소</td>
	                    </tr>
	                </thead>
	                	<c:forEach items="${list}" var="list">
	                    	<tr>
	                    		<td><c:out value="${list.orderId}"></c:out></td>
	                    		<td><c:out value="${list.memberId}"></c:out></td>
	                    		<td><fmt:formatDate value="${list.orderDate}" pattern="yyyy-MM-dd"/></td>
	                    		<td><c:out value="${list.orderState}"/></td>
	                    		<td>
	                    			<c:if test="${lsit.orderState == '배송준비'}">
	                    				<button class="delete_btn" data-orderid="${list.orderId}">취소</button>
	                    			</c:if>
	                    		</td>
	                    	</tr>
	                    </c:forEach>
	                </table>
			</c:if>

			<!-- 게시물 X -->
			<c:if test="${listCheck == 'empty'}">
				<div class="table_empty">등록된 작가가 없습니다.</div>
			</c:if>
		</div>

		<!-- 검색 영역 -->
		<div class="search_wrap">
			<form id="searchForm" action="/admin/orderList" method="get">
				<div class="search_input">
					<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'> 
					<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'> 
					<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
					<button class='btn search_btn'>검색</button>
				</div>
			</form>
		</div>

		<!-- 페이징 처리 -->
		<div class="pageMaker_wrap">
			<ul class="pageMaker">
				<!-- 이전버튼 -->
				<c:if test="${pageMaker.prev}">
					<li class="pageMaker_btn prev"><a href="${pageMaker.pageStart - 1}">이전</a></li>
				</c:if>

				<!-- 페이지 번호 -->
				<c:forEach begin="${pageMaker.pageStart}" end="${pageMaker.pageEnd}"
					var="num">
					<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? "active":""}">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>

				<!-- 다음버튼 -->
				<c:if test="${pageMaker.next}">
					<li class="pageMaker_btn next"><a href="${pageMaker.pageEnd + 1}">다음</a></li>
				</c:if>
			</ul>
		</div>

		<form id="moveForm" action="/admin/authorManage" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
		</form>
	</div>

	<%@include file="../includes/admin/footer.jsp"%>

<script type="text/javascript">

	let searchForm = $('#searchForm');
	let moveForm = $('#moveForm');
	
	// 버튼 (검색)
	$("#searchForm button").on("click", function(e){
		
		e.preventDefault();
		
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하십시오");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		
		searchForm.submit();
		
	});
	
	
	// 버튼 (페이지 이동)
	$(".pageMaker_btn a").on("click", function(e){
		
		e.preventDefault();
		
		console.log($(this).attr("href"));
		
		moveForm.find("input[name='pageNum']").val($(this).attr("href"));
		
		moveForm.submit();
	});
	
</script>
</body>
</html>