<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="includes/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
							<a href="/member/login">로그인</a>
						</li>
						<li>
							<a href="/member/join">회원가입</a>
						</li>
					</c:if>
					<c:if test="${member != null}"> <!-- 로그인 했을때 -->
						<c:if test="${member.adminCk == 1}">
							<li><a href="/admin/main">관리자 페이지</a></li>
						</c:if>
							<li>
								<a id="gnb_logout_button">로그아웃</a>
							</li>
						<li>
							마이룸
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
					<a href="/main"><img src="/resources/img/mLogo.png"></a>
				</div>
				<div class="search_area">
					<div class="search_wrap">
						<form id="searchForm" action="/search" method="get">
							<div class="search_input">
								<select name="type">
									<option value="T">책 제목</option>
									<option value="A">작가</option>
								</select>
								<input type="text" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>">
								<button class="btn search_btn">검색</button>
							</div>					
						</form>
					</div>
				</div>
				<div class="login_area">
					
					<!-- 로그인 하지 않은 상태 -->
					<c:if test = "${member == null}">
							<div class="login_button"><a href="/member/login">로그인</a></div>
								<span><a href="/member/join">회원가입</a></span>
					</c:if>
						
					<!-- 로그인 상태 -->
					<c:if test="${member != null}">
						<div class="login_success_area">
							<span>회원 : ${member.memberName}</span>
							<span>충전금액 : <fmt:formatNumber value="${member.money}" pattern="\#,###"/></span>
							<span>포인트 : <fmt:formatNumber value="${member.point}" pattern="#,###"/></span>
							<a href="/member/logout.do">로그아웃</a>
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
					<!-- 상품 정보 -->
					<!-- 포인트 정보 -->
					<!-- 주문 종합 정보 -->
				</div>
					
			</div>
			
			<!-- Footer 영역 -->
			<div class="footer_nav">
				<div class="footer_nav_container">
					<ul>
						<li>회사소개</li>
						<span class="line">|</span>
						<li>이용약관</li>
						<span class="line">|</span>
						<li>고객센터</li>
						<span class="line">|</span>
						<li>광고문의</li>
						<span class="line">|</span>
						<li>채용정보</li>
						<span class="line">|</span>
					</ul>
				</div>
			</div>	<!-- class="footer_nav" -->
			
			<div class="footer">
				<div class="footer_container">
					
					<div class="footer_left">
						<!-- 이미지파일 -->
					</div>
					<div class="footer_right">
						(주) VamBook		대표이사 : OOO
						<br>
						사업자등록번호 : OOO-OO-OOOOO
						<br>
						대표전화 : OOOO-OOOO (발신자 부담전화)
						<br>
						<br>
						COPYRIGHT(C) <strong>kimvampa.tistory.com</strong>		ALL RIGHTS RESERVED.
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			
	</div>	<!-- .wrap end -->
</div>	<!-- .wrapper end -->

<script>

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
	
}














</script>
	
</body>
</html>
