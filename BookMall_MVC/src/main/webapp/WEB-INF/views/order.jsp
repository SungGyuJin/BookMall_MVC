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
<link rel="stylesheet" href="/resources/css/order.css">
<!-- Daum 주소 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
<div class="wrapper">
	<div class="wrap">
			<div class="top_gnb_area">
				<ul class="list">
					<c:if test="${member == null}"> <!-- 로그인 안했을때 -->
						<li>
							<a href="/member/login">LOGIN</a>
						</li>
						<li>
							<a href="/member/join">JOIN</a>
						</li>
					</c:if>
					<c:if test="${member != null}"> <!-- 로그인 했을때 -->
						<c:if test="${member.adminCk == 1}">
							<li><a href="/admin/bookEnroll">관리자 페이지</a></li>
						</c:if>
							<li>
								<a id="gnb_logout_button">LOGOUT</a>
							</li>
						<li>
							<a href="/cart/${member.memberId}">
								장바구니
							</a>
						</li>
					</c:if>
						<li>
							고객센터
						</li>
				</ul>			
			</div>
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
					
				<div class="content_main">
					<!-- 회원정보 -->
					<div class="member_info_div">
						<table class="table_text_align_center memberInfo_table">
							<tbody>
								<tr>
									<th style="width: 25%;">주문자</th>
									<th style="width: *">${memberInfo.memberName} | ${memberInfo.memberMail}</th>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="addressInfo_div">
						<!-- 배송지 정보 -->
						<div class="addressInfo_button_div">
							<button class="address_btn address_btn_1" onClick="showAdress('1')" style="background-color: #3c3838;">사용자 정보 주소록</button>
							<button class="address_btn address_btn_2" onClick="showAdress('2')">직접입력</button>
						</div>
						<div class="addressInfo_input_div_wrap">
							<div class="addressInfo_input_div addressInfo_input_div_1" style="display: block;">
								<table>
									<colgroup>
											<col width="25%">
											<col width="*">
									</colgroup>
									<tbody>
										<tr>
												<th>이름</th>
												<td>
													${memberInfo.memberName}
												</td>
										</tr>
										<tr>
												<th>주소</th>
												<td>
													${memberInfo.memberAddr1} ${memberInfo.memberAddr2}<br>${memberInfo.memberAddr3}
													<input class="selectAddress" value="T" type="hidden">
													<input class="addressee_input" value="${memberInfo.memberName}" type="hidden">
													<input class="address1_input" type="hidden" value="${memberInfo.memberAddr1}">
													<input class="address2_input" type="hidden" value="${memberInfo.memberAddr2}">
													<input class="address3_input" type="hidden" value="${memberInfo.memberAddr3}">
												</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="addressInfo_input_div addressInfo_input_div_2">
								<table>
									<colgroup>
											<col width="25%">
											<col width="*">
									</colgroup>
									<tbody>
											<tr>
													<th>이름</th>
													<td>
														<input class="addressee_input">
													</td>
											</tr>
											<tr>
													<th>주소</th>
													<td>
															<input class="selectAddress" value="F" type="hidden">
															<input class="address1_input" readonly="readonly"><a class="address_search_btn" onClick="execution_daum_address()">주소 찾기</a><br>		
															<input class="address2_input" readonly="readonly"><br>
															<input class="address3_input" readonly="readonly">							
													</td>
											</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- 도서 정보 -->
					<div class="orderbook_div">
						<!-- 도서 종류 -->
						<div class="book_kind_div">
							주문도서 <span class="book_kind_div_kind"></span>종 <span class="book_kind_div_count"></span>개
						</div>
						<!-- 도서 테이블 -->
						<table class="book_subject_table">
							<colgroup>
								<col width="15%">
								<col width="45%">
								<col width="40%">
							</colgroup>
							<tbody>
								<tr>
									<th>이미지</th>
									<th>도서정보</th>
									<th>판매가</th>
								</tr>
							</tbody>
						</table>
						<table class="book_table">
							<colgroup>
								<col width="15%">
								<col width="45%">
								<col width="40%">
							</colgroup>					
							<tbody>
								<c:forEach items="${orderList}" var="ol">
									<tr>
										<td>
											<!-- 이미지 <td>-->
											<div class="image_wrap" 
												data-bookid="${ol.imageList[0].bookId}"
												data-path="${ol.imageList[0].uploadPath}" 
												data-uuid="${ol.imageList[0].uuid}" 
												data-filename="${ol.imageList[0].fileName}">
												<img>
											</div>
										</td>
										<td>${ol.bookName}</td>
										<td class="book_table_price_td">
											<fmt:formatNumber value="${ol.salePrice}" pattern="#,### 원" /> | 수량 ${ol.bookCount}개
											<br><fmt:formatNumber value="${ol.totalPrice}" pattern="#,### 원" />
											<br>[<fmt:formatNumber value="${ol.totalPoint}" pattern="#,### 원" />P]
											<input type="hidden" class="individual_bookPrice_input" value="${ol.bookPrice}">
											<input type="hidden" class="individual_salePrice_input" value="${ol.salePrice}">
											<input type="hidden" class="individual_bookCount_input" value="${ol.bookCount}">
											<input type="hidden" class="individual_totalPrice_input" value="${ol.salePrice * ol.bookCount}">
											<input type="hidden" class="individual_point_input" value="${ol.point}">
											<input type="hidden" class="individual_totalPoint_input" value="${ol.totalPoint}">
											<input type="hidden" class="individual_bookId_input" value="${ol.bookId}">
										</td>
									</tr>							
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- 포인트 정보 -->
					<div class="point_div">
						<div class="point_div_subject">포인트 사용</div>
						<table class="point_table">
							<colgroup>
								<col width="25%">
								<col width="*">
							</colgroup>
							<tbody>
								 	<tr>
								 			<th>포인트 사용</th>
								 			<td>
								 					${memberInfo.point} | <input class="order_point_input" value="0">원
								 					<a class="order_point_input_btn order_point_input_btn_N" data-state="N">모두사용</a>
								 					<a class="order_point_input_btn order_point_input_btn_Y" data-state="Y" style="display: none;">사용취소</a>
								 			</td>
								 	</tr>
							</tbody>
						</table>
					</div>
					<!-- 주문 종합 정보 -->
					<div class="total_info_div">
						<!-- 가격 종합 정보 -->
						<div class="total_info_price_div">
								<ul>
										<li>
												<span class="price_span_label">도서금액</span>
												<span class="totalPrice_span">100000</span>원
										</li>
										<li>
												<span class="price_span_label">배송비</span>
												<span class="delivery_price_span">100000</span>원
										</li>
										<li>
												<span class="price_span_label">할인금액</span>
												<span class="usePoint_span">100000</span>원
										</li>
										<li class="price_total_li">
												<strong class="price_span_label total_price_label">최종 결제 금액</strong>
												<strong class="strong_red">
														<span class="total_price_red finalTotalPrice_span"></span>원
												</strong>
										</li>
										<li class="point_li">
												<span class="price_span_label">적립예정 포인트</span>
												<span class="totalPoint_span"></span>원
										</li>
								</ul>
						</div>
						<!-- 버튼 -->
						<div class="total_info_btn_div">
								<a class="order_btn">결제하기</a>
						</div>
					</div>
				</div>
					
			</div>
			<!-- 주문 요청 form -->
		<form class="order_form" action="/order" method="post">
			<!-- 주문자 회원번호 -->
			<input name="memberId" value="${memberInfo.memberId}" type="hidden">
			<!-- 주소록 & 받는이-->
			<input name="addressee" type="hidden">
			<input name="memberAddr1" type="hidden">
			<input name="memberAddr2" type="hidden">
			<input name="memberAddr3" type="hidden">
			<!-- 사용 포인트 -->
			<input name="usePoint" type="hidden">
			<!-- 도서 정보 -->
		</form>
			<!-- Footer 영역 -->
			<br><br><br>
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

