<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>

<link rel="stylesheet" href="<c:url value='/resources/css/reset.css?ver=1'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css?ver=1'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/deptcs.css'/>" />
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

</head>
<body>
<div>
<form action="updateDn.do" method="get" target="list">
<!-- form 태그의 target 속성은 폼 데이터(form data)를 서버로 제출한 후 받는 응답이 열릴 위치를 명시합니다. -->

<table id="resi1">

<tr><td><label for ="dept_no">부서번호&nbsp;:&nbsp;</label><input type="text" value="${user.dept_no}" name = "dept_no" id = "dept_no" readonly></td>
<td><label for ="dept_name">부서명&nbsp;:&nbsp;</label><input type="text" value="${user.dept_name}" name = "dept_name" id = "dept_name" readonly></td></tr>
<tr><td><label for ="dept_phoneNum">Tel.&nbsp;&nbsp;</label><input type="text" value="${user.dept_phoneNum}" name = "dept_phoneNum" id = "dept_phoneNum"></td>
<td><label for ="fax">Fax.&nbsp;&nbsp;</label><input type="text" value="${user.fax}" name = "fax" id = "fax"></td></tr>
<tr><td colspan = "2"><label for ="zipcode">우편번호&nbsp;:&nbsp;</label><input type="text" value="${user.zipcode}" name = "zipcode" id = "zipcode" readonly>
<input type="button" value = "우편번호" onClick="sample4_execDaumPostcode()"></td></tr>
<tr><td colspan = "2"><label for ="dept_addr">부서주소&nbsp;:&nbsp;</label><input type="text" value="${user.dept_addr}" name = "dept_addr" id = "dept_addr"></td></tr>
</table>
<br>
<div class="btncenter">
<input class="myButt" type ="submit" value="수정" onclick="window.close()">
</div>
</form>
</div>


</body>

<script>
	function sample4_execDaumPostcode() {
	   new daum.Postcode({
		    oncomplete: function(data) {
		     	document.getElementById('zipcode').value = data.zonecode;
		         document.getElementById("dept_addr").value = data.address;
		    }
		}).open();
	}

</script>
</html>