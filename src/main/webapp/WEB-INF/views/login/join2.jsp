<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!--  <script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"></script> -->
  <!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

   <style type="text/css">
      /* .help-block을 일단 보이지 않게 설정 */
      #myForm .help-block{
         display: none;
      }
      /* glyphicon을 일단 보이지 않게 설정 */
      #myForm . glyphicon{
         display: none;
      }
   </style>

</head>
<body>
<div class="container">
   <h3>회원가입 폼</h3>
   <form action="/join/insert" method="post" id="myForm">
   <input type="hidden" id="token" name="${_csrf.parameterName}" value="${_csrf.token}"/> <!-- 모든 폼에 다 필요해 -->
      <div class="form-group has feedback">
         <label class="control-label" for="user_id">아이디</label>
         <input class="form-control" type="text" name="user_id" id="user_id" required="required"/>
       
         <button type="button" id="idCheck">아이디 중복 확인</button> 
         <span id="overlapErr" class="help-block">사용할 수 없는 아이디 입니다.</span>
         <span class="glyphicon glyphicon-ok form-control-feedback"></span>
         
      </div>      <!-- input name은 securityConfig에서  정해주었습니다-->
      <div class="form-group has-feedback">
      
         <label class="control-label" for="name">이름</label>
         <input class="form-control" type="text" name="name" id="name" required="required"/>
      </div>
      <div class="form-group has feedback">
      
         <label class="control-label" for="pwd">비밀번호</label>
         <input class="form-control" type="password" name="pwd" id="pwd" required="required"/>
         
         <span id="pwdRegErr" class="help-block">숫자와 글자 조합으로 6글자 이상 10글자 이하를 입력하세요</span>
         <span class="glyphicon glyphicon-ok form-control-feedback"></span>
      </div>
   
      <div class="form-group has feedback">
         <label class="control-label" for="rePwd">비밀번호 재확인</label>
         <input class="form-control" type="password" name="rePwd" id="rePwd" required="required"/>
         <span id="rePwdErr" class="help-block">비밀번호와 일치하지 않습니다. 다시 입력해 주세요.</span>
         <span class="glyphicon glyphicon-ok form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
         <label class="control-label" for="email">이메일</label>
         <input class="form-control" type="email" name="email" id="email" required="required" placeholder="user@petwego.com"/>
         <span id="emailErr" class="help-block">올바른 이메일 형식이 아닙니다. 다시 입력해 주세요.</span>
         <span class="form-control-feedback"></span>
      </div>
      
      <div class="form-group has-feedback">
         <label class="control-label" for="tel">전화번호</label>
         <input class="form-control" type="text" name="tel" id="tel" required="required" placeholder="01011112222"/>
         <span id="emailErr" class="help-block">올바른 이메일 형식이 아닙니다. 다시 입력해 주세요.</span>
         <span class="form-control-feedback"></span>
      </div>
        
      <div class="form-group has-feedback">
         <label class="control-label" for="birth">생년월일</label>
         <input class="form-control" type="text" name="birth" id="birth" required="required" placeholder="2020-06-12"/>
         <span class="form-control-feedback"></span>
      </div>
        <div class="form-group has-feedback">
        <label class="control-label" for="address">주소</label><br/>                   
		<input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="address" id="address" type="text" readonly="readonly"/>
		    <button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>                               
	  </div>
	  <div class="form-group has-feedback">
		<input class="form-control" style="top: 5px; width: 40%; display: inline;" placeholder="도로명 주소" name="address2" id="address2" type="text" readonly="readonly"/>
	  </div>
	  <div class="form-group has-feedback">
		<input class="form-control" style="width: 40%; display: inline;" placeholder="상세주소" name="address3" id="address3" type="text"/>
	  </div>
      
      <div class="form-group has-feedback">
         <label class="control-label" for="gender">성별</label>
         <select class="form-control" id="gender" name="gender">
            <option value="female">여성</option>
            <option value="male">남성</option>
         </select>
      </div>
       <div class="form-group has-feedback">
         <label class="control-label" for="fname">프로필 사진</label>
         <input class="form-control" type="file" name="fname" id="fname" required="required"/>
         <span class="form-control-feedback"></span>
      </div>
      <div class="form-group has feedback">
         <label class="control-label" for="nick_name">닉네임</label>
         <input class="form-control" type="text" name="nick_name" id="nick_name" required="required"/>
       
         <button type="button" id="nickCheck">닉네임 중복 확인</button> 
         <span id="overlapNick" class="help-block">이미 존재하는 닉네임입니다.</span>
         <span class="glyphicon glyphicon-ok form-control-feedback"></span>
         
      </div> 
      
      <div class="form-group">
           <label for="comment">소개글:</label>
           <textarea class="form-control" rows="5" id="comment"></textarea>
      </div>
      <button class="btn btn-success" id="btn">가입</button>
   </form>
</div>
	
