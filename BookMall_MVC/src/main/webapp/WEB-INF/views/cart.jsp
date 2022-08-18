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
<link rel="stylesheet" href="/resources/css/cart.css">
</head>
<body>
<div class="wrapper">
	<div class="wrap">
			<div class="top_gnb_area div_head">
			 	<!-- 로그인 X -->
				<c:if test="${member == null}">
					<div class="div_left">
						<form id="login_form" method="post">
							<input class="id_input" name="memberId" value="admin" placeholder="ID" />
							<input type="password" class="pw_input" name="memberPw" value="1234" placeholder="PW" />
							<input type="button" id="login_button" value="로그인" />
							<c:if test="${result == 0 }">
							<span class="login_warn">로그인 오류<span>
							</c:if>
						</form>
					</div>
					<div class="div_right">
						<a href="/member/join">회원가입</a>&nbsp;
						<a href="/">메인페이지</a>
						<a href="/">고객센터</a>
					</div>
				</c:if>
				
				<!-- 로그인 O -->
				<c:if test="${member != null}">
					<div class="div_left">
						${member.memberName} |
						<fmt:formatNumber value="${member.money}" pattern="#,###"/> 원 |
						<fmt:formatNumber value="${member.point}" pattern="#,###"/> P
					</div>
					<div class="div_right">
						<c:if test="${member.adminCk == 1}">
							<a href="/admin/bookEnroll">관리자페이지</a>&nbsp;&nbsp;
						</c:if>
						<a href="/cart/${member.memberId}">장바구니</a>&nbsp;&nbsp;
						<a id="gnb_logout_button">로그아웃</a>&nbsp;&nbsp;
						<a href="/">고객센터</a>
					</div>
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
								<input type="text" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>">
								<button class="btn search_btn">🔍</button>
							</div>					
						</form>
					</div>
				</div>
				<div class="login_area">
					
					<!-- 로그인 하지 않은 상태 -->
					<c:if test = "${member == null}">
							<div class="login_button"><a href="/member/login">LOGIN</a></div>
								<span><a href="/member/join">JOIN</a></span>
					</c:if>
						
					<!-- 로그인 상태 -->
					<c:if test="${member != null}">
						<div class="login_success_area">
							<span>회원 : ${member.memberName}</span>
							<span>충전금액 : <fmt:formatNumber value="${member.money}" pattern="\#,###"/></span>
							<span>포인트 : <fmt:formatNumber value="${member.point}" pattern="#,###"/></span>
							<a href="/member/logout.do">LOGOUT</a>
						</div>
					</c:if>
					
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="content_area">
				<div class="content_subject"><span>장바구니</span></div>
				<!-- 장바구니 리스트 -->
				<div class="content_middle_section"></div>
				<!-- 장바구니 가격 합계 -->
				<!-- cartInfo -->
				<div class="content_totalCount_section">
						
						<!-- 체크박스 전체 여부 -->
						<div class="all_check_input_div">
							<input type="checkbox" class="all_check_input input_size_20" checked="checked">
							<span class="all_check_span">전체선택</span>
						</div>
						
						<table class="subject_table">
								<caption>표 제목 부분</caption>
								<tbody>
										<tr>
												<th class="td_width_t1">선택</th>
												<th class="td_width_t2">이미지</th>
												<th class="td_width_t3">도서명</th>
												<th class="td_width_t4">가격</th>
												<th class="td_width_t5">수량</th>
												<th class="td_width_t6">합계</th>
										</tr>
								</tbody>
						</table>
						<table class="cart_table">
								<caption>표 내용 부분</caption>
								<tbody>
									<c:forEach items="${cartInfo}" var="ci">
										<tr>
											<td class="td_width_1 cart_info_td">
												<input type="checkbox" class="individual_cart_checkbox input_size_20" checked="checked">
												<input type="hidden" class="individual_bookPrice_input" value="${ci.bookPrice}">
												<input type="hidden" class="individual_salePrice_input" value="${ci.salePrice}">
												<input type="hidden" class="individual_bookCount_input" value="${ci.bookCount}">
												<input type="hidden" class="individual_totalPrice_input" value="${ci.salePrice * ci.bookCount}">
												<input type="hidden" class="individual_point_input" value="${ci.point}">
												<input type="hidden" class="individual_totalPoint_input" value="${ci.totalPoint}">
												<input type="hidden" class="individual_bookId_input" value="${ci.bookId}">
											</td>
											<td class="td_width_1">
												<div class="image_wrap" data-bookid="${ci.imageList[0].bookId}" data-path="${ci.imageList[0].uploadPath}" data-uuid="${ci.imageList[0].uuid}" data-filename="${ci.imageList[0].fileName}">
													<img>
												</div>
											</td>
											<td class="td_width_2"></td>
											<td class="td_width_3">${ci.bookName}</td>
											<td class="td_width_4 price_td">
												<del>정가 : <fmt:formatNumber value="${ci.bookPrice}" pattern="#,### 원" /></del><br>
												판매가 : <span class="red_color"><fmt:formatNumber value="${ci.salePrice}" pattern="#,### 원" /></span><br>
												마일리지 : <span class="green_color"><fmt:formatNumber value="${ci.point}" pattern="#,###" /></span>
											</td>
											<td class="td_width_4 table_text_align_center">
												<div class="table_text_align_center quantity_div">
													<input type="text" value="${ci.bookCount}" class="quantity_input">
													<button class="quantity_btn plus_btn">➕</button>
													<button class="quantity_btn minus_btn">➖</button>
												</div>
												<a class="quantity_modify_btn" data-cartId="${ci.cartId}">변경</a>
											</td>
											<td class="td_width_4 table_text_align_center">
												<fmt:formatNumber value="${ci.salePrice * ci.bookCount}" pattern="#,### 원" />
											</td>
											<td class="td_width_4 table_text_align_center">
												<button class="delete_btn" data-cartid="${ci.cartId}">삭제</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
						</table>
						<table class="list_table">
						</table>
					</div>
					<!-- 가격 종합 -->
					<div class="content_total_section">
						<div class="total_wrap">
							<table>
								<tr>
									<td>
										<table>
											<tr>
												<td>총 주문 가격</td>
												<td>
													<span class="totalPrice_span">70000</span> 원
												</td>
											</tr>
											<tr>
												<td>배송비</td>
												<td>
													<span class="delivery_price">3000</span>원
												</td>
											</tr>									
											<tr>
												<td>총 주문 수량</td>
												<td><span class="totalKind_span"></span>종 <span class="totalCount_span"></span>권</td>
											</tr>
										</table>
									</td>
									<td>
										<table>
											<tr>
												<td></td>
												<td></td>
											</tr>
										</table>							
									</td>
								</tr>
							</table>
							<div class="boundary_div">구분선</div>
							<table>
								<tr>
									<td>
										<table>
											<tbody>
												<tr>
													<td>
														<strong>총 결제 예상 금액</strong>
													</td>
													<td>
														<span class="finalTotalPrice_span">70000</span> 원
													</td>
												</tr>
											</tbody>
										</table>
									</td>
									<td>
										<table>
											<tbody>
												<tr>
													<td>
														<strong>총 적립 예상 마일리지</strong>
													
													</td>
													<td>
														<span class="totalPoint_span">70000</span> 원
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<!-- 구매 버튼 영역 -->
					<div class="content_btn_section">
						<a class="order_btn">주문하기</a>
					</div>
					
					<!-- 수량 조정 form -->
					<form action="/cart/update" method="post" class="quantity_update_form">
						<input type="hidden" name="cartId" class="update_cartId">
						<input type="hidden" name="bookCount" class="update_bookCount">
						<input type="hidden" name="memberId" value="${member.memberId}">
					</form>			
					
					<!-- 삭제 form -->
					<form action="/cart/delete" method="post" class="quantity_delete_form">
						<input type="hidden" name="cartId" class="delete_cartId">
						<input type="hidden" name="memberId" value="${member.memberId}">
					</form>
					
					<!-- 주문 form -->
					<form action="/order/${member.memberId}" method="get" class="order_form">
						
					</form>
					
			</div>
			<br><br><br>
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
	
	// 종합 정보 
	setTotalInfo();
	
	// 이미지 삽입
	$(".image_wrap").each(function(i, obj){
		
		const bobj = $(obj);
		
		if(bobj.data("bookid")){
			const uploadPath = bobj.data("path");
			const uuid = bobj.data("uuid");
			const fileName = bobj.data("filename");
			
			const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
			
			$(this).find("img").attr("src", "/display?fileName=" + fileCallPath);
		}else{
			
			$(this).find("img").attr("src", "/resources/img/bookNoImage.png");
		}
		
	});
	
});

	// 체크여부에 따른 종합 정보
	$(".individual_cart_checkbox").on("change", function(){
		
		// 총 주문 정보(총 가격, 마일리지, 배송비, 종류, 물품 수)
		setTotalInfo($(".cart_info_td"));
	
	});
	
	// 체크 박스 전체 선택
	$(".all_check_input").on("click", function(){
		
		// 체크박스 체크, 해제
		if($(".all_check_input").prop("checked")){
			$(".individual_cart_checkbox").attr("checked", true);
		}else{
			$(".individual_cart_checkbox").attr("checked", false);
		}
		
		// 총 주문 정보 세팅
		setTotalInfo($(".cart_info_td"));
		
		
	});