$(document).ready(function(){
	
	// 주문 조합정보 최신
	setTotalInfo();
	
	// 이미지 삽입 
	$(".image_wrap").each(function(i, obj){
		
		const bobj = $(obj);
		
		if(bobj.data("bookid")){
			const uploadPath = bobj.data("path");
			const uuid = bobj.data("uuid");
			const fileName = bobj.data("filename");
			
			const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
			
			$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
		} else {
			$(this).find("img").attr('src', '/resources/img/bookNoImage.png');
		}
		
	});

	
});

// 주소 입력란 버튼 동작(숨김, 등장)
function showAdress(className){
	
	// 컨텐츠 동작
	// 모두 숨기기
	$(".addressInfo_input_div").css("display", "none");
	// 컨텐츠 보이기
	$(".addressInfo_input_div_" + className).css("display", "block");
	
	// 버튼 색상 변경
	// 모든 색상 동일
	$(".address_btn").css("backgroundColor", "#555");
	// 지정 색상 변경
	$(".address_btn_" + className).css("backgroundColor", "#3c3838");
	
	// selectAddress T/F
	// 모든 selectAddress F만들기
	$(".addressInfo_input_div").each(function(i, obj){
		$(obj).find(".selectAddress").val("F");
	});
	
	// 선택한 selectaddress T만들기
	$(".addressInfo_input_div_" + className).find(".selectAddress").val("T");
	
	
}

// 다음 주소 연동
function execution_daum_address(){
	
	console.log("동작");
	
	new daum.Postcode({
		oncomplete: function(data){
			
			var addr = '';		// 주소변수
			var extraAddr = '';	// 참고항목 변수
			
			// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if(data.userSelectedType === 'R'){
				
				addr = data.roadAddress;
			}else{
				addr = data.jibunAddress;
			}
			
			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if(data.userSeletedType === 'R'){
				
				if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
					extraAddr += data.bname;
				}
				
				// 건물명이 있고, 공동주택일 경우 추가
				if(data.buildingName !== '' && data.apartment === 'Y'){
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if(extraAddr !== ''){
					extraAddr = ' (' + extraAddr + ")";
				}
				
				// 추가해야할 코드
				// 주소변수 문자열과 참고항목 문자열 합치기
				addr += extraAddr;
			
			}else{
				addr += ' ';
			}
			
			// 제거해야할 코드
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			$(".address1_input").val(data.zonecode);
			$(".address2_input").val(addr);
			
			// 커서를 상세주소를 필드로 이동한다.
			$(".address3_input").attr("readonly", false);
			$(".address3_input").focus();
			
		}
	
	}).open();
	
}