</body>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/resources/js/addressapi.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
//아이디 중복체크 등 건너뛰면 가입도 안되게 처리 해야하는데!!!
//성공적이면 "회원가입 성공!"멘트 뜨게!어떻게 하지?
$("#btn").on("click", function(){
	alert("회원가입 성공");
	
})
//아이디 중복체크
var idx = false;
	$("#idCheck").on("click", function(){ 
		
		 $.ajax({
	         url: "${pageContext.request.contextPath}/join/idCheck",
	         type: "GET",
	         data: {user_id:$("#user_id").val()},
	         success: function(data) {
	            //사용 가능한 아이디라면
		    if(data==0 && $.trim($('#user_id').val()) != '' ){   
		       idx=true;
			   $('#user_id').attr("readonly",true);
		       $("#overlapErr").hide();
		       successState("#user_id");
		       alert("사용가능한 아이디입니다.");
		    //정규표현식을 통과하지 못하면
		    }else{
		       $("#overlapErr").show();
		       errorState("#user_id");
		       return false;
		    }
	    }
	 })
	});
//닉네임 중복체크
$("#nickCheck").on("click", function(){ 
	
	 $.ajax({
         url: "${pageContext.request.contextPath}/join/nickCheck",
         type: "GET",
         data: {nick_name:$("#nick_name").val()},
         success: function(data) {
            //사용 가능한 아이디라면
	    if(data==0 && $.trim($('#nick_name').val()) != '' ){   
	       idx=true;
		   $('#nick_name').attr("readonly",true);
	       $("#overlapNick").hide();
	       successState("#nick_name");
	       alert("사용가능한 닉네임입니다.");
	    //정규표현식을 통과하지 못하면
	    }else{
	       $("#overlapNick").show();
	       errorState("#nick_name");
	    }
    }
 })
});
//비밀번호 유효성 검사    
   $("#pwd").keyup(function(){   //오류 수정 필요! - 1. 비밀번호가 8글자 이하인데 에러메시지가 뜨지 않고 2. 비밀번호가 일치해도 오류 메시지 뜸
      var pwd = $('#pwd').val();
      //비밀번호를 검증할 정규 표현식
      var reg = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{6,10}$/;
      //정규표현식을 통과한다면
      if(reg.test(pwd)){   //test() - 찾는 문자열이, 들어있는지 아닌지를 알려줍니다 / 문장 안에 찾으려는 문자가 들어있으면, 결과는 "true"
         $("#pwdRegErr").hide();
         successState("#pwd");
      //정규표현식을 통과하지 못하면
      }else{
         $("#pwdRegErr").show();
         //errorState("#pwd");
      }
   });
   //비밀번호 재확인
   $("#rePwd").keyup(function(){
      var rePwd = $('#rePwd').val();
      //비밀번호가 일치하는지 확인
      if(rePwd==$('#pwd').val()){ //비밀번호가 일치하면
         $("#rePwdErr").hide();
   
      }else{   //비밀번호가 불일치한다면
         $("#rePwdErr").show();
         //errorState("#rePwd");
      }
  	 });
   //이메일 유효성 검사
   $("#email").keyup(function(){
       var email=$(this).val();
       // 이메일 검증할 정규 표현식
       var reg=/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
//     var reg = /^[0-9a-zA-Z][0-9a-zA-Z\_\-\.\+]+[0-9a-zA-Z]@[0-9a-zA-Z][0-9a-zA-Z\_\-]*[0-9a-zA-Z](\.[a-zA-Z]{2,6}){1,2}$/;
       if(reg.test(email)){//정규표현식을 통과 한다면
                   $("#emailErr").hide();
                   successState("#email");
       }else{//정규표현식을 통과하지 못하면
                   $("#emailErr").show();
                   errorState("#email");
       }
   });
   
   //성공 상태로 바꾸는 함수
   function successState(sel){
      $(sel)
      .parent()
      .removeClass("has-error")
      .addClass("has-success")
      .find(".glyphicon")
      .removeClass("glyphicon-remove")
      .addClass("glyphicon-ok")
      .show();
      
      $("#myForm button[type=submit]").removeAttr("disabled");
   }
 
   //에러 상태로 바꾸는 함수
   function errorState(sel){
      $(sel)
      .parent()
      .removeClass("has-success")
      .addClass("has-error")
      .find(".glyphicon")
      .removeClass("glyphicon-ok")
      .addClass("glyphicon-remove")
      .show();
      $("#myForm button[type=submit]").attr("disabled", "disabled");
   };
   
   function execPostCode() {
       new daum.Postcode({
           oncomplete: function(data) {
              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
              // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
              // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
              var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
              var extraRoadAddr = ''; // 도로명 조합형 주소 변수
              // 법정동명이 있을 경우 추가한다. (법정리는 제외)
              // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
              if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                  extraRoadAddr += data.bname;
              }
              // 건물명이 있고, 공동주택일 경우 추가한다.
              if(data.buildingName !== '' && data.apartment === 'Y'){
                 extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
              }
              // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
              if(extraRoadAddr !== ''){
                  extraRoadAddr = ' (' + extraRoadAddr + ')';
              }
              // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
              if(fullRoadAddr !== ''){
                  fullRoadAddr += extraRoadAddr;
              }
              // 우편번호와 주소 정보를 해당 필드에 넣는다.
              console.log(data.zonecode);
              console.log(fullRoadAddr);
              
              
//              $("[name=addrress]").val(data.zonecode);
//              $("[name=address2]").val(fullRoadAddr);  
           	  // 우편번호와 주소 정보를 해당 필드에 넣는다.
              document.getElementById('address').value = data.zonecode; //5자리 새우편번호 사용
              document.getElementById('address2').value = fullRoadAddr;

              //self.close();
          }
       }).open();
   }

</script>
</html>