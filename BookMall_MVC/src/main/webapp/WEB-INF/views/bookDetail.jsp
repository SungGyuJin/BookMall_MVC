<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="includes/script_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/bookDetail.css">
</head>
<body>
	<div class="wrapper">
		<div class="wrap">
			<div class="top_gnb_area div_head">
				<!-- 로그인 X -->
				<c:if test="${member == null}">
					<div class="div_left">
						<form id="login_form" method="post">
							<input class="id_input" name="memberId" value="guest1" placeholder="ID"> 
							<input type="password" class="pw_input" value="1234" name="memberPw" placeholder="PW"> 
							<input type="hidden" name="pageName" value="bookDetail" readonly="readonly"> 
							<input type="hidden" name="pageParam" value="${pageParam}" readonly="readonly"> 
							<input type="button" id="login_button" value="로그인">
							<c:if test="${result == 0 }">
								<span class="login_warn">로그인 실패<span>
							</c:if>
						</form>
					</div>
					<div class="div_right">
						<a href="/member/join">회원가입</a>&nbsp;&nbsp; <a href="/">메인페이지</a>&nbsp;&nbsp;
					</div>
				</c:if>
				<!-- 로그인 O -->
				<c:if test="${member != null}">
					<c:if test="${member.adminCk == 1}">
						<div class="div_left">관리자계정으로 로그인하셨습니다.</div>
						<div class="div_right">
							<a href="/admin/bookEnroll">관리자페이지</a>&nbsp;&nbsp; <a
								id="gnb_logout_button">로그아웃</a>&nbsp;&nbsp; <a href="/">메인페이지</a>
						</div>
					</c:if>
					<c:if test="${member.adminCk == 0}">
						<div class="div_left">
							${member.memberName} |
							<fmt:formatNumber value="${member.money}" pattern="#,###" /> 원 |
							<fmt:formatNumber value="${member.point}" pattern="#,###" /> P
						</div>
						<div class="div_right">
							<a id="gnb_logout_button">로그아웃</a>&nbsp;&nbsp; <a
								href="/cart/${member.memberId}">장바구니</a>&nbsp;&nbsp; <a href="/">메인페이지</a>
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
									<option value="T">제목</option>
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
				<div class="line"></div>
				<div class="content_top">
					<div class="ct_left_area">
						<div class="image_wrap"
							data-bookid="${bookInfo.imageList[0].bookId}"
							data-path="${bookInfo.imageList[0].uploadPath}"
							data-uuid="${bookInfo.imageList[0].uuid}"
							data-filename="${bookInfo.imageList[0].fileName}">
							<img>
						</div>
					</div>
					<div class="ct_right_area">
						<div class="title">
							<h1>${bookInfo.bookName}</h1>
						</div>
						<div class="line"></div>
						<div class="author">
							<span> ${bookInfo.authorName} 지음</span> 
							<span>|</span> 
							<span>${bookInfo.publisher}</span>
							<span>|</span> 
							<span class="publeyear">${bookInfo.publeYear}</span>
						</div>
						<div class="line"></div>
						<div class="price">
							<div class="sale_price">
								정가 :
								<fmt:formatNumber value="${bookInfo.bookPrice}" pattern="#,### 원" />
							</div>
							<div class="discount_price">
								판매가 : <span class="discount_price_number">
								<fmt:formatNumber
										value="${bookInfo.bookPrice - (bookInfo.bookPrice*bookInfo.bookDiscount)}"
										pattern="#,### 원"/></span> [
								<fmt:formatNumber value="${bookInfo.bookDiscount*100}"
									pattern="###"/>
								%

								<fmt:formatNumber
									value="${bookInfo.bookPrice*bookInfo.bookDiscount}"
									pattern="#,### 원"/>
								할인]
							</div>
						</div>
						<div>
							&nbsp;&nbsp;&nbsp;&nbsp;수량 당 적립 : <span class="point_span"></span>원
						</div>
						<div class="line"></div>
						<div class="button">
							<div class="button_quantity">
								주문수량 <input type="text" class="quantity_input" value="1">
								<span>
									<button class="plus_btn">➕</button>
									<button class="minus_btn">➖</button>
								</span>
							</div>
							<div class="button_set">
								<a class="btn_cart">장바구니 담기</a>
								<a class="btn_buy">구매</a>
							</div>
						</div>
					</div>
				</div>
				<div class="line"></div>
				<div class="content_middle">
					<div class="book_intro">${bookInfo.bookIntro}</div>
					<div class="book_content">${bookInfo.bookContents}</div>
				</div>
				<div class="line"></div>
				<div class="content_bottom">
					<div class="reply_subject">
						<h2>리뷰</h2>
					</div>
					<c:if test="${member != null}">
						<div class="reply_button_wrap">
							<button>리뷰 쓰기</button>
						</div>
					</c:if>
					
					<div class="reply_not_div">
					</div>			
					<ul class="reply_content_ul">
						
					</ul>				
					<div class="reply_pageInfo_div">
						<ul class="pageMaker">
						</ul>
					</div>						
				</div>
				<!-- 주문 form -->
				<form action="/order/${member.memberId}" method="get" class="order_form">
					<input type="hidden" name="orders[0].bookId" value="${bookInfo.bookId}"> 
					<input type="hidden" name="orders[0].bookCount">
					<input type="hidden" name="buy_inputChk" value="${member.memberId}">
				</form>
			</div>

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
			</div>

			<div class="footer">
				<div class="footer_container">
					<div class="footer_left">
						<!-- 이미지파일 -->
					</div>
					<div class="footer_right">
						(주) The BooK 대표 : 성OO <br> 사업자등록번호 : OOO-OO-OOOOO <br>
						대표전화 : OOO-OOOO (발신자 부담전화) <br> <br> COPYRIGHT(C) <strong>thebook.com</strong>
						ALL RIGHTS RESERVED.
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">

	$(document).ready(function() {

		// 이미지 삽입
		const bobj = $(".image_wrap");

		if (bobj.data("bookid")) {

			const uploadPath = bobj.data("path");
			const uuid = bobj.data("uuid");
			const fileName = bobj.data("filename");
			
			const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
	
			bobj.find("img").attr("src", "/display?fileName=" + fileCallPath);
		} else {

			bobj.find("img").attr("src", "/resources/img/bookNoImage.png");
		}
		
		// publeyear
		const year = "${bookInfo.publeYear}";

		let tempYear = year.substr(0, 10);

		let yearArray = tempYear.split("-");
		let publeYear = yearArray[0] + "년 " + yearArray[1] + "월" + yearArray[2] + "일";

		$(".publeyear").html(publeYear);

		// 포인트 삽입
		let salePrice = "${bookInfo.bookPrice - (bookInfo.bookPrice*bookInfo.bookDiscount)}";
		let point = salePrice * 0.05;
		point = Math.floor(point);
		$(".point_span").text(point);
		
		// 리뷰 리스트 출력
		const bookId = '${bookInfo.bookId}';
		
		$.getJSON("/reply/list", {bookId : bookId}, function(obj){
			
			makeReplyContent(obj);
		});

	}); // end $(document)
	
	// 로그인 버튼 클릭 메소드
	$("#login_button").click(function() {

		// 로그인 메서드 서버 요청
		$("#login_form").attr("action", "/member/login.do");
		$("#login_form").submit();
	});

	// 수량 버튼 조절
	let quantity = $(".quantity_input").val();

	$(".plus_btn").on("click", function() {
		$(".quantity_input").val(++quantity);
	});

	$(".minus_btn").on("click", function() {
		if (quantity > 1) {
			$(".quantity_input").val(--quantity);
		}
	});

	// 서버로 전송할 데이터
	const form = {
		memberId : "${member.memberId}",
		bookId : "${bookInfo.bookId}",
		bookCount : ""
	}

	// 장바구니 추가 버튼
	$(".btn_cart").on("click", function(e) {

		if ($("input[name=buy_inputChk]").val() == "admin") {
			alert("관리자계정 이용불가.");
			return false;
		}

		form.bookCount = $(".quantity_input").val();
		
		$.ajax({

			url : "/cart/add",
			type : "POST",
			data : form,
			success : function(result) {
				cartAlert(result);
			}
		});
	});

	function cartAlert(result) {
		
		if (result == '0') {
			alert("장바구니 에러.");
		} else if (result == '1') {
			alert("장바구니 추가완료.");
		} else if (result == '2') {
			alert("장바구니에 이미 추가됨.");
		} else if (result == '3') {
			alert("로그인이 필요합니다.");
		}
	}

	// 버튼 (구매하기)
	$(".btn_buy").on("click", function() {

		let bookCount = $(".quantity_input").val();

		$(".order_form").find("input[name='orders[0].bookCount']").val(bookCount);

			if (!$("input[name=buy_inputChk]").val()) {
				alert("로그인이 필요합니다.");
				return false;
			} else if ($("input[name=buy_inputChk]").val() == "admin") {
				alert("관리자계정 이용불가.");
				return false;
			}
			
			$(".order_form").submit();
	});

	// 버튼 (로그아웃)
	$("#gnb_logout_button").click(function() {
		
		$.ajax({
			
			type : "POST",
			url : "/member/logout.do",
			success : function(data) {
				document.location.reload();
			}
		});
	});

	$(".search_btn").click(function() {
		if ($("input[name=keyword]").val() == "") {
			alert("검색어를 입력해주세요");
			return false;
		}
	});
	
	// 리뷰
	$(".reply_button_wrap").on("click", function(e){
		
		e.preventDefault();
		
		const memberId = '${member.memberId}';
		const bookId = '${bookInfo.bookId}';
		
		if(memberId == "admin"){
			alert("관리자계정 이용불가.");
			return false;
		}
		
		$.ajax({
			data : {
				bookId : bookId,
				memberId : memberId
			},
			url : '/reply/check',
			type : 'POST',
			success : function(result){
				
				if(result === '1'){
					alert("이미 등록하신 리뷰가 존재합니다.");
				}else if(result === '0'){
					let popUrl = "/reply/" + memberId + "?bookId=" + bookId;
					console.log(popUrl);
					let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes";
					
					window.open(popUrl, "리뷰쓰기", popOption);
				}
			}
		});
	});
	
	// 댓글 데이터 서버 요청 및 댓글 동적 생성 메서드
	let replyListInit = function(){
		
		$.getJSON("/reply/list", cri, function(obj){
			
			makeReplyContent(obj);
		});
	}
	
	// 댓글 수정버튼
	$(document).on('click', '.update_reply_btn', function(e){
		
		e.preventDefault();
		
		let replyId = $(this).attr("href");
		let popUrl = "/replyUpdate?replyId=" + replyId + "&bookId=" + '${bookInfo.bookId}' + "&memberId=" + '${member.memberId}';
		let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes";
		
		window.open(popUrl, "리뷰 수정", popOption);
	});
	
	// 댓글 삭제
	$(document).on('click', ".delete_reply_btn", function(e){
		
		e.preventDefault();
		
		let replyId = $(this).attr("href");
		
		$.ajax({
			
			data : {
					replyId : replyId,
					bookId : '${bookInfo.bookId}'
			},
			url : '/reply/delete',
			type : 'POST',
			success : function(result){
				
				replyListInit();
				alert("삭제가 완료되었습니다."	);
			}
		});
	});
	
	// 리뷰 동적 메서드
	function makeReplyContent(obj){
		
		if(obj.list.length === 0){
			$(".reply_not_div").html('<span>리뷰없음</sapn>');
			$(".reply_content_ul").html('');
			$(".pageMaker").html("");
		}else{
			
			$(".reply_not_div").html("");
			
			const list = obj.list;
			const pf = obj.pageInfo;
			const userId = "${member.memberId}";
			
			// list
			let reply_list = '';
			
			$(list).each(function(i, obj){
				
				reply_list += '<li>';
				reply_list += '<div class="comment_wrap">';
				reply_list += '<div class="reply_top">';
				/* 아이디 */
				reply_list += '<span class="id_span">'+ obj.memberId +'</span>';
				/* 날짜 */
				reply_list += '<span class="date_span">'+ obj.regDate +'</span>';
				/* 평점 */
				reply_list += '<span class="rating_span">평점 : <span class="rating_value_span">'+ obj.rating +'</span>점</span>';
				
				if(obj.memberId === userId){
					reply_list += '<a class="update_reply_btn" href="'+ obj.replyId +'">수정</a><a class="delete_reply_btn" href="'+ obj.replyId +'">삭제</a>';
				}
				
				reply_list += '</div>'; //<div class="reply_top">
				reply_list += '<div class="reply_bottom">';
				reply_list += '<div class="reply_bottom_txt">'+ obj.content +'</div>';
				reply_list += '</div>'; //<div class="reply_bottom">
				reply_list += '</div>'; //<div class="comment_wrap">
				reply_list += '</li>';
			});
			
			$(".reply_content_ul").html(reply_list);
			
			// 페이지 버튼
			let reply_pageMaker = '';
			
			// 버튼 (이전)
			if(pf.prev){
				let prev_num = pf.pageStart -1;
				reply_pageMaker += '<li class="pageMaker_btn prev">';
				reply_pageMaker += '<a href="'+ prev_num +'">이전</a>';
				reply_pageMaker += '</li>';	
			}
				
			// 버튼 (숫자)
			for(let i = pf.pageStart; i < pf.pageEnd+1; i++){
				reply_pageMaker += '<li class="pageMaker_btn ';
				if(pf.cri.pageNum === i){
					reply_pageMaker += 'active';
				}
				reply_pageMaker += '">';
				reply_pageMaker += '<a href="'+i+'">'+i+'</a>';
				reply_pageMaker += '</li>';
			}
				
			// 버튼 (다음)
			if(pf.next){
				let next_num = pf.pageEnd +1;
				reply_pageMaker += '<li class="pageMaker_btn next">';
				reply_pageMaker += '<a href="'+ next_num +'">다음</a>';
				reply_pageMaker += '</li>';	
			}		
			
			$(".pageMaker").html(reply_pageMaker);
		}
	}
	
	// 댓 페이지
	const cri = {
			bookId : '${bookInfo.bookId}',
			pageNum : 1,
			amount : 10
	}
	
	$(document).on('click', '.pageMaker_btn a', function(e){
		
		e.preventDefault();
		
		let page = $(this).attr("href");
		cri.pageNum = page;
		
		replyListInit();
	});
	
	
</script>
</body>
</html>