<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/script_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/admin/bookDetail.css">
<script src="https://cdn.ckeditor.com/ckeditor5/26.0.0/classic/ckeditor.js"></script>
<style type="text/css">
#result_card img {
	max-width: 100%;
	height: auto;
	display: block;
	padding: 5px;
	margin-top: 10px;
	margin: auto;
}
</style>
</head>
<body>

	<%@include file="../includes/admin/header.jsp"%>

	<div class="admin_content_wrap">
		<div class="admin_content_main">
			<div class="form_section">
				<div class="form_section_title">
					<label>제목</label>
				</div>
				<div class="form_section_content">
					<input name="bookName"
						value="<c:out value="${bookInfo.bookName}"/>" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>등록일</label>
				</div>
				<div class="form_section_content">
					<input value="<fmt:formatDate value='${bookInfo.regDate}' pattern='yyyy-MM-dd'/>" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>수정일</label>
				</div>
				<div class="form_section_content">
					<input value="<fmt:formatDate value='${bookInfo.updateDate}' pattern='yyyy-MM-dd'/>" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>작가</label>
				</div>
				<div class="form_section_content">
					<input id="authorName_input" readonly="readonly" value="${bookInfo.authorName }" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>출판일</label>
				</div>
				<div class="form_section_content">
					<input name="publeYear" autocomplete="off" readonly="readonly" value="<c:out value="${bookInfo.publeYear}"/>" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>출판사</label>
				</div>
				<div class="form_section_content">
					<input name="publisher" value="<c:out value="${bookInfo.publisher}"/>" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>장르</label>
				</div>
				<div class="form_section_content">
					<div class="cate_wrap">
						<span>대분류</span> <select class="cate1" disabled>
							<option value="none">선택</option>
						</select>
					</div>
					<div class="cate_wrap">
						<span>중분류</span> <select class="cate2" disabled>
							<option value="none">선택</option>
						</select>
					</div>
					<div class="cate_wrap">
						<span>소분류</span> <select class="cate3" name="cateCode" disabled>
							<option value="none">선택</option>
						</select>
					</div>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>가격</label>
				</div>
				<div class="form_section_content">
					<input name="bookPrice" value="<c:out value="${bookInfo.bookPrice}"/>" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>재고</label>
				</div>
				<div class="form_section_content">
					<input name="bookStock" value="<c:out value="${bookInfo.bookStock}"/>" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>할인율</label>
				</div>
				<div class="form_section_content">
					<input id="discount_interface" maxlength="2" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>소개</label>
				</div>
				<div class="form_section_content bit">
					<textarea name="bookIntro" id="bookIntro_textarea" disabled>${bookInfo.bookIntro}</textarea>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>목차</label>
				</div>
				<div class="form_section_content bct">
					<textarea name="bookContents" id="bookContents_textarea" disabled>${bookInfo.bookContents}</textarea>
				</div>
			</div>

			<div class="form_section">
				<div class="form_section_title">
					<label>도서이미지</label>
				</div>
				<div class="form_section_content">
					<div id="uploadResult"></div>
				</div>
			</div>
			<div class="btn_section">
				<button id="modifyBtn" class="btn enroll_btn">수정</button>
				<button id="cancelBtn" class="btn">목록</button>
			</div>
		</div>

		<form id="moveForm" action="/admin/bookManage" method="get">
			<input type="hidden" name="pageNum" value="${cri.pageNum}">
			<input type="hidden" name="amount" value="${cri.amount}">
			<input type="hidden" name="keyword" value="${cri.keyword}">
		</form>
	</div>

	<%@include file="../includes/admin/footer.jsp"%>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 할인율
		let bookDiscount = '<c:out value="${bookInfo.bookDiscount}"/>' * 100;
		$("#discount_interface").attr("value", bookDiscount);
		
		// 책 소개
		ClassicEditor
			.create(document.querySelector('#bookIntro_textarea'))
			.then(editor=>{
				console.log(editor);
				editor.isReadOnly = true;
			})
			.catch(error=>{
				console.error(error);
			});
		
		// 책 목차
		ClassicEditor
			.create(document.querySelector('#bookContents_textarea'))
			.then(editor=>{
				console.log(editor);
				editor.isReadOnly = true;
			})
			.catch(error=>{
				console.error(error);
		});
		
		
		let cateList = JSON.parse('${cateList}');

		let cate1Array = new Array();
		let cate2Array = new Array();
		let cate3Array = new Array();
		let cate1Obj = new Object();
		let cate2Obj = new Object();
		let cate3Obj = new Object();
		
		let cateSelect1 = $(".cate1");		
		let cateSelect2 = $(".cate2");
		let cateSelect3 = $(".cate3");
		
		// 카테고리 배열 초기화 메서드
		function makeCateArray(obj,array,cateList, tier){
			for(let i = 0; i < cateList.length; i++){
				if(cateList[i].tier === tier){
					obj = new Object();
					
					obj.cateName = cateList[i].cateName;
					obj.cateCode = cateList[i].cateCode;
					obj.cateParent = cateList[i].cateParent;
					
					array.push(obj);				
					
				}
			}
		}	
		
		// 배열 초기화
		makeCateArray(cate1Obj, cate1Array, cateList,1);
		makeCateArray(cate2Obj, cate2Array, cateList,2);
		makeCateArray(cate3Obj, cate3Array, cateList,3);
		
		let targetCate2 = '';
		let targetCate3 = '${bookInfo.cateCode}';
		
		for(let i = 0; i < cate3Array.length; i++){
			if(targetCate3 === cate3Array[i].cateCode){
				targetCate3 = cate3Array[i];
			}
		}
		
		for(let i = 0; i < cate3Array.length; i++){
			if(targetCate3.cateParent === cate3Array[i].cateParent){
				cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");
			}
		}
		
		$(".cate3 option").each(function(i,obj){
			if(targetCate3.cateCode === obj.value){
				$(obj).attr("selected", "selected");
			}
		});
		
		for(let i = 0; i < cate2Array.length; i++){
			if(targetCate3.cateParent === cate2Array[i].cateCode){
				targetCate2 = cate2Array[i];	
			}
		}
		
		for(let i = 0; i < cate2Array.length; i++){
			if(targetCate2.cateParent === cate2Array[i].cateParent){
				cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");
			}
		}		
		
		$(".cate2 option").each(function(i,obj){
			if(targetCate2.cateCode === obj.value){
				$(obj).attr("selected", "selected");
			}
		});
		
		for(let i = 0; i < cate1Array.length; i++){
			cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>" + cate1Array[i].cateName + "</option>");
		}
		
		$(".cate1 option").each(function(i,obj){
			if(targetCate2.cateParent === obj.value){
				$(obj).attr("selected", "selected");
			}
		});
		
		// 이미지 정보 호출
		let bookId = '<c:out value="${bookInfo.bookId}"/>';
		let uploadResult = $("#uploadResult");
		
		$.getJSON("/getAttachList", {bookId : bookId}, function(arr){
			
			if(arr.length === 0){
				
				let str = "";
				str += "<div id='result_card'>";
				str += "<img src='/resources/img/bookNoImage.png'";
				str += "</div>";
				
				uploadResult.html(str);
				
				return;
			}
			
			let str = "";
			let obj = arr[0];
			
			let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
			str += "<div id='result_card'";
			str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
			str += ">";
			str += "<img src='/display?fileName=" + fileCallPath + "'>";
			str += "</div>";
			
			uploadResult.html(str);
		});
	}); // End $(document)
	
	// 버튼 (목록)
	$("#cancelBtn").on("click", function(e){
		
		e.preventDefault();
		$("#moveForm").submit();
	});
	
	// 버튼 (수정)
	$("#modifyBtn").on("click", function(e){
		
		e.preventDefault();
		
		let addInput = '<input type="hidden" name="bookId" value="${bookInfo.bookId}">';
		
		$("#moveForm").append(addInput);
		$("#moveForm").attr("action", "/admin/bookModify");
		$("#moveForm").submit();
	});
	
</script>
</body>
</html>