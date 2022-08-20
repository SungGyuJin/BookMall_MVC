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
							<input class="id_input" name="memberId" placeholder="ID"> 
							<input type="password" class="pw_input" name="memberPw" placeholder="PW"> 
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

	});
	
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
			alert("장바구니에 추가를 하지 못하였습니다.");
		} else if (result == '1') {
			alert("장바구니에 추가되었습니다.");
		} else if (result == '2') {
			alert("장바구니에 이미 추가되어 있습니다.");
		} else if (result == '5') {
			alert("로그인이 필요합니다.");
		}
	}

	// 구매 버튼
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
	
</script>
</body>
</html>