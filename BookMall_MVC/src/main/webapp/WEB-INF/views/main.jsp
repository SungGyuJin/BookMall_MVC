<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/main.css">
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/> 
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous">
</script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
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
							<input type="hidden" name="pageName" value="main">
							<input type="hidden" name="pageParam" value="main">
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
			<hr>
			<div class="navi_area">
				<div class="dropdown">
					<a href="search?type=T&keyword=">
					<button class="dropbtn">전체
					</button>
					</a>
				</div>
				<div class="dropdown">
					<button class="dropbtn">국내도서
						<i class="fa fa-caret-down"></i>
					</button>
					<div class="dropdown-content">
						<c:forEach items="${cate1}" var="cate">
							<a href="search?type=TC&cateCode=${cate.cateCode}&keyword">${cate.cateName}</a>
						</c:forEach>
					</div>
				</div>
				<div class="dropdown">
					<button class="dropbtn">외국도서
						<i class="fa fa-caret-down"></i>
					</button>
					<div class="dropdown-content">
						<c:forEach items="${cate2}" var="cate">
							<a href="search?type=TC&cateCode=${cate.cateCode}&keyword">${cate.cateName}</a>
						</c:forEach>
					</div>
				</div>
			</div>
			<hr>
			<div class="content_area">
				<div class="slide_div_wrap">
					<div class="slide_div">
						<div>
							<a>
								<img src="../resources/img/mainImage_1.png">
							</a>
						</div>
						<div>
							<a>
								<img src="../resources/img/mainImage_2.png">
							</a>
						</div>
						<div>
							<a>
								<img src="../resources/img/mainImage_3.png">
							</a>
						</div>		
						<div>
							<a>
								<img src="../resources/img/mainImage_4.png">
							</a>
						</div>					
					</div>	
				</div>
				
				<div class="ls_wrap">
					<div class="ls_div_subject">
						이 달의 인기도서
					</div>
					<div class="ls_div">
						<c:forEach items="${mainList}" var="mList">
							<a href="/bookDetail/pageParam=${mList.bookId}">
								<div class="ls_div_content_wrap">
									<div class="ls_div_content">
										<div class="image_wrap" data-bookid="${mList.imageList[0].bookId}" data-path="${mList.imageList[0].uploadPath}" data-uuid="${mList.imageList[0].uuid}" data-filename="${mList.imageList[0].fileName}">
											<img>
										</div><br><br>		
										<div class="ls_category">
											${mList.cateName}
										</div>
										<div class="ls_bookName">
											${mList.bookName}
										</div>							
									</div>
								</div>
							</a>					
						</c:forEach>					
					</div>
				</div>
			</div> <!-- .content_area -->
			
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
<%-- <%=application.getServerInfo() %><br>
<%= application.getMajorVersion() %>.<%= application.getMinorVersion() %><br>
<%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %><br> --%>
<script type="text/javascript">
	// 로그인 버튼 클릭 메소드
	$("#login_button").click(function() {
	
		// alert("로그인 버튼 작용");
	
		// 로그인 메서드 서버 요청
		$("#login_form").attr("action", "/member/login.do");
		$("#login_form").submit();
	});
	
	$(document).ready(function(){
		
		$(".slide_div").slick(
			{
				dots : true,
				autoplay : true,
				autoplaySpeed : 3000
			}
		);
		
		/* 이미지 삽입 */
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
		
		$(".ls_div").slick({
			slidesToShow : 4,
			slidesToScroll : 4,
			prevArrow : "<button type='button' class='ls_div_content_prev'>◀</button>",
			nextArrow : "<button type='button' class='ls_div_content_next'>▶</button>",
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
	
	$(".search_btn").click(function(){
		if($("input[name=keyword]").val() == ""){
			alert("검색어를 입력해주세요");		
			return false;
		}
	});
	
</script>
</body>
</html>