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
<link rel="stylesheet" href="/resources/css/admin/bookModify.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://cdn.ckeditor.com/ckeditor5/34.1.0/classic/ckeditor.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
</head>
<body>

	<%@include file="../includes/admin/header.jsp"%>

	<div class="admin_content_wrap">
		<div class="admin_content_main">
			<form action="/admin/bookModify" method="post" id="modifyForm">
				<div class="form_section">
					<div class="form_section_title">
						<label>제목</label>
					</div>
					<div class="form_section_content">
						<input name="bookName" value="${bookInfo.bookName}"> 
						<span class="ck_warn bookName_warn">제목을 입력해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>작가</label>
					</div>
					<div class="form_section_content">
						<input id="authorName_input" class="authorId_btn" readonly="readonly" value="${bookInfo.authorName}"> 
							<input id="authorId_input" name="authorId" type="hidden" value="${bookInfo.authorId}">
							<span class="ck_warn authorId_warn">작가를 선택해주세요</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>출판일</label>
					</div>
					<div class="form_section_content">
						<input name="publeYear" id="testDatepicker" autocomplete="off" readonly="readonly" value="${bookInfo.publeYear}">
						<span class="ck_warn publeYear_warn">출판일을 선택해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>출판사</label>
					</div>
					<div class="form_section_content">
						<input name="publisher" value="${bookInfo.publisher}">
						<span class="ck_warn publisher_warn">출판사를 입력해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>장르</label>
					</div>
					<div class="form_section_content">
						<div class="cate_wrap">
							<span>대분류</span> <select class="cate1">
								<option selected value="none">선택</option>
							</select>
						</div>
						<div class="cate_wrap">
							<span>중분류</span> <select class="cate2">
								<option selected value="none">선택</option>
							</select>
						</div>
						<div class="cate_wrap">
							<span>소분류</span> <select class="cate3" name="cateCode">
								<option selected value="none">선택</option>
							</select>
						</div>
						<span class="ck_warn cateCode_warn">장르를 선택해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>가격</label>
					</div>
					<div class="form_section_content">
						<input name="bookPrice" value="${bookInfo.bookPrice}"> 
						<span class="ck_warn bookPrice_warn">가격을 입력해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>재고</label>
					</div>
					<div class="form_section_content">
						<input name="bookStock" value="${bookInfo.bookStock}"> 
						<span class="ck_warn bookStock_warn">재고를 입력해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>할인율</label>
					</div>
					<div class="form_section_content">
						<input id="discount_interface" maxlength="2" value="10"> 
						<input name="bookDiscount" type="hidden" value="${bookInfo.bookDiscount}"> 
						<span class="step_val">할인 가격 : <span class="span_discount"></span></span>
						<span class="ck_warn bookDiscount_warn">1~99 숫자를 입력해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>소개</label>
					</div>
					<div class="form_section_content bit">
						<textarea name="bookIntro" id="bookIntro_textarea">${bookInfo.bookIntro}</textarea>
						<span class="ck_warn bookIntro_warn">소개를 입력해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>목차</label>
					</div>
					<div class="form_section_content bct">
						<textarea name="bookContents" id="bookContents_textarea">${bookInfo.bookContents}</textarea>
						<span class="ck_warn bookContents_warn">목차를 입력해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>도서이미지</label>
					</div>
					<div class="form_section_content">
						<input type="file" id="fileItem" name="uploadFile" style="height: 30px;">
						<div id="uploadResult"></div>
					</div>
				</div>
				<input type="hidden" name='bookId' value="${bookInfo.bookId}">
			</form>
			<div class="btn_section">
				<button id="modifyBtn" class="btn modify_btn">수 정</button>
				<button id="cancelBtn" class="btn">취 소</button>
				<button id="deleteBtn" class="btn delete_btn">삭제</button>
			</div>
		</div>
		<form id="moveForm" action="/admin/bookManage" method="get">
			<input type="hidden" name="pageNum" value="${cri.pageNum}"> <input
				type="hidden" name="amount" value="${cri.amount}"> <input
				type="hidden" name="keyword" value="${cri.keyword}"> <input
				type="hidden" name='bookId' value="${bookInfo.bookId}">
		</form>
	</div>
	
	<%@include file="../includes/admin/footer.jsp"%>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		/* 캘린더 위젯 */
		// 날짜 패턴설정
		const config = {
				dateFormat: 'yy-mm-dd',
			    prevText: '이전 달',
			    nextText: '다음 달',
			    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			    dayNames: ['일','월','화','수','목','금','토'],
			    dayNamesShort: ['일','월','화','수','목','금','토'],
			    dayNamesMin: ['일','월','화','수','목','금','토'],
			    yearSuffix: '년',
		        changeMonth: true,
		        changeYear: true
		}			
		
		$(function() {	
			
			$("#testDatepicker").datepicker(config);
		});
		
		// 작가선택
		$('.authorId_btn').on("click", function(e){
			
			e.preventDefault();
			
			let popUrl = "/admin/authorPop";
			let popOption = "width = 650px, height=550px, top=300px, left=300px, scrollbars=yes";
			
			window.open(popUrl, "작가 찾기", popOption);
		});
		
		// 카테고리 배열 초기화
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
		
		makeCateArray(cate1Obj,cate1Array,cateList,1);
		makeCateArray(cate2Obj,cate2Array,cateList,2);
		makeCateArray(cate3Obj,cate3Array,cateList,3);
		
		let targetCate2 = '';
		let targetCate3 = '${bookInfo.cateCode}';
		
		// 소분류
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
		
		// 중분류
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
		
		
		// 대분류
		for(let i = 0; i < cate1Array.length; i++){
			cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>" + cate1Array[i].cateName + "</option>");
		}	
		
		$(".cate1 option").each(function(i,obj){
			if(targetCate2.cateParent === obj.value){
				$(obj).attr("selected", "selected");
			}
		});
		 
		// 위지윅 (책 소개)
		ClassicEditor
			.create(document.querySelector('#bookIntro_textarea'))
			.catch(error=>{
				console.error(error);
			});
			
		// 위지윅 (책 목차)
		ClassicEditor
			.create(document.querySelector('#bookContents_textarea'))
			.catch(error=>{
				console.error(error);
		});
		
		// 할인율 표시
		$("#discount_interface").on("propertychange change keyup paste input", function(){
			
			let userInput = $("#discount_interface");
			let discountInput = $("input[name='bookDiscount']");
			
			let discountRate = userInput.val();								// 사용자가 입력한 할인값
			let sendDiscountRate = discountRate / 100;						// 서버에 전송할 할인값
			let bookPrice = $("input[name='bookPrice']").val();			// 원가
			let discountPrice = bookPrice * (1 - sendDiscountRate);		// 할인가격
			
			if(!isNaN(discountRate)){
				$(".span_discount").html(discountPrice);		
				discountInput.val(sendDiscountRate);				
			}
		});	
		
		$("input[name='bookPrice']").on("change", function(){
			
			let userInput = $("#discount_interface");
			let discountInput = $("input[name='bookDiscount']");
			
			let discountRate = userInput.val();								// 사용자가 입력한 할인값
			let sendDiscountRate = discountRate / 100;						// 서버에 전송할 할인값
			let bookPrice = $("input[name='bookPrice']").val();			// 원가
			let discountPrice = bookPrice * (1 - sendDiscountRate);		// 할인가격
			
			if(!isNaN(discountRate)){
				$(".span_discount").html(discountPrice);	
			}
		});
		
		// 기존 이미지 출력
		let bookId = '<c:out value="${bookInfo.bookId}"/>';
		let uploadResult = $("#uploadResult");
		
		$.getJSON("/getAttachList", {bookId : bookId}, function(arr){
			
			console.log(arr);
			
			if(arr.length === 0){
				
				let str = "";
				str += "<div id='result_card'>";
				str += "<img src='/resources/img/bookNoImage.png'>";
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
			str += "<img src='/display?fileName=" + fileCallPath +"'>";
			str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>X</div>";
			str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
			str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
			str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";				
			str += "</div>";
			
			uploadResult.html(str);			
		});
	});	// End $(document)
	
