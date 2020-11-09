<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
</head>
<body>
<div id="wrap">
<section id="header">
	<div id=headerwrap>
    	<div class="logo">
        	<img src="resources/img/logo.png" alt="">
		</div>
	</div>
</section>
<section id="content" style="width:600;width: 100%;margin: 0 auto;max-width: 1200px;padding: 16px;">
<div id="rightcontent" style="text-align:center; padding-top:3%; border-left:2px solid #f0f0f0; padding-left:10%; padding-bottom:10%;width: 750px; background: white;min-height: 600px;">
	<form id="updPw" style="text-align:center; max-width: 300px; width: 100%; margin: 0 auto;">
	<br>
		<font size="5" color="gray">비밀번호 변경</font></b><br><br>
			<input type="password" name="password" id="password" placeholder="현재 비밀번호" style="border:1px solid #ced4da;border-radius:.25rem;color:#495057;background-color:#fff;width: 100%;" required><br><br>
			<input type="password" name="password2" id="password2" placeholder="새로운 비밀번호" style="border:1px solid #ced4da;border-radius:.25rem;color:#495057;background-color:#fff;width: 100%;" required><br><br> 
			<input type="password" name="repassword2" id="repassword2" placeholder="비밀번호 확인" style="border:1px solid #ced4da;border-radius:.25rem;color:#495057;background-color:#fff;width: 100%;" required><br>
		<div id="alert-success">비밀번호가 일치합니다.</div>
		<div id="alert-fail">비밀번호가 일치하지 않습니다.</div><br>


		<input type="button" name="submit" id="submit" value="비밀번호 변경" style="border:1px solid #ced4da;border-radius:.25rem;color:#495057;background-color:#fff;">
		<input type="button" name="cancel" id="cancel" value="취소" style="border:1px solid #ced4da;border-radius:.25rem;color:#495057;background-color:#fff;">
	</form>
</div>	
</section>
</div>
<script>
	$(document).ready(function(){
		//기존 비밀번호 일치 확인 > 시간되면!

		$("#alert-success").hide();
		$("#alert-fail").hide();

		// 새 비밀번호 일치 확인
		$("input").on('keyup',function(){

			var pw1 = $("#password2").val();
			var pw2 = $("#repassword2").val();
			
			if(pw1 != "" || pw2 != ""){
				if(pw1 == pw2){
					$("#alert-success").show();
					$("#alert-fail").hide();
					$("#submit").removeAttr("disabled");
				}else{
					$("#alert-success").hide();
					$("#alert-fail").show();
					$("#submit").attr("disabled","disabled");
				}
			}
		});

		// 비밀번호 수정 버튼
		$("#submit").on('click',function updPw() {
			var result = confirm("수정하시겠습니까?");
			if (result) {
				
/* 				alert("수정되었습니다."); 내정보 페이지에서 콜백으로 비밀번호 변경 정상 적용 알럿 시켜주기! */
				$.ajax({
					type : "POST",
					url : "udtPw.do",
					data : "password=" + $("#password").val() + "&password2=" + $("#password2").val(),
					dataType : "json"
				}).done(function(map){	
						if(map.errCode == "0") {
							alert(map.errMsg);
							window.close();
						}
						else if(map.errCode =="1") {
							alert(map.errMsg);
							}
					});
			}else {
				alert("취소되었습니다.");
			}
		});
	
		// 취소 버튼
		$("#cancel").on('click', function cclPw(){
			window.close();
		});
	});
</script>
</body>
</html>