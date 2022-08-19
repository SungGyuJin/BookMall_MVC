<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="includes/script_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/search.css">
</head>
<body>
<div class="wrapper">
	<div class="wrap">
			<div class="top_gnb_area div_head">
			 	<!-- 로그인 X -->
				<c:if test="${member == null}">
					<div class="div_left">
						<form id="login_form" method="post">
							<input class="id_input" name="memberId" placeholder="ID" />
							<input type="password" class="pw_input" name="memberPw" placeholder="PW" />
							<input type="hidden" name="pageName" value="search" readonly="readonly">
							<input type="hidden" name="pageParam" value="searchParam" readonly="readonly">
							<input type="button" id="login_button" value="로그인" />
							<c:if test="${result == 0 }">
							<span class="login_warn">로그인 실패<span>
							</c:if>
						</form>
					</div>
					<div class="div_right">
						<a href="/member/join">회원가입</a>&nbsp;&nbsp;
						<a href="/">메인페이지</a>&nbsp;&nbsp;
					</div>
				</c:if>
				<!-- 로그인 O -->
				<c:if test="${member != null}">
						<c:if test="${member.adminCk == 1}">
							<div class="div_left">
								관리자계정으로 로그인하셨습니다.
							</div>
							<div class="div_right">
								<a href="/admin/bookEnroll">관리자페이지</a>&nbsp;&nbsp;
								<a id="gnb_logout_button">로그아웃</a>&nbsp;&nbsp;
								<a href="/">메인페이지</a>
							</div>
						</c:if>
						<c:if test="${member.adminCk == 0}">
							<div class="div_left">
								${member.memberName} |
								<fmt:formatNumber value="${member.money}" pattern="#,###"/> 원 |
								<fmt:formatNumber value="${member.point}" pattern="#,###"/> P
							</div>
							<div class="div_right">
								<a id="gnb_logout_button">로그아웃</a>&nbsp;&nbsp;
								<a href="/cart/${member.memberId}">장바구니</a>&nbsp;&nbsp;
								<a href="/">메인페이지</a>
							</div>
						</c:if>
				</c:if>
			</div>
			<hr>
			<div class="top_area">
				<!-- 로고영역 -->
				<div class="logo_area">
					<a href="/main"><img src="/resources/img/theBook.png"></a>
				</div>
				<div class="search_area">
					<div class="search_wrap">
						<form id="searchForm" action="/search" method="get">
							<div class="search_input">
								<select name="type">
									<option value="T" selected>제목</option>
									<option value="A">작가</option>
								</select>
								<input type="text" name="keyword" placeholder="검색어를 입력해주세요" value="<c:out value='${pageMaker.cri.keyword}'/>">
								<button class="btn search_btn">🔍</button>
							</div>					
						</form>
					</div>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="content_area">
				
				<!-- 게시물 O -->
				<c:if test="${listcheck != 'empty'}">
				
					<div class="search_filter">
					<hr>
							<div class="filter_button_wrap">
									<button class="filter_button filter_active" id="filter_button_a">국내도서</button>
									<button class="filter_button" id="filter_button_b">외국도서</button>
							</div>
							<div class="filter_content filter_a">
								<c:forEach items="${filter_info}" var="filter">
									<c:if test="${filter.cateGroup eq '1'}">
										<a href="${filter.cateCode}">${filter.cateName}(${filter.cateCount})</a>
									</c:if>
								</c:forEach>
							</div>
							<div class="filter_content filter_b">
								<c:forEach items="${filter_info}" var="filter">
									<c:if test="${filter.cateGroup eq '2'}">
										<a href="${filter.cateCode}">${filter.cateName}(${filter.cateCount})</a>
									</c:if>
								</c:forEach>
							</div>		
							
							<form id="filter_form" action="/search" method="get" >
								<input type="hidden" name="keyword">
								<input type="hidden" name="cateCode">
								<input type="hidden" name="type">
							</form>		
					<hr>
					</div>
					<div class="list_search_result">
					<table class="type_list">
						<colgroup>
							<col width="110">
							<col width="*">
							<col width="120">
							<col width="120">
							<col width="120">
						</colgroup>
						<tbody id="searchList>">
							<c:forEach items="${list}" var="list">
								<tr>
									<td class="image">
										<div class="image_wrap" data-bookid="${list.imageList[0].bookId}" data-path="${list.imageList[0].uploadPath}" data-uuid="${list.imageList[0].uuid}" data-filename="${list.imageList[0].fileName}">
											<a href="/bookDetail/pageParam=${list.bookId}"><img></a>	
										</div>
									</td>
									<td class="detail">
										<div class="category">
											[${list.cateName}]
										</div>
										<div class="title">
											<a href="/bookDetail/pageParam=${list.bookId}">
												${list.bookName}
											</a>
										</div>
										<div class="author">
											${list.authorName} 지음 | ${list.publisher} | ${list.publeYear}
										</div>
									</td>
									<td class="info">
										<!-- <div class="rating">
											평점(추후 추가)
										</div> -->
									</td>
									<td class="price">
										<div class="org_price">
											<del>
												<fmt:formatNumber value="${list.bookPrice}" pattern="#,### 원"/>
											</del>
										</div>
										<div class="sell_price">
											<strong>
												<fmt:formatNumber value="${list.bookPrice * (1-list.bookDiscount)}" pattern="#,### 원"/>
											</strong>
										</div>
									</td>
									<td class="option"></td>
								</tr>
							</c:forEach>
						</tbody>
					
					</table>
				</div>
				
				<!-- 페이지 이동 인터페이스 -->
				<div class="pageMaker_wrap">
					<ul class="pageMaker">
	                			
						<!-- 이전 버튼 -->
						<c:if test="${pageMaker.prev }">
	               			<li class="pageMaker_btn prev">
	               				<a href="${pageMaker.pageStart -1}">이전</a>
	               			</li>
						</c:if>
	               			
	               		<!-- 페이지 번호 -->
	               		<c:forEach begin="${pageMaker.pageStart }" end="${pageMaker.pageEnd }" var="num">
	               			<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active':''}">
	               				<a href="${num}">${num}</a>
	               			</li>	
	               		</c:forEach>
	               		
	                   	<!-- 다음 버튼 -->
	                   	<c:if test="${pageMaker.next}">
	                   		<li class="pageMaker_btn next">
	                   			<a href="${pageMaker.pageEnd + 1 }">다음</a>
	                   		</li>
	                   	</c:if>
					</ul>
				</div>
				
				<form id="moveForm" action="/search" method="get" >
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
					<input type="hidden" name="cateCode" value="<c:out value="${pageMaker.cri.cateCode}"/>">
					<input type="hidden" name="type" value="${pageMaker.cri.type}">
				</form>
				
				
				</c:if>
				<!-- 게시물 X -->
				<c:if test="${listcheck == 'empty'}">
					<div class="table_empty">
						검색결과가 없습니다.
					</div>
				</c:if>
			</div>
			<br><br>
			<!-- Footer 영역 -->
			<div class="footer_nav">
				<div class="footer_nav_container">
					<ul>
						<li>회사소개</li>
						<li>이용약관</li>
						<li>광고문의</li>
						<li>고객센터</li>
					</ul>
				</div>
			</div>	<!-- class="footer_nav" -->
			
			<div class="footer">
				<div class="footer_container">
					<div class="footer_left">
						<!-- 이미지파일 -->
					</div>
					<div class="footer_right">
						(주) The BooK 대표 : 성OO
						<br>
						사업자등록번호 : OOO-OO-OOOOO
						<br>
						대표전화 : OOO-OOOO (발신자 부담전화)
						<br>
						<br>
						COPYRIGHT(C) <strong>thebook.com</strong>	ALL RIGHTS RESERVED.
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			
	</div>	<!-- .wrap end -->
