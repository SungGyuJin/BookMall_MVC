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

## 목차

### 1. 로그인 및 회원가입 부분
- 로그인, 로그아웃 처리 (Ajax ID 중복검사, 주소API, E-mail 인증)
- 로그인 인터셉터(관리자, 이용자 계정 구분)
### 2. 이용자페이지 부분
- 검색
- 카테고리
- 장바구니 (수량 설정, 포인트 설정, 인터셉터적용)
- 주문 후 정보변화 (ex. 금액, 포인트, 재고)
- 댓글기능 (리뷰)
- 배송현황 (주문 취소)

***

## 데이터베이스 모델링

<img src="https://user-images.githubusercontent.com/79797179/185130810-bc3ee493-9e89-4103-9e7c-52fd8e601fbc.png" width="90%">

***

# 1. 로그인 및 회원가입 부분

#### 로그아웃 (비동기 로그아웃)

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

Controller 부분
@RequestMapping(value = "logout.do", method = RequestMethod.POST)
@ResponseBody
public void logoutPOST(HttpServletRequest request) throws Exception {

    HttpSession session = request.getSession();

    session.invalidate();
}

```

<img src="https://user-images.githubusercontent.com/79797179/185788109-49213c14-e4dd-4e47-8159-b7b49095b670.gif" width="90%">

#### 회원가입 유효성 (아래)

<img src="https://user-images.githubusercontent.com/79797179/184847874-4859b201-ace9-4555-bb5c-63993c3f6b80.gif" width="90%">

### ID 중복검사 (Ajax 적용) (아래)

```java

