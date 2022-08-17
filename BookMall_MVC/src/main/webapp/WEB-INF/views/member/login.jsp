<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/member/login.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous">
	
</script>
<style type="text/css">
a{text-decoration: none;}
	a:link{text-decoration: none;}
	a:visited{text-decoration: none;}
	a:active{text-decoration: none;}
	a:hover{text-decoration: none;}
a{
	font-size: 50px;
	color: #1E90FF;
}
</style>
</head>
<body>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<div class="wrapper">
		<div class="wrap">
			<form id="login_form" method="post">
				<div class="logo_wrap">
					<a href="/main"><h1>The BooK</h1></a>
				</div>
				<div class="login_wrap">
					<div class="id_wrap">
						<div class="id_input_box">
							<input class="id_input" name="memberId" value="" placeholder="ID" />
						</div>
					</div>
					<div class="pw_wrap">
						<div class="pw_input_box">
							<input type="password" class="pw_input" name="memberPw" value="" placeholder="Password" />
								
						</div>
					</div>

					<c:if test="${result == 0 }">
						<div class="login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
					</c:if>

					<div class="login_button_wrap">
						<input type="button" class="login_button" value="로그인" />
					</div>
				</div>
			</form>
		</div>
	</div>


	<script>
		// 로그인 버튼 클릭 메소드
		$(".login_button").click(function() {

			// alert("로그인 버튼 작용");

			// 로그인 메서드 서버 요청
			$("#login_form").attr("action", "/member/login.do");
			$("#login_form").submit();
		});
	</script>
</body>
</html>