# 인터넷서점 서비스 _ 개인프로젝트

## 프로젝트 설명 및 목적
> &nbsp;&nbsp;&nbsp;&nbsp;신입 웹 개발자가 필수적으로 알아야하는 게시판의 원리를 이용하여 다양한 기능들을 구현하며 알고 있는 개념은 더 확실하게, 부족한 부분은 체크하여 보완하기 위한 목적으로 프로젝트가 진행됩니다. 본 프로젝트는 스프링프레임워크를 이용한 인터넷서점 서비스입니다. 우리가 흔히 알고 있는 인터넷 쇼핑몰사이트와 유사합니다. 회원가입 후 로그인을 하고 원하는 상품(책)을 선택하여 주문하는 과정입니다. 다만 차이를 둔 부분은 아무래도 개인프로젝트이다보니 주문을 할 때 실제 돈이 아닌 충전금액 차감방식을 선택했습니다.
>> (실제 서비스를 운영하는 예스24, 교보문고 홈페이지를 참고하며 프로젝트를 진행했습니다.)

***

## 개발환경

* Spring (Eclipse : Spring Tools 3)
* JDK 1.8
* Apache Tomcat 8.0
* MySQL
* MyBatis

***

## 주요기능

* 로그인 및 회원가입 (Ajax ID 중복검사, 주소API, E-mail 인증)
* 검색기능 및 페이징처리
* 주문하기 (장바구니, 충전금액차감, 상품재고차감, 포인트차감)
* 댓글기능 (리뷰)
* 관리자페이지 (작가, 도서관리)

***

## 데이터베이스 모델링

<img src="https://user-images.githubusercontent.com/79797179/185130810-bc3ee493-9e89-4103-9e7c-52fd8e601fbc.png" width="90%">

***

## 사용방법

### 1. 로그인 및 회원가입

* 로그아웃 (비동기 로그아웃)

```java

<script>
// 버튼 (로그아웃)
$("#gnb_logout_button").click(function(){
		
    $.ajax({
			
        type: "POST",
	url: "/member/logout.do",
	success: function(data){
	    document.location.reload();
	}
    });
});
</script>

Contriller 부분
@RequestMapping(value = "logout.do", method = RequestMethod.POST)
@ResponseBody
public void logoutPOST(HttpServletRequest request) throws Exception {

    HttpSession session = request.getSession();

    session.invalidate();
}

```

<img src="https://user-images.githubusercontent.com/79797179/185788109-49213c14-e4dd-4e47-8159-b7b49095b670.gif" width="90%">

<img src="https://user-images.githubusercontent.com/79797179/184847874-4859b201-ace9-4555-bb5c-63993c3f6b80.gif" width="90%">

* ID 중복검사 (Ajax 적용)

```java

<script>
$('.id_input').on("propertychange change keyup paste input", function(){
		
	var memberId = $('.id_input').val();   	// ID 입력 값
	var data = {memberId : memberId};       // Controller에 넘길 데이터 이름 : 데이터(ID에 입력 되는 값)
		
	$.ajax({
		type : "post",
		url : "/member/memberIdChk",
		data : data,
		success : function(result){
				
			if(result != 'fail'){
			  $('.id_input_re_1').css("display", "inline-block");
			  $('.id_input_re_2').css("display", "none");
			  idckCheck = true;
			}else{
			  $('.id_input_re_2').css("display", "inline-block");
			  $('.id_input_re_1').css("display", "none");
			  idckCheck = false;
			}
		}
	});
});
</script>

Controller 부분
@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
@ResponseBody
public String memberIdChkPOST(String memberId) throws Exception{
		
	int result = memberservice.idCheck(memberId);
		
	if(result != 0) {
		return "fail"; // 중복ID 존재 O
	}else {
		return "success"; // 중복ID 존재 X
	}
}

```

## 로그인 인터셉터적용
* 인터셉터 적용이유는 관리자권한이 없는자도 URL주소만 안다면 관리자페이지로 접근이 가능하여 이를 막기 위함.
* 회원가입 후 회원테이블의 adminCK 값이 0이면 회원, 1이면 관리자가 되도록 구현. (기본: 0)

<img src="https://user-images.githubusercontent.com/79797179/185789308-0f43662a-5611-41d6-b4af-163ed24e9dc7.png" width="90%">

<img src="https://user-images.githubusercontent.com/79797179/185789099-2a4b46b3-92c4-4c8c-9b3d-7be17f0ddeff.gif" width="90%">

***

### 이메일 인증 부분 (아래)
<img src="https://user-images.githubusercontent.com/79797179/183579758-6f447f7f-96c0-41b6-b31e-c722eb3c309b.gif" width="45%" height="330px">&nbsp;<img src="https://user-images.githubusercontent.com/79797179/183579782-51691ffa-d506-4371-ad62-716de0300702.png" width="45%">

***

### 주소 입력부 (Daum 주소 검색 API 적용)

```java

<script>
// Daum 주소 검색 API 적용
function execution_daum_address(){
    new daum.Postcode({
        oncomplete: function(data){
				
	    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기한다.
	     
	    var addr = ''; 	    // 주소 변수
	    var extraAddr = ''; // 참고항목 변수
				
	    // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	    if(data.userSelectedType === 'R'){
	        addr = data.roadAddress;
  	    }else{
	        addr = data.jibunAddress;
	    }
				
	    // 사용자가 선택한 주소
	    if(data.userSelectedType === 'R'){
					
	        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		    extraAddr += data.bname;
	        }
					
	        if(data.buildingName !== '' && data.apartment === 'Y'){
	            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	        }
					
	        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	        if(extraAddr !== ''){
		    extraAddr = ' (' + extraAddr + ')';
	        }
					
	        addr += extraAddr;
	    } else {
	
  	        addr += ' ';
	    }
				
	    $(".address_input_1").val(data.zonecode);
	    $(".address_input_2").val(addr);
				
	    $(".address_input_3").attr("readonly", false);
	    $(".address_input_3").focus();
        }
		
    }).open();
}
</script>

```

*** 

## 검색부분

<img src="https://user-images.githubusercontent.com/79797179/185794630-33a39103-d621-4061-9de1-b5438446da88.gif" width="90%">

***

## 카테고리 선택부분

<img src="https://user-images.githubusercontent.com/79797179/185795851-f0d00635-1322-41f4-b7c4-eb15831f9d4b.gif" width="90%">

***

## 장바구니 및 구매하기

<img src="https://user-images.githubusercontent.com/79797179/185796841-c6c379ee-2931-41ca-b81d-c47eb26c7f3f.gif" width="90%">

### + 관리자계정 구매제한

<img src="https://user-images.githubusercontent.com/79797179/185796325-e9b7bd75-d575-4ae0-8806-d165e0ca85f1.gif" width="90%">

***

<img src="" width="90%">

## <세부 사항>

* 회원가입 시 주소찾기 "다음 우편번호 API" 사용
* 주문금액이 30,000원이 넘으면 배송비 무료 (30,000미만 유료 : 3000원)
* 메인화면은 슬라이드 Slick-slider 라이브러리 사용

### 상품등록 부분
* 달력선택 부분은 "Datepicker 위젯" 사용
* 내용, 목차 부분은 "위지윅 에디터" 사용
* 장르 선택부분 상위 장르 변경 시 하위 장르는 초기화
