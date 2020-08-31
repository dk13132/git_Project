<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>본인 확인 페이지</title>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>
	function pageLoad(){
		var rsint = document.getElementById('conf').rsint.value;
		if(rsint == 1) {
			alert("비밀번호가 다릅니다.");
		} 
	}
	
	function confirm() {
		var form = document.getElementById('conf');

		
		var password = form.password.value;
		if (password == "") {
			alert("비밀번호를 입력해주세요.");
			return false;
		} 
		else {
			form.action = "conPw.do";
			form.method = "post";
		//	form.submit();
			}
	}		
			
</script>

</head>
<body onload="pageLoad()">
	<form id="conf" onsubmit="return confirm()">
		<input type="hidden" name="employee_no" value="${mc_employee_no}">
		<input type="password" name="password" id="password" placeholder="비밀번호를 입력하세요." /> 
		<input type="submit" name="submit" id="submit" value="보내기">
		<input type="hidden" name="rsint" id="rsint" value="${rsint}">
	</form>
</body>
</html>