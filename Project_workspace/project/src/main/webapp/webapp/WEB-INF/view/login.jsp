<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인 화면</title>
<script>
	function check() {
		var employee_no = form.employee_no.value;
		var password = form.password.value;

		if (employee_no.trim() == "") {
			alert("아이디를 입력해주세요");
			return false;
		} else if (password.trim() == "") {
			alert("비밀번호를 입력해 주세요");
			return false;
		}
		return true;
	}
</script>

<c:if test="${check == 0 }">
	<script>
		alert("아이디가 맞지 않습니다.");
	</script>
</c:if>
<c:if test="${check == 1}">
	<script>
		alert("비밀번호가 맞지 않습니다.");
	</script>
</c:if>
</head>
<body>
	<form method="post" name="form" onsubmit="return check()">
		사번 : <input type="text" name="employee_no"><br> 비밀번호 : <input
			type="password" name="password"><br> <input
			type="submit">
	</form>
</body>
</html>