<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/login.css'/>" />
<title>로그인 화면</title>
    <style>
        #loginVeiwcss {width: 100%; border: 0; font-family: 'Noto Sans KR', sans-serif;  text-align: center }
        #loginVeiwcss div {width: 185px; height: auto; margin: 0 auto; margin-top: 120px;}
        #loginVeiwcss div img{ width: 100%; height: 100%;}
        #loginVeiwcss form {width: 300px; margin: auto; margin-top: 50px;}
        #loginVeiwcss form input {width: 300px; height: 35px;border: 1px rgb(167, 167, 167) solid;}
        #loginVeiwcss form input:first-child {border-radius: 4px 4px 0px 0px; }
        #loginVeiwcss form input:nth-child(2) {border-radius: 0px 0px 4px 4px; margin-top: -1px;}
        #loginVeiwcss form input:last-child {border-radius: 3px 3px 3px 3px;width: 308px; background-color: #a30505; margin-top: 15px; color: #fff; outline: 0; border: 0;height: 42px; font-size: 16px; font-weight: bold;}
        #loginVeiwcss ul{display: inline-block; margin: 170px; font-size: 12px; color: #1d1d1d; font-weight: 35o;}
        #loginVeiwcss ul li {float: left; margin-right: 5px; }
        #loginVeiwcss ul li:last-child {margin-right: 0px;}
        .inp_text input {display: block; width: 100%; height: 100%; font-size: 12px; color: #000; border: none; outline: 0; background-color: transparent;}
    </style>
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
    <div id="loginVeiwcss">
        <div>
        <img src="resources/img/logo.png">
        </div>
           <form method="post" name="form" onsubmit="return check()">  
            <input class=".inp_text input" type="text" name="employee_no" placeholder="    ID">
            <input class=".inp_text input" type="password" name="password" placeholder="    Password"> 
            <input type="submit" value="로 그 인">
        </form>
        
        <ul>
            <li>관리자정보  | </li>
            <li>123@naver.com  |</li>
            <li>tel 123-4567</li>
        </ul>
    </div>
</body>
</html>