<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
</head>
<body>
<center>
<div>

<form action="update.do" method="get" target="list">
<!-- form 태그의 target 속성은 폼 데이터(form data)를 서버로 제출한 후 받는 응답이 열릴 위치를 명시합니다. -->
<br>
<table frame="void" style="margin:auto" width="500">

<tr><td><label for ="dept_no"><b>부서번호&nbsp:&nbsp</b></label><input style="width:128px;" type="text" value="${user.dept_no}" name = "dept_no" id = "dept_no" readonly></td>
<td><label for ="dept_name"><b>부서명&nbsp:&nbsp</b></label><input style="width:147px;" type="text" value="${user.dept_name}" name = "dept_name" id = "dept_name" readonly></td></tr>
<tr><td><label for ="dept_phoneNum"><b>Tel.&nbsp&nbsp</b></label><input type="text" value="${user.dept_phoneNum}" name = "dept_phoneNum" id = "dept_phoneNum"></td>
<td><label for ="fax"><b>Fax.&nbsp&nbsp</b></label><input type="text" value="${user.fax}" name = "fax" id = "fax"></td></tr>
<tr><td colspan = "2"><label for ="zipcode"><b>우편번호&nbsp:&nbsp</b></label><input type="text" value="${user.zipcode}" name = "zipcode" id = "zipcode" readonly>
<input type="button" value = "우편번호" onClick="sample4_execDaumPostcode()"></td></tr>
<tr><td colspan = "2"><label for ="dept_addr"><b>부서주소&nbsp:&nbsp</b></label><input style="width:400px;" type="text" value="${user.dept_addr}" name = "dept_addr" id = "dept_addr" style="width:435px;"></td></tr>
</table>
<br>
<input type ="submit" value="수정" onclick="window.close()">
</form>
</div>
</center>


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

	/* function popupClose(form){

		form.submit();

	} */
</script>
</html>