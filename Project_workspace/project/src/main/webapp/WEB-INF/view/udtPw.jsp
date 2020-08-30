<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
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
</head>
<body>

	<form id="updPw">
		기존 비밀번호 : <br>
		<input type="password" name="password" id="password"><br>

		새로운 비밀번호 : <br> 
		<input type="password" name="password2" id="password2" class="form-control" required><br> 
		
		비밀번호확인 : <br> 
		<input type="password" name="repassword2" id="repassword2" class="form-control" required><br>
		<div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div>
		<div class="alert alert-success" id="alert-fail">비밀번호가 일치하지 않습니다.</div>

		<input type="button" name="submit" id="submit" value="비밀번호 변경">
		<input type="button" name="cancel" id="cancel" value="취소">
	</form>
</body>
</html>