</div>	<!-- .wrapper end -->

<script>
// 로그인 버튼 클릭 메소드
$("#login_button").click(function() {

	// alert("로그인 버튼 작용");

	// 로그인 메서드 서버 요청
	$("#login_form").attr("action", "/member/login.do");
	$("#login_form").submit();
});
	
$(document).ready(function(){
	
	/* // 검색 타입 selected
	const selectedType = '<c:out value="${pageMaker.cri.type}"/>';
	if(selectedType != ""){
		$("select[name='type']").val(selectedType).attr("selected", "selected");
	} */
	
	// 이미지 삽입
	$(".image_wrap").each(function(i, obj){
		
		const bobj = $(obj);
		
		if(bobj.data("bookid")){
			
			const uploadPath = bobj.data("path");
			const uuid = bobj.data("uuid");
			const fileName = bobj.data("filename");
			
			const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
			
			$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
		}else{
			$(this).find("img").attr('src', '/resources/img/bookNoImage.png');
		}
		
		
	});
	
	
	
});
	
	// gnb-area 로그아웃 버튼작동
	$("#gnb_logout_button").click(function(){
		
		// alert("버튼 작동");
		
		$.ajax({
			
			type: "POST",
			url: "/member/logout.do",
			success: function(data){
				document.location.reload();
			}
			
		}); // ajax
		
	});
	
	// 페이지 이동 버튼
	const moveForm = $('#moveForm');
	
	$(".pageMaker_btn a").on("click", function(e){
	
		e.preventDefault();
		
		moveForm.find("input[name='pageNum']").val($(this).attr("href"));
		
		moveForm.submit();
		
	});

	// 검색필터
	let buttonA = $("#filter_button_a");
	let buttonB = $("#filter_button_b");

	buttonA.on("click", function(){
		
		$(".filter_b").css("display", "none");
		$(".filter_a").css("display", "block");
		buttonA.attr("class", "filter_button filter_active");
		buttonB.attr("class", "filter_button");
	});
	
	buttonB.on("click", function(){
			
		$(".filter_a").css("display", "none");
		$(".filter_b").css("display", "block");
		buttonB.attr("class", "filter_button filter_active");
		buttonA.attr("class", "filter_button");
	});
	
	// 필터링 태그 동작
	$(".filter_content a").on("click", function(e){
		
		e.preventDefault();
		
		let type = '<c:out value="${pageMaker.cri.type}"/>';
		if(type === 'A' || type === 'T'){
			type = type + 'C';	
		}
		let keyword = '<c:out value="${pageMaker.cri.keyword}"/>';
		let cateCode= $(this).attr("href");
		
		$("#filter_form input[name='keyword']").val(keyword);
		$("#filter_form input[name='cateCode']").val(cateCode);
		$("#filter_form input[name='type']").val(type);
		$("#filter_form").submit();
	});

	
	$(".search_btn").click(function(){
		if($("input[name=keyword]").val() == ""){
			alert("검색어를 입력해주세요");		
			return false;
		}
	});
	
</script>
</body>
</html>