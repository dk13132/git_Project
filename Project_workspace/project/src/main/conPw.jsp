<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<head>
<style>
#passwordCss {margin: auto 0px; margin-left:0%;}
#conf{margin-top: 15%;}
#conf{margin-left: 10%;}
</style>
<title>본인 확인 페이지</title>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
</head>
<body onload="pageLoad()">
	<div id="wrap">
		<jsp:include page="/WEB-INF/view/head.jsp" flush="false" />
		<section id="content">
			<div id="leftcontent">
				<ul>
					<li><a class="active" href="conPw.do">내 정보 조회</a></li>
					<li><a href="">내 근태 조회</a></li>
				</ul>
			</div>
			<div id="rightcontent" style="padding:3%; solid #f0f0f0; background: white;min-height: 600px;">
					<form id="conf" onsubmit="return confirm()">
 						<p style="color:gray;">비밀번호 재 확인</p>
 						<p style="color:gray;">개인정보보호를 위해 비밀번호를 다시 한번 확인합니다.<br><br></p>
						<input type="password" name="password" id="password" placeholder="비밀번호를 입력하세요." style="width:250px;border:1px solid #ced4da;border-radius:.25rem;color:#495057;background-color:#fff;"> 
						<input type="submit" name="submit" id="submit" value="보내기" style="border:1px solid #ced4da;border-radius:.25rem;color:#495057;background-color:#fff;"> 
						<input type="hidden" name="rsint" id="rsint" value="${rsint}">
					</form>
				</div>
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
<script>
	function pageLoad() {
		var rsint = document.getElementById('conf').rsint.value;
		if (rsint == 1) {
			alert("비밀번호가 다릅니다.");
		}
	}

	function confirm() {
		var form = document.getElementById('conf');

		var password = form.password.value;
		if (password == "") {
			alert("비밀번호를 입력해주세요.");
			return false;
		} else {
			form.action = "conPw.do";
			form.method = "post";
			//	form.submit();
		}
	}
</script>
</body>
</html>