// 포인트 입력
// 0 이상 & 최대 포인트 수 입력
$(".order_point_input").on("propertychange change keyup paste input", function(){
	
	const maxPoint = parseInt("${memberInfo.point}");
	
	let inputValue = parseInt($(this).val());
	
	if(inputValue < 0){
		$(this).val(0);
	}else if(inputValue > maxPoint){
		$(this).val(maxPoint);
	}
	
	setTotalInfo();
	
});

// 포이트 모두사용 취소 버튼
// Y 모두사용, N 모두 취소
$(".order_point_input_btn").on("click", function(){
	
	const maxPoint = parseInt("${memberInfo.point}");
	
	let state = $(this).data("state");
	
	if(state == 'N'){
		console.log("n동작");
		
		// 모두사용
		// 값 변경
		$(".order_point_input").val(maxPoint);
		// 글 변경
		$(".order_point_input_btn_Y").css("display", "inline-block");
		$(".order_point_input_btn_N").css("display", "none");
	}else if(state == 'Y'){
		console.log("y동작");
		
		// 취소
		// 값 변경
		$(".order_point_input").val(0);
		
		// 글 변경
		$(".order_point_input_btn_Y").css("display", "none");
		$(".order_point_input_btn_N").css("display", "inline-block");
	}
	
	setTotalInfo();
	
});

// 총 주문 정보
function setTotalInfo(){

	let totalPrice = 0;				// 총 가격
	let totalCount = 0;				// 총 갯수
	let totalKind = 0;				// 총 종류
	let totalPoint = 0;				// 총 마일리지
	let deliveryPrice = 0;			// 배송비
	let usePoint = 0;				// 사용 포인트
	let finalTotalPrice = 0; 		// 최종 가격
	
	$(".book_table_price_td").each(function(index, element){
		// 총 가격
		totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
		// 총 갯수
		totalCount += parseInt($(element).find(".individual_bookCount_input").val());
		// 총 종류
		totalKind += 1;
		// 총 마일리지
		totalPoint += parseInt($(element).find(".individual_totalPoint_input").val());
	});	

	// 배송비 결정 
	if(totalPrice >= 30000){
		deliveryPrice = 0;
	} else if(totalPrice == 0){
		deliveryPrice = 0;
	} else {
		deliveryPrice = 3000;	
	}
	
	// 포인트 할당
	usePoint = $(".order_point_input").val();
	
	// 총 결제비용 계산
	finalTotalPrice = (totalPrice + deliveryPrice) - usePoint;	
	
	// 값 삽입 
	// 총 가격
	$(".totalPrice_span").text(totalPrice.toLocaleString());
	// 총 갯수
	$(".book_kind_div_count").text(totalCount);
	// 총 종류
	$(".book_kind_div_kind").text(totalKind);
	// 총 마일리지
	$(".totalPoint_span").text(totalPoint.toLocaleString());
	// 배송비
	$(".delivery_price_span").text(deliveryPrice.toLocaleString());	
	// 최종 가격(총 가격 + 배송비)
	$(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());		
	// 할인가(사용 포인트)
	$(".usePoint_span").text(usePoint.toLocaleString());
}

// 주문 요청 
$(".order_btn").on("click", function(){;	
	
	// 주소 정보 & 받는이
	$(".addressInfo_input_div").each(function(i, obj){
		if($(obj).find(".selectAddress").val() === 'T'){
			$("input[name='addressee']").val($(obj).find(".addressee_input").val());
			$("input[name='memberAddr1']").val($(obj).find(".address1_input").val());
			$("input[name='memberAddr2']").val($(obj).find(".address2_input").val());
			$("input[name='memberAddr3']").val($(obj).find(".address3_input").val());
		}
	});	
	
	// 사용 포인트 
	$("input[name='usePoint']").val($(".order_point_input").val());	
	
	// 도서정보 
	let form_contents = ''; 
	$(".book_table_price_td").each(function(index, element){
		let bookId = $(element).find(".individual_bookId_input").val();
		let bookCount = $(element).find(".individual_bookCount_input").val();
		let bookId_input = "<input name='orders[" + index + "].bookId' type='hidden' value='" + bookId + "'>";
		form_contents += bookId_input;
		let bookCount_input = "<input name='orders[" + index + "].bookCount' type='hidden' value='" + bookCount + "'>";
		form_contents += bookCount_input;
	});	
	$(".order_form").append(form_contents);	
	
	// 서버 전송 
	$(".order_form").submit();	
	
});










</script>
	
</body>
</html>
