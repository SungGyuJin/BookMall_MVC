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
<link rel="stylesheet" href="resources/css/main.css">
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
							장바구니
						</li>
					</c:if>
						<li>
							고객센터
						</li>
				</ul>			
			</div>
			<div class="top_area">
					<div class="logo_area">
						<a href="/main"><img src="resources/img/mLogo.png"></a>
					</div>
					<div class="search_area">
							<h1>Search area</h1>
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
			<div class="navi_bar_area">
					<h1>navi area</h1>
			</div>
			<div class="content_area">
					<h1>content area</h1>
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
	
	// gnb-area 로그아웃 버튼작동
	$("#gnb_logout_button").click(function(){
		
		// alert("버튼 작동");
		
		$.ajax({
			
			type: "POST",
			url: "/member/logout.do",
			success: function(data){
				alert("로그아웃 성공");
				document.location.reload();
			}
			
		}); // ajax
		
	});
	
</script>
</body>
</html>