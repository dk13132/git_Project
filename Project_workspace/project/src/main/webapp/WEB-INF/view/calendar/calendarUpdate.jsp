<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<title>일정 게시판</title>
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
			document.alendarWrite.start_time.focus();
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
	$(document)
			.ready(
					function() {
						var formObj = $("form[name='updateForm']");
						$(document).on("click", "#fileDel", function() {
							$(this).parent().remove();
						});
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
																"<div>&nbsp;<input type='file' style='float:left;' name='file_"
																		+ (fileIndex++)
																		+ "'>"
																		+ "<button type='button' style='float:left;' id='fileDelBtn'>"
																		+ "취소"
																		+ "</button></div>");
											});
							$(document).on("click", "#fileDelBtn", function() {
								$(this).parent().remove();
							});
						}
					});
	var fileNoArry = new Array();
	var fileNameArry = new Array();
	function fn_del(value, name) {
		fileNoArry.push(value);
		fileNameArry.push(name);
		$("#fileNoDel").attr("value", fileNoArry);
		$("#fileNameDel").attr("value", fileNameArry);
	}
	
</script>
</head>


<body>

	<b>수정하기</b>
	<br>
	<br>
	<section id="container">
		<form method="post" name="updateForm" action="calendarUpdate2.do"
			onsubmit="return writeSave()" enctype="multipart/form-data">
			<input type="hidden" name="employee_no" value="${mc_employee_no}">
			<input type="hidden" name="calendar_no"
				value="${calendar.calendar_no}"> <input type="hidden"
				id="fileNoDel" name="fileNoDel[]" value=""> <input
				type="hidden" id="fileNameDel" name="fileNameDel[]" value="">



			<table border="1" cellspacing="0" cellpadding="0" align="center">

				<tr height="30">
					<td width="185" align="center">제 목</td>
					<td width="555">&nbsp;<input type="text" size="40"
						maxlength="50" name="subject" value="${calendar.subject}">
					</td>
					<%-- <td width="185" align="center">작성자</td>
				<td align="left" width="555">${board.name} --%>
					<td><input type="hidden" name="employee_no"
						value="${employee_no}"></td>
				</tr>

				<tr height="30">
					<td width="185" align="center">기 간</td>
					<td width="555">&nbsp;<input type="text" id="start_time"
						name="start_time" autocomplete="off" value=<fmt:formatDate
								value="${calendar.start_time}" pattern='"yyyy-MM-dd HH:mm:ss"' />> &nbsp;~&nbsp; <input type="text"
						id="end_time" name="end_time" autocomplete="off" value=<fmt:formatDate
								value="${calendar.end_time}" pattern='"yyyy-MM-dd HH:mm:ss"' />>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select id="select"
						name="type" style="padding: 1px 3px 4px 1px;">
							<option value="1"
								<c:if test="${calendar.type == 1}"> selected </c:if>>개인
								일정</option>
							<option value="2" <c:if test="${calendar.type == 2}"> selected </c:if>>회사
								일정</option>
					</select>
					</td>

				</tr>
				<tr height="30">
					<td width="185" align="center">위 치</td>
					<td width="555">&nbsp;<input type="text" size="20"
						maxlength="30" name="location" value="${calendar.location}"></td>
				</tr>


				<tr height="30">
					<td width="185" align="center">내 용</td>
					<td width="555">&nbsp;<textarea name="contents" rows="13"
							cols="40">${calendar.contents}</textarea>
					</td>
				</tr>
				<tr height="30">
					<td width="185" align="center">첨부파일</td>

					<td align="left" width="555" id="fileIndex">&nbsp;
						<button type="button" class="fileAdd_btn">파일추가</button> <br>
						<c:forEach var="file" items="${file}" varStatus="var">
							<input type="hidden" id="file_no" name="file_no_${var.index}"
								value="${file.file_no}">
							<input type="hidden" id="file_name" name="file_name"
								value="file_no_${var.index}">
							<input type="hidden" id="file_path" name="file_path"
								value="file_no_${var.index}">
							<input type="hidden" id="del_gb" name="del_gb"
								value="${file.del_gb}">

							<c:if test="${ file.del_gb == 'N'}">
								<div>
									&nbsp;<a href="#" id="fileName" onclick="return false;">${file.file_name}</a>&nbsp;(${file.filesize}kb)
									<button id="fileDel"
										onclick="fn_del('${file.file_no}','file_no_${var.index}');"
										type="button">삭제</button>
									<br>
								</div>
							</c:if>
						</c:forEach>
					</td>

				</tr>
				<tr>
					<td colspan="3" align="center"><input type="submit"
						value="글수정"> <input type="button" value="취소"
						onclick="document.location.href='calendarContent.do?calendar_no=${calendar.calendar_no}&p=${pageNum}'"></td>
				</tr>
			</table>
		</form>
	</section>
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