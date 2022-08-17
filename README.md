# 인터넷서점 서비스 (22/07/04 ~ 진행중) _ 개인프로젝

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

## 사용방법

### 1. 로그인 및 회원가입 화면 (아래)

<img src="https://user-images.githubusercontent.com/79797179/184847870-cf0a3422-74e7-4122-9dd8-dff2d79f4ff9.gif" width="49%" height="616px">&nbsp;<img src="https://user-images.githubusercontent.com/79797179/184847874-4859b201-ace9-4555-bb5c-63993c3f6b80.gif" width="50%">

* ID 중복검사는 Ajax를 적용하였습니다.

<details>
 <summary>(클릭) Ajax 부분</summary>

```
// ID 중복검사
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
```
</details>

<details>
 <summary>(클릭) Controller 부분</summary>
 
```
// ID 중복검사
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
</details>

* 로그인 인터셉터적용
  
<details>
<summary>(클릭) 인터셉터적용</summary>
<img src="https://user-images.githubusercontent.com/79797179/184894822-2a62c990-f9be-44e0-b9d1-ad4fbf39073f.gif" width="85%">
<img src="https://user-images.githubusercontent.com/79797179/184893288-2a016eca-39ea-4c8c-9d6e-a5d373f4c6c9.png" width="85%">

* 인터셉터 적용이유는 관리자권한이 없는자도 URL주소만 안다면 관리자페이지로 접근이 가능하여 이를 막기 위함.
* 회원가입 후 회원테이블의 adminCK 값이 0이면 회원, 1이면 관리자가 되도록 구현. (기본: 0)
</details>

***

### 이메일 인증 부분 (아래)
<img src="https://user-images.githubusercontent.com/79797179/183579758-6f447f7f-96c0-41b6-b31e-c722eb3c309b.gif" width="50%">&nbsp;<img src="https://user-images.githubusercontent.com/79797179/183579782-51691ffa-d506-4371-ad62-716de0300702.png" width="45%">

***

### 주소찾기 부분 (아래)

<img src="https://user-images.githubusercontent.com/79797179/183598131-71ffecd2-f37b-4d00-8b08-9f9996afd111.gif">

***

### 사이트 둘러보기 (아래)

<img src="https://user-images.githubusercontent.com/79797179/183590021-44cbe007-aef1-43e4-ab85-28f0b5872313.gif">

***

### 주문하기 (아래)

<img src="https://user-images.githubusercontent.com/79797179/184896828-3936fefd-602d-40ac-885a-08837908f251.gif" width="85%">

***

### 배송비 유무 (아래)

<img src="https://user-images.githubusercontent.com/79797179/183591164-3f284009-b410-4d45-8c22-5e6416de69f6.gif">

***

### 포인트사용 유무 (아래)

<img src="https://user-images.githubusercontent.com/79797179/183594144-38f151cd-8bfe-490f-bfed-324fe49e9f1a.gif">

***

### 도서등록 일부 (아래)

<img src="https://user-images.githubusercontent.com/79797179/183594992-cad6f321-18e0-4181-a4a3-e80a0bb7894b.gif">

<img src="https://user-images.githubusercontent.com/79797179/183600896-17143ce3-cef0-4d43-b0fe-db4ef89bba53.png" width="100%" height="500px">

*** 

## <세부 사항>

* 회원가입 시 주소찾기 "다음 우편번호 API" 사용
* 주문금액이 30,000원이 넘으면 배송비 무료 (30,000미만 유료 : 3000원)
* 메인화면은 슬라이드 Slick-slider 라이브러리 사용

### 상품등록 부분
* 달력선택 부분은 "Datepicker 위젯" 사용
* 내용, 목차 부분은 "위지윅 에디터" 사용
* 장르 선택부분 상위 장르 변경 시 하위 장르는 초기화
