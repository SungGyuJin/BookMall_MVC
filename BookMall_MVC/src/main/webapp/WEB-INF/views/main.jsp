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
<body>🔍
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
			<div class="navi_area">
				<div class="dropdown">
					<button class="dropbtn">국내
						<i class="fa fa-caret-down"></i>
					</button>
					<div class="dropdown-content">
						<c:forEach items="${cate1}" var="cate">
							<a href="search?type=C&cateCode=${cate.cateCode}">${cate.cateName}</a>
						</c:forEach>
					</div>
				</div>
				<div class="dropdown">
					<button class="dropbtn">해외
						<i class="fa fa-caret-down"></i>
					</button>
					<div class="dropdown-content">
						<c:forEach items="${cate2}" var="cate">
							<a href="search?type=C&cateCode=${cate.cateCode}">${cate.cateName}</a>
						</c:forEach>
					</div>
				</div>
			</div>
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
							<a href="/bookDetail/${mList.bookId}">
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
				alert("로그아웃 성공");
				document.location.reload();
			}
			
		}); // ajax
		
	});
	
</script>
</body>
</html>