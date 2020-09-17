<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<title>일정 게시판</title>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/depinfo.css'/>" />
<script type="text/javascript"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link
	href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css"
	rel="stylesheet" type="text/css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js"
	type="text/javascript"></script>
<script
	src=" https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"
	type="text/javascript"></script>
<script
	src="<%=request.getContextPath()%>/resources/lib/jquery-ui-timepicker-addon.js"
	type="text/javascript"></script>
<script>
	function writeSave() {
		if (document.calendarWrite.location.value == "") {
			alert("위치를 입력하세요.");
			document.calendarWrite.location.focus();
			return false;
		}
		if (document.calendarWrite.start_time.value == "") {
			alert("날짜를 모두 입력하세요.");
			document.calendarWrite.start_time.focus();
			return false;
		}
		if (document.calendarWrite.end_time.value == "") {
			alert("날짜를 모두 입력하세요.");
			document.calendarWrite.end_time.focus();
			return false;
		}
		if (document.calendarWrite.subject.value == "") {
			alert("제목을 입력하세요.");
			document.calendarWrite.subject.focus();
			return false;
		}
		if (document.calendarWrite.contents.value == "") {
			alert("내용을 입력하세요.");
			document.calendarWrite.contents.focus();
			return false;
		}
	}
</script>
<script>
	$(document)
			.ready(
					function() {
						var formObj = $("form[name='calendarWrite']");
						fn_addFile();
						function fn_addFile() {
							var fileIndex = 1;
							//$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"추가"+"</button></div>");
							$(".fileAdd_btn")
									.on(
											"click",
											function() {
												$("#fileIndex")
														.append(
																"<input type='file' style='float:left;' name='file_"
																		+ (fileIndex++)
																		+ "'>"
																		+ "<button type='button' style='float:left;' id='fileDelBtn'>"
																		+ "취소"
																		+ "</button>"
																		+ "<br>");
											});
							$(document).on("click", "#fileDelBtn", function() {
								$(this).parent().remove();
							});
						}
					});
</script>
</head>

<body>
	<h1>일정추가</h1>
	<form method="POST" name="calendarWrite" action="calendarWrite2.do"
		enctype="multipart/form-data" onsubmit="return writeSave()">
		<input type="hidden" name="employee_no" value="${mc_employee_no }">
		<input type="hidden" name="calendar_no" value="${dto.calendar_no}">

		<table border="1" cellspacing="0" cellpadding="0" align="center">

			<tr height="30">
				<td width="185" align="center">제 목</td>
				<td width="555">&nbsp;<input type="text" size="40"
					maxlength="50" name="subject">

				</td>
			</tr>

			<tr height="30">
				<td width="185" align="center">기 간</td>
				<td width="555">&nbsp;<input type="text" id="start_time"
					name="start_time" autocomplete="off"> &nbsp;~&nbsp; <input type="text"
					id="end_time" name="end_time" autocomplete="off">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select id="select"
					name="type" style="padding: 1px 3px 4px 1px;">
						<option value="1" selected>개인 일정</option>
						<option value="2">회사 일정</option>
				</select>
				</td>

			</tr>
			<tr height="30">
				<td width="185" align="center">장 소</td>
				<td width="555">&nbsp;<input type="text" size="20"
					maxlength="30" name="location"></td>
			</tr>


			<tr height="30">
				<td width="185" align="center">내 용</td>
				<td width="555">&nbsp;<textarea name="contents" rows="13"
						cols="40"></textarea>
				</td>
			</tr>
			<tr height="30">
				<td width="185" align="center">첨부파일</td>
				<td align="left" width="555" id="fileIndex">&nbsp;
					<button type="button" class="fileAdd_btn">파일추가</button> <br>
				</td>

			</tr>
			<tr height="30">
				<td colspan="2" align="center"><input type="submit" value="확인">
					<input type="button" value="취소"
					OnClick="self.close()">
			</tr>
		</table>
	</form>
	<script>
		$('#start_time').datetimepicker({
			showSecond : true,
			dateFormat : 'yy-mm-dd',
			timeFormat : 'HH:mm:ss'
		});
		$('#end_time').datetimepicker({
			showSecond : true,
			dateFormat : 'yy-mm-dd',
			timeFormat : 'HH:mm:ss'
		});
	</script>
</body>
</html>