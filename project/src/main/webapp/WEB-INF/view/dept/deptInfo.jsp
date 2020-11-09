<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/deptcs.css'/>" />

</head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>
	$(function() {

		var dept_name = "";

		$(".depts").on(
				"click",
				function() {

					dept_name = $(this).attr('value');

					var url = "emps.do";
					var params = "dept_name=" + dept_name;

					//$('#empList').empty();

					$.ajax({
						type : "get",
						url : url,
						data : params,
						dataType : "json"
					}).done(
							function(args) {
								$("#empList").find("tbody:gt(0)").remove();

								for (var idx = 0; idx < args.length; idx++) {

									$("#empList").append(
											"<tbody><tr><td>" + args[idx].name
													+ "</td><td>"
													+ args[idx].dept_name
													+ "</td><td>"
													+ args[idx].position
													+ "</td><td>"
													+ args[idx].email
													+ "</td><td>"
													+ args[idx].phone
													+ "</td></tr></tbody>");
								}
							})

					.fail(function(e) {
						alert(e.responseText);

					})
				});

	});
</script>


<body>
	<div id="wrap">
		<jsp:include page="/WEB-INF/view/head.jsp" flush="false" />
		<div id="content">
			<div id="leftcontent">
				<ul>
					<li><a class="active" href="list.do">부서관리</a></li>
					<li><a href="authority.do">권한관리</a></li>
				</ul>
			</div>
			<div id="rightcontent">
				<h2>부서관리</h2>
				<b>전체 부서&nbsp;:&nbsp;${list.count}</b>
				<form id="deptformlist" action="delete.do" method="get"
					name="removefrm" onsubmit="return removeCheck()">
					<table id="empSty">
						<tr>
							<th>순번</th>
							<th>부서no.</th>
							<th>부서명</th>
							<th>부서 주소</th>
							<th>Tel.</th>
							<th>Fax.</th>
							<th>상태</th>
						</tr>
						<c:forEach var="row" items="${list.boardList}">
							<tr>
								<td><c:out value="${number}" /> <c:set var="number"
										value="${number - 1}" /></td>
								<td>${row.dept_no}</td>
								<td><a href="javascript:void(0);" class="depts"
									value="${row.dept_name}">${row.dept_name}</a></td>
								<td>${row.dept_addr}</td>
								<td>${row.dept_phoneNum}</td>
								<td>${row.fax}</td>
								<td><input type="checkbox" id="delete_dept"
									name="delete_dept" value="${row.dept_no}"></td>
							</tr>
						</c:forEach>
					</table>
					<div class="relbut">
					<button class="myButt" type="button" onclick="updateOpen();">수정</button>
					<input class="myButt" type="submit" value="삭제">
					</div>
				</form>
				<div class = "paging">
					<c:if test="${list.count > 0}">
						<c:if test="${list.p.beginPageNumber > 5}">
							<a href="list.do?p=${list.p.beginPageNumber-1}"><<</a>&nbsp;
		</c:if>
						<c:forEach var="pno" begin="${list.p.beginPageNumber}"
							end="${list.p.endPageNumber}">
							<a href="list.do?p=${pno}">[${pno}]</a>
						</c:forEach>
						<c:if test="${list.p.endPageNumber < list.p.totalPageCount}">
						&nbsp;<a href="list.do?p=${list.p.endPageNumber + 1}">>></a>
						</c:if>
					</c:if>
				</div>
				<div class = "register"><p>신규부서 등록<p>
				<form action="insert.do" method="get" name="deptinput"
					onSubmit="return checkIt()">
					<table id="resi">
						<tr>
							<td><label for="dept_no">부서번호&nbsp;:&nbsp;</label><input
								type="text" value="" name="dept_no" id="dept_no"></td>
							<td><label for="dept_name">부서명&nbsp;:&nbsp;</label><input
								type="text" value="" name="dept_name" id="dept_name"></td>
							<td><label for="dept_phoneNum">Tel.&nbsp;&nbsp;</label><input
								type="text" value="" name="dept_phoneNum" id="dept_phoneNum"></td>
						</tr>
						<tr>
							<td colspan="2"><label for="zipcode">우편번호&nbsp;:&nbsp;</label><input
								type="text" value="" name="zipcode" id="zipcode" readonly>
								<input type="button" value="우편번호"
								onClick="sample4_execDaumPostcode()"></td>
							<td><label for="fax">Fax.&nbsp;&nbsp;</label><input
								type="text" value="" name="fax" id="fax"><br></td>
						<tr>
							<td colspan="3"><label for="dept_addr">부서주소&nbsp;:&nbsp;</label><input
								type="text" value="" name="dept_addr" id="dept_addr"></td>
						</tr>
					</table>
					<div class="btncenter">
					<input class="myButt" type="submit" value="등록">
					</div>
				</form>
				</div>
				<div id="empSty1">
				<p>사원 목록</p>
				<table id="empList">
					<tr>
						<th>이름</th>
						<th>부서</th>
						<th>직급</th>
						<th>이메일</th>
						<th>Tel.</th>
					</tr>
				</table>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>

</body>
<script>
	function removeCheck() {

		var delete_dept = $("#delete_dept:checked").val();

		if (delete_dept == null) {

			alert("부서를 선택해주세요.")
			return false;
		}

		if (confirm("정말 삭제하시겠습니까??") == true) { //확인
			document.removefrm.submit();
		} else { //취소
			return false;
		}
	}

	function sample4_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.getElementById('zipcode').value = data.zonecode;
				document.getElementById("dept_addr").value = data.address;
			}
		}).open();
	}

	function checkIt() {
		var deptinput = eval("document.deptinput");

		if (!deptinput.dept_no.value) {
			alert("부서번호를 입력하세요.");
			return false;
		}

		if (!deptinput.dept_name.value) {
			alert("부서명을 입력하세요.");
			return false;
		}

		return true;
	}
	function updateOpen() {

		var checked = $("#delete_dept:checked").length;

		if (checked >= 2) {
			alert("하나만 선택해주세요.")
			return false
		}

		window.name = "list"
		var update_dept = $("#delete_dept:checked").val();

		if (update_dept == null) {
			alert("부서를 선택해주세요.")
			return false;
		}
		window.open('updateForm.do?delete_dept=' + update_dept, 'update_dept',
				'width=660,height=300,location=no,status=no,scrollbars=yes');

	}
</script>


</html>