// 총 주문 정보
function setTotalInfo(){
	
	let totalPrice = 0;
	let totalCount = 0;
	let totalKind = 0;
	let totalPoint = 0;
	let deliveryPrice = 0;
	let finalTotalPrice = 0;
	
	$(".cart_info_td").each(function(index, element){
		
		if($(element).find(".individual_cart_checkbox").is(":checked") === true){
			
			// 총 가격
			totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
			
			// 총 갯수
			totalCount += parseInt($(element).find(".individual_bookCount_input").val());
			
			// 총 종류
			totalKind += 1;
			
			// 총 마일리지
			totalPoint += parseInt($(element).find(".individual_totalPoint_input").val());
		}
	});
	
	// 배송비 결정
	if(totalPrice >= 30000){
		deliveryPrice = 0;
	}else if(totalPrice == 0){
		deliveryPrice = 0;
	}else{
		deliveryPrice = 3000;
	}
	
		finalTotalPrice = totalPrice + deliveryPrice;
	
	// 총 가격
	$(".totalPrice_span").text(totalPrice.toLocaleString());
	
	// 총 갯수
	$(".totalCount_span").text(totalCount);
	
	// 총 종류
	$(".totalKind_span").text(totalKind);
	
	// 총 마일리지
	$(".totalPoint_span").text(totalPoint.toLocaleString());
	
	// 배송비
	$(".delivery_price").text(deliveryPrice);
	
	// 최종 가격
	$(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());
		
}

