<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="includes/script_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/reply.css">
</head>
<body>
	<div class="wrapper_div">
		<div class="subject_div">
			리뷰 등록
		</div>
	</div>
	<div clas="input_wrap">
		<div class="bookName_div">
			<h2>${bookInfo.bookName}</h2>
		</div>
		<div class="rating_div">
			<h4>평점</h4>
			<select name="rating">
				<option value="0.5">0.5</option>
				<option value="1.0">1.0</option>
				<option value="1.5">1.5</option>
				<option value="2.0">2.0</option>
				<option value="2.5">2.5</option>
				<option value="3.0">3.0</option>
				<option value="3.5">3.5</option>
				<option value="4.0">4.0</option>
				<option value="4.5">4.5</option>
				<option value="5.0">5.0</option>
			</select>
		</div>
		
		<div class="content_div">
			<h4>리뷰</h4>
			<textarea name="conetnet"></textarea>
		</div>
		
		<div class="btn_wrap">
			<a class="enroll_btn">등록</a>
			<a class="cancel_btn">취소</a>
		</div>
	</div>
	
<script type="text/javascript">

	// 버튼 (듵록)
	$(".enroll_btn").on("click", function(e){
		
		const bookId = '${bookInfo.bookId}';
		const memberId = '${memberId}';
		const rating = $("select").val();
		const content = $("textarea").val();
		
		const data = {
				bookId : bookId,
				memberId : memberId,
				rating : rating,
				content: content
		}
		
		$.ajax({
			data : data,
			type : 'POST',
			url : '/reply/enroll',
			success : function(result){
				
				// 댓글 초기화
				$(opener.location).attr("href", "javascript:replyListInit();");
				
				window.close();
			}
		});
	});

	// 버튼 (취소)
	$(".cancel_btn").on("click", function(e){
		
		window.close();
		
	});
	
</script>
</body>
</html>