<script>
$('.id_input').on("propertychange change keyup paste input", function(){
		
    var memberId = $('.id_input').val();	// ID 입력 값
    var data = {memberId : memberId};		// Controller에 넘길 데이터 이름 : 데이터(ID에 입력 되는 값)
		
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

***

## 비밀번호 인코딩 설정(BCryptPasswordEncoder 적용)

DB에 저장되는 여러가지 요소들이 있지만 비밀번호는 조금 더 유의해야 한다고 생각합니다. 실질적으로 DB측에서도 자체보안이 되겠지만 이마저도 뚫리게 된다면 비밀번호 역시 바로 노출이 됩니다. 이를 방지하기위해 다시 비밀번호를 암호화하는 것입니다. 개인적인 경험이지만 어릴적 분실한 비밀번호 찾기를 할 때 왜 그전에 설정한 비밀번호를 알려주지 않고 왜 무조건 재설정을 해야만하는가? 에 대한 의문이 풀린 개념입니다.

* web.xml 일부.

<img src="https://user-images.githubusercontent.com/79797179/185823369-33cd9f42-afbc-4be2-a611-e5cd928f3799.png" width="45%">

* security-context.xml 일부.

```java

<bean id="bcruptPasswordEncoder" class="org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder"></bean>

```

* 해당 Controller 일부.

```java

@Autowired
private BCryptPasswordEncoder pwEncoder;

'''
(중략)
'''

@RequestMapping(value = "/join", method = RequestMethod.POST)
public String joinPOST(MemberVO member) throws Exception {

    String rawPw = "";	     // 인코딩 전 PW 변수선언
    String encodePw = "";    // 인코딩 후 PW 변수선언

    rawPw = member.getMemberPw(); 	// 인코딩 전 PW
    encodePw = pwEncoder.encode(rawPw); // PW 인코딩
    member.setMemberPw(encodePw); 	// 인코딩된 PW를 member 객체에 저장

    // 회원가입완료
    memberservice.memberJoin(member);

    return "redirect:/main";
}

```
* 회원가입 후 PW 결과.

<img src="https://user-images.githubusercontent.com/79797179/185824623-0328ed98-3399-4ed6-862d-c2b736772dc5.png" width="">

***

## 로그인 인터셉터적용
* 인터셉터 적용이유는 관리자권한이 없는자도 URL주소만 안다면 관리자페이지로 접근이 가능하여 이를 막기 위함.
* 회원테이블의 adminCk 값이 0이면 회원계정, 1이면 관리자계정이 되도록 구현. (기본: 0)

  (adminCk 값은 회원가입 후 쿼리문에서 직접 수정하였습니다.)

```java

UPDATE book_member SET adminCk = 1 WHERE memberId='admin';

```
  
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
***

# 2. 이용자페이지 부분

## 검색부분

<img src="https://user-images.githubusercontent.com/79797179/185794630-33a39103-d621-4061-9de1-b5438446da88.gif" width="90%">

***

## 카테고리 선택부분

<img src="https://user-images.githubusercontent.com/79797179/185795851-f0d00635-1322-41f4-b7c4-eb15831f9d4b.gif" width="90%">

***

## 장바구니 및 구매하기 (관리자계정 구매제한)

* 장바구니 관련 class에서 장바구니 담기 동작 에러: 0, 담기완료: 1, 이미 추가됨: 2, 로그인 안되어 있을 시: 3 을 반환하도록 구현.

```java

// 장바구니 추가 버튼
$(".btn_cart").on("click", function(e) {
    
    if($("input[name=buy_inputChk]").val() == "admin") {
        alert("관리자계정 이용불가.");
        return false;
    }

    form.bookCount = $(".quantity_input").val();
		
    $.ajax({

        url : "/cart/add",
        type : "POST",
        data : form,
        success : function(result) {
            cartAlert(result);
        }
    });
});

function cartAlert(result) {
		
    if (result == '0') {
        alert("장바구니 에러.");
    } else if (result == '1') {
        alert("장바구니 추가완료.");
    } else if (result == '2') {
        alert("장바구니에 이미 추가됨.");
    } else if (result == '3') {
        alert("로그인이 필요합니다.");
    }
}

// 구매 버튼
$(".btn_buy").on("click", function() {

    let bookCount = $(".quantity_input").val();

    $(".order_form").find("input[name='orders[0].bookCount']").val(bookCount);

    if (!$("input[name=buy_inputChk]").val()) {
        alert("로그인이 필요합니다.");
        return false;
    } else if ($("input[name=buy_inputChk]").val() == "admin") {
        alert("관리자계정 이용불가.");
        return false;
    }
			
    $(".order_form").submit();
});

```

<img src="https://user-images.githubusercontent.com/79797179/185839136-bbab76f7-3fa5-4ab9-ba14-961f21823e7b.gif" width="90%">

* 관리자계정의 구매제한은 아래 코드를 담기버튼과 구매하기 버튼에 똑같이 추가.

  (memberId가 "admin"인 경우는 관리자계정말고는 없음을 참고바랍니다.)

```java
<!-- form 일부 -->
<input type="hidden" name="buy_inputChk" value="${member.memberId}">

if($("input[name=buy_inputChk]").val() == "admin") {
    alert("관리자계정 이용불가.");
    return false;
}
```

<img src="https://user-images.githubusercontent.com/79797179/185796325-e9b7bd75-d575-4ae0-8806-d165e0ca85f1.gif" width="90%">

***

## 수량설정

<img src="https://user-images.githubusercontent.com/79797179/185840326-f0d9b8b9-c60a-4136-8613-85f197f35acc.gif" width="90%">

***

## 포인트사용

<img src="https://user-images.githubusercontent.com/79797179/185839799-987c52c2-e050-4a77-90d2-7f26face7a16.gif" width="90%">

***

## 장바구니 인터셉터 적용

적용이유는 앞서 소개된 "로그인 인터셉터" 와 동일합니다. 로그인 한 이용자만이 해당 계정을 쓸 수 있도록 하기 위함입니다.

* CartInteceptor class가 스프링에서 관리될 수 있도록 servlet-context.xml 에 추가.

  (해당클래스는 HandlerInterceptor 상속)
  
```java
// servlet-context.xml 일부
<interceptor>
    <mapping path="/cart/**"/> <!-- /cart/url의 모든 request는 CartInteceptor를 거치게 할것임. -->
    <beans:bean id="CartInterceptor" class="com.mine.interceptor.CartInterceptor"></beans:bean>
</interceptor>
```

* url에 /cart/** 를 타고 오는 모든 request들은 요청자가 로그인 유무를 가려내기 위함입니다.

* 장바구니페이지에서 로그아웃 시 메인페이지로 돌아 가게되고 이미 로그인 되있는 상태라면 Controller로 진행.

* 로그인 성공시 사용자정보를 변수 mvo에 저장.

* 장바구니 정보는 mvo에 사용자정보가 있냐 없냐의 차이

* 즉, 로그인 판단여부와 동시에 장바구니에 사용자 정보까지 저장.

```java
// CartInterceptor class 일부 
@Override
public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
    throws Exception {

    HttpSession session = request.getSession();

    MemberVO mvo = (MemberVO) session.getAttribute("member");
    
    if (mvo == null) {
        response.sendRedirect("/main");
        return false;
    } else {
        return true;
    }
}
```

<img src="https://user-images.githubusercontent.com/79797179/185842147-8a9f984c-ff36-4b54-8365-ea3695946cd9.gif" width="90%">

***

## 결제 후 정보변화

|---|결제 전|사용정보|결제 후|
|:---:|:---:|:---:|:---:|
|금액|1,000,000 원|18,200 원|981,800 원|
|포인트|1,000 P|1,000 P|810P (810P 적립)|
|재고|100권|1 권|99 권|

* 설명을 위해 비밀번호는 미리 설정해놓았습니다.

<img src="https://user-images.githubusercontent.com/79797179/185842347-4ae975b6-a4ca-4e48-9c5d-c7fc3fd57e89.gif" width="90%">

***
***

## 앞으로 추가 되어야 할 부분

- 댓글(기능) 처리
- 주문현황

## Mistake & Feel a Point

- 기본적으로 자잘한 오타.

- **Mapper.xml select문 처리시 반환 값을 적지않은 오류 -> 반환값을 적음으로 해결.
```java
<select id="bookGetList" resultType="com.mine.model.BookVO">
```

- form 안의 input name 값을 DAO 클래스의 멤버변수와 일치 시키지못해 생긴 오류.

- form method 방식과 Controller method 방식 불일치.

- 로그아웃 버튼 무반응 -> 해당 Controller 해당 메소드의 @ResponseBody를 붙임으로 해결.

- css 작성시 변화되지않는 요소들 -> css 페이지내 중복선택자제거.

- jstl 사용시 <c:forEach>문은 리스트형을 받아야함.

  (상세정보같은 하나의 정보만을 가지고는 <c:forEach>문 사용불가.)
  
> 뭔가 큰 기술적인 오류보다는(기술적인 것도 없지만..) 보시다시피 기본적인 것들이 오류의 주를 이루었다. 대부분의 오류들은 오타수정으로 해결이 되었고, 문법적으로 개념을 알고 있는 경우에도 실수가 잦았다. 이런 실수 하나하나가 개발능률을 떨어뜨린다고 생각한다. 오류가 나더라도 아주 기본적인 부분부터 봤으면 해결됐을 문제들이 많았는데, 기본보다는 "내가 개념을 잘못 알고있나?" 라는 생각에 빠져 시간을 낭비한 경험들이 프로젝트 중간중간에 있었다. 기본을 중요시하자.

# 프로젝트는 계속 진행중인 상태입니다.

