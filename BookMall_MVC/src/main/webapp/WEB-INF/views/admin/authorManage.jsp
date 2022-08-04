<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/admin/authorManage.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous">
</script>
</head>
<body>


				<%@include file="../includes/admin/header.jsp" %>
	
				<div class="admin_content_wrap">
					<div class="admin_content_subject"><span>작가관리</span></div>
					
					<div class="author_table_wrap">
						<!-- 게시물 O -->
						<c:if test="${listCheck != 'empty'}">
							<table class="author_table">
								<thead>
								
									<tr>
										<td class="th_column_1">작가번호</td>
										<td class="th_column_2">작가이름</td>
										<td class="th_column_3">소속국가</td>
										<td class="th_column_4">등록일</td>
										<td class="th_column_5">수정일</td>
									</tr>
								</thead>
								<c:forEach items="${list}" var="list">
									<tr>
										<td><c:out value="${list.authorId}"/> </td>
										<td>
											<a class="move" href='<c:out value="${list.authorId}"/>'>
												<c:out value="${list.authorName}"/>
											</a>
										</td>
										<td><c:out value="${list.nationName}"/> </td>
										<td><fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd"/></td>
										<td><fmt:formatDate value="${list.updateDate}" pattern="yyyy-MM-dd"/></td>
									</tr>
								</c:forEach>
							</table>
						</c:if>
						
						<!-- 게시물 X -->
						<c:if test="${listCheck == 'empty'}">
							<div class="table_empty">
								등록된 작가가 없습니다.
							</div>
						</c:if>
					</div>
					
					<!-- 검색 영역 -->
					<div class="search_wrap">
						<form id="searchForm" action="/admin/authorManage" method="get">
							<div class="search_input">
								<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
								<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'>
								<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
								<button class='btn search_btn'>검색</button>
							</div>
						</form>
					</div>
					
					<!-- 페이지 이동 인터페이스 영역 -->
					<div class="pageMaker_wrap">
						
							<ul class="pageMaker">
								
								<!-- 이전 버튼 -->
								<c:if test="${pageMaker.prev}">
									<li class="pageMaker_btn prev">
										<a href="${pageMaker.pageStart - 1}">이전</a>
									</li>
								</c:if>
								
								<!-- 페이지 번호 -->
								<c:forEach begin="${pageMaker.pageStart}" end="${pageMaker.pageEnd}" var="num">
									<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? "active":""}">
										<a href="${num}">${num}</a>
									</li>
								</c:forEach>
								
								<!-- 다음버튼 -->
								<c:if test="${pageMaker.next}">		
									<li class="pageMaker_btn next">
										<a href="${pageMaker.pageEnd + 1}">다음</a>
									</li>
								</c:if>
							</ul>
					</div>
					
					<form id="moveForm" action="/admin/authorManage" method="get">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
						<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
					</form>
					
				</div>
				<!-- Modal 추가 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				 aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
								 aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Modal title</h4>
							</div>
							<div class="modal-body">처리가 완료되었습니다.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-primary">Save Changes</button>
							</div>
						</div> <!-- .modal-content -->
					</div><!-- .modal-dialog -->
				</div><!-- .modal -->
				<%@include file="../includes/admin/footer.jsp" %>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		var result = ;
		
		checkModal(result);
		
		function checkModal(result){
			
			if(result === ''){
				
				return;
			}
			
			if(parseInt(result) > 0){
				$(".modal-body").html("게시글" + parseInt(result) + "번이 등록되었습니다.");
			}
			
			$("#myModal").modal("show");
			
			
		}
	});
	
</script>
<script>
	
	$(document).ready(function(){
		
		let result = '<c:out value="${enroll_result}"/>';
		let mresult = '<c:out value="${modify_result}"/>';
		
		checkResult(result);
		checkmResult(mresult);
		
		function checkResult(result){
			
			if(result === ''){
				return;
			}
			
			alert("작가 '${enroll_result}' 을 등록하였습니다.");
		}
		
		function checkmResult(mresult){
			
			if(mresult === '1'){
				alert("작가정보 수정완료.");
			}else if(mresult === '0'){
				alert("작가정보 수정실패.");
			}
		}
		
		// 삭제완료 이벤트
		let delete_result = '${delete_result}';
		
		if(delete_result == 1){
			alert("삭제완료.");
		}else if(delete_result == 2){
			alert("삭제불가.");
		}
	});
	
	let moveForm = $('#moveForm');
	let searchForm = $('#searchForm');
	
	// 페이지 이동버튼
	$(".pageMaker_btn a").on("click", function(e){
		
		e.preventDefault();
		
		moveForm.find("input[name='pageNum']").val($(this).attr("href"));
		
		moveForm.submit();
	});
	
	// 작가검색
	$("#searchForm button").on("click", function(e){
		
		e.preventDefault();
		
		// 검색키워드 유효성 검사
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하십시오.");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		
		searchForm.submit();
	});
	
	// 작가 상세페이지 이동
	$(".move").on("click", function(e){
		
		e.preventDefault();
		
		moveForm.append("<input type='hidden' name='authorId' value='" + $(this).attr("href") + "'>");
		moveForm.attr("action", "/admin/authorDetail");
		moveForm.submit();
	});
	
	
	
	
	
	
	
	
	
	
</script>
</body>
</html>