</script>
<script>

	// 카테고리
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
	makeCateArray(cate1Obj,cate1Array,cateList,1);
	makeCateArray(cate2Obj,cate2Array,cateList,2);
	makeCateArray(cate3Obj,cate3Array,cateList,3);
	
	
	// 중분류 <option> 태그
	$(cateSelect1).on("change",function(){
		
		let selectVal1 = $(this).find("option:selected").val();	
		
		cateSelect2.children().remove();
		cateSelect3.children().remove();
		
		cateSelect2.append("<option value='none'>선택</option>");
		cateSelect3.append("<option value='none'>선택</option>");
		
		for(let i = 0; i < cate2Array.length; i++){
			
			if(selectVal1 === cate2Array[i].cateParent){
				cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");	
			}
		}
	});
	
	// 소분류 <option>태그
	$(cateSelect2).on("change",function(){
		
		let selectVal2 = $(this).find("option:selected").val();
		
		cateSelect3.children().remove();
		
		cateSelect3.append("<option value='none'>선택</option>");		
		
		for(let i = 0; i < cate3Array.length; i++){
			if(selectVal2 === cate3Array[i].cateParent){
				cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");	
			}
		}
		
	});		
	
	// 버튼 (취소)
	$("#cancelBtn").on("click", function(e){
		
		e.preventDefault();
		$("#moveForm").submit();
		
	});
	
	// 버튼 (삭제)
	$("#deleteBtn").on("click", function(e){
		
		e.preventDefault();
		
		let moveForm = $("#moveForm");
		moveForm.find("input").remove();
		moveForm.append('<input type="hidden" name="bookId" value="${bookInfo.bookId}">');
		moveForm.attr("action", "/admin/bookDelete");
		moveForm.attr("method", "post");
		moveForm.submit();
		
	});
	
	// 버튼 (수정) & 유혀성 검사
	$("#modifyBtn").on("click", function(e){
		
		e.preventDefault();
		
		let bookNameCk = false;
		let authorIdCk = false;
		let publeYearCk = false;
		let publisherCk = false;
		let cateCodeCk = false;
		let priceCk = false;
		let stockCk = false;
		let discountCk = false;
		let introCk = false;
		let contentsCk = false;	
		
		let bookName = $("input[name='bookName']").val();
		let authorId = $("input[name='authorId']").val();
		let publeYear = $("input[name='publeYear']").val();
		let publisher = $("input[name='publisher']").val();
		let cateCode = $("select[name='cateCode']").val();
		let bookPrice = $("input[name='bookPrice']").val();
		let bookStock = $("input[name='bookStock']").val();
		let bookDiscount = $("#discount_interface").val();
		let bookIntro = $(".bit p").html();
		let bookContents = $(".bct p").html();	
		
		if(bookName){
			$(".bookName_warn").css('display','none');
			bookNameCk = true;
		} else {
			$(".bookName_warn").css('display','block');
			bookNameCk = false;
		}
		
		if(authorId){
			$(".authorId_warn").css('display','none');
			authorIdCk = true;
		} else {
			$(".authorId_warn").css('display','block');
			authorIdCk = false;
		}
		
		if(publeYear){
			$(".publeYear_warn").css('display','none');
			publeYearCk = true;
		} else {
			$(".publeYear_warn").css('display','block');
			publeYearCk = false;
		}	
		
		if(publisher){
			$(".publisher_warn").css('display','none');
			publisherCk = true;
		} else {
			$(".publisher_warn").css('display','block');
			publisherCk = false;
		}
		
		if(cateCode != 'none'){
			$(".cateCode_warn").css('display','none');
			cateCodeCk = true;
		} else {
			$(".cateCode_warn").css('display','block');
			cateCodeCk = false;
		}	
		
		if(bookPrice != 0){
			$(".bookPrice_warn").css('display','none');
			priceCk = true;
		} else {
			$(".bookPrice_warn").css('display','block');
			priceCk = false;
		}	
		
		if(bookStock != 0){
			$(".bookStock_warn").css('display','none');
			stockCk = true;
		} else {
			$(".bookStock_warn").css('display','block');
			stockCk = false;
		}		
		
		if(!isNaN(bookDiscount)){
			$(".bookDiscount_warn").css('display','none');
			discountCk = true;
		} else {
			$(".bookDiscount_warn").css('display','block');
			discountCk = false;
		}	
		
		if(bookIntro != '<br data-cke-filler="true">'){
			$(".bookIntro_warn").css('display','none');
			introCk = true;
		} else {
			$(".bookIntro_warn").css('display','block');
			introCk = false;
		}	
		
		if(bookContents != '<br data-cke-filler="true">'){
			$(".bookContents_warn").css('display','none');
			contentsCk = true;
		} else {
			$(".bookContents_warn").css('display','block');
			contentsCk = false;
		}		
		
		// 최종확인
		if(bookNameCk && authorIdCk && publeYearCk && publisherCk && cateCodeCk && priceCk && stockCk && discountCk && introCk && contentsCk ){

			$("#modifyForm").submit();
		} else {
			return false;
		}
		
	});
	
	// 버튼 (이미지 삭제)
	$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
		
		deleteFile();
	});
	
	// 파일삭제 
	function deleteFile(){
		
		$("#result_card").remove();
	}
	
	// 이미지 업로드
	$("input[type='file']").on("change", function(e){
		
		// 이미지 존재시 삭제
		if($("#result_card").length > 0){
			deleteFile();
		}
		
		let formData = new FormData();
		let fileInput = $('input[name="uploadFile"]');
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];
		
		if(!fileCheck(fileObj.name, fileObj.size)){
			return false;
		}
		
		formData.append("uploadFile", fileObj);
		
		$.ajax({
			url: '/admin/uploadAjaxAction',
	    	processData : false,
	    	contentType : false,
	    	data : formData,
	    	type : 'POST',
	    	dataType : 'json',
	    	success : function(result){
	    		console.log(result);
	    		showUploadImage(result);
	    	},
	    	error : function(result){
	    		alert("이미지 파일이 아닙니다.");
	    	}
		});		
		
	});
		
	let regex = new RegExp("(.*?)\.(jpg|png)$");
	let maxSize = 2097152; // 2MB	
	
	function fileCheck(fileName, fileSize){

		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
			  
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;		
	}
	
	// 이미지 출력
	function showUploadImage(uploadResultArr){
		
		/* 전달받은 데이터 검증 */
		if(!uploadResultArr || uploadResultArr.length == 0){return}
		
		let uploadResult = $("#uploadResult");
		
		let obj = uploadResultArr[0];
		
		let str = "";
		
		let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
		
		str += "<div id='result_card'>";
		str += "<img src='/display?fileName=" + fileCallPath +"'>";
		str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>X</div>";
		str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
		str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
		str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";		
		str += "</div>";		
		
   		uploadResult.append(str);     
        
	}
	
</script>
</body>
</html>