$(".plus_btn").on("click", function(){
	
	let quantity = $(this).parent("div").find("input").val();
	$(this).parent("div").find("input").val(++quantity);
	
});

$(".minus_btn").on("click", function(){
	
	let quantity = $(this).parent("div").find("input").val();
	if(quantity > 1){
		$(this).parent("div").find("input").val(--quantity);
	}
	
});

// 수량 수정 버튼
$(".quantity_modify_btn").on("click", function(){
	
	let cartId = $(this).data("cartid");
	let bookCount = $(this).parent("td").find("input").val();
	$(".update_cartId").val(cartId);
	$(".update_bookCount").val(bookCount);
	$(".quantity_update_form").submit();
	
});

// 장바구니 삭제
$(".delete_btn").on("click", function(e){
	
	e.preventDefault();
	const cartId = $(this).data("cartid");
	$(".delete_cartId").val(cartId);
	$(".quantity_delete_form").submit();
	
});

// 주문 페이지 이동
$(".order_btn").on("click", function(){
	
	let form_contents = '';
	let orderNumber = 0;
	
	$(".cart_info_td").each(function(index, element){
		
		// 체크여부
		if($(element).find(".individual_cart_checkbox").is(":checked") === true){
			
			let bookId = $(element).find(".individual_bookId_input").val();
			let bookCount = $(element).find(".individual_bookCount_input").val();
			
			let bookId_input = "<input name='orders[" + orderNumber + "].bookId' type='hidden' value='" + bookId + "'>";
			form_contents += bookId_input;
			
			let bookCount_input = "<input name='orders[" + orderNumber + "].bookCount' type='hidden' value='" + bookCount + "'>";
			form_contents += bookCount_input;
			
			orderNumber += 1;
		}
	});
	
	$(".order_form").html(form_contents);
	$(".order_form").submit();
	
});















</script>
	
</body>
</html>
