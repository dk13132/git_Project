<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>채팅방 생성</title>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/depinfo.css'/>" />
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
	<script>
		function selectDept() {
			var url = "empList.do";
			var data = $("#dept").val();
			var params = "dept_no=" + data;

			$.ajax({
				type : "post",
				url : url,
				data : params,
				dataType : "json"
			}).done(
					function(args) {//응답이 성공 상태 코드를 반환하면 호출되는 함수
						$("#emp").empty();
						if (args !== null) {
							for (var i = 0; i < args.length; i++) {
								if (args[i].employee_no != $("#myNo").val()) {
									$("#emp").append(
											"<option value='"+args[i].employee_no+"'>"
													+ args[i].name
													+ "</option>");
								}
							}
						}
					}).fail(function(e) {
				alert(e.responseText);
			})
		}

		function addBtn() {
			var selectItem = form.emp.options;
			var empSelectItem = form.empSelect.options;
			for (var i = 0; i < selectItem.length; i++) {
				var index = 0;
				if (selectItem[i].selected) {
					for (var j = 0; j < empSelectItem.length; j++) {
						if (empSelectItem[j].value == selectItem[i].value) {
							index = -1;
						}
					}
					if (index != -1) {
						$("#empSelect")
								.append(
										"<option disabled value='" + selectItem[i].value + "'>"
												+ selectItem[i].innerHTML
												+ "</option>");
					}
				}
			}
		}

		function onSubmit() {
			var empSelectItem = form.empSelect.options;
			for (var i = 0; i < empSelectItem.length; i++) {
				empSelectItem[i].disabled = false;
				empSelectItem[i].selected = true;
			}
		}

		function cancel() {
			self.close();
		}
	</script>
	<h1>채팅방 생성</h1>
	<input type="hidden" id="myNo" value="${mc_employee_no}">
	<form name="form" method="post" onsubmit="onSubmit()">
		채팅방 이름 : <input type="text" name="chat_name"> <br> 부서 선택:
		<select id="dept" onchange="selectDept()">
			<option value="-1">::부서선택::</option>
			<c:forEach var="item" items="${deptList}">
				<option value="${item.dept_no}">${item.dept_name}</option>
			</c:forEach>
		</select> <br> 채팅방 초대 사원 추가 <br>
		<select size="6" style="width: 100px; height: 100px;" id="emp"
			name="emp" multiple="multiple">
		</select> <input type="button" value=">>"
			style="position: absolute; top: 166px;" onclick="addBtn()"> <select
			size="6" style="width: 100px; height: 100px; margin-left: 50px;"
			id="empSelect" name="empSelect" multiple="multiple">
		</select> <br> <input type="submit" value="등록" /> <input type="button"
			value="취소" onclick="cancel()" />
	</form>
</body>
</html>