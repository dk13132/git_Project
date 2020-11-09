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
<style type='text/css'>
<!--
a:link {
	color: black;
	text-decoration: none;
}
a:visited {
	
}
a:active {
	text-decoration: underline;
}
a:hover {
	text-decoration: underline;
	background-image: url('text_dottdeline.gif');
	background-repeat: repeat-x;
	background-position: 50% 100%;
}
-->
</style>
<style>
<!--
@font-face {
	font-family: 굴림;
	src: url();
}
body, td, a, div, p, pre, input, textarea {
	font-family: 굴림;
	font-size: 9pt;
}
-->
</style>
</head>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form[name='readForm']");
		// 삭제
		$(".delete_btn").on("click", function() {
			var calendar_no = $("#calendar_no").val();
			var p = $("#pageNum").val();
			var deleteYN = confirm("삭제하시겠습니까?");
			if (deleteYN == true) {
				alert(calendar_no + " " + p);
				location.href = "calendarDelete.do?calendar_no=" + calendar_no + "&p=" + p;
			}
		})
	});
	function fn_fileDown(file_no) {
		var formObj = $("form[name='readForm']");
		$("#file_no").attr("value", file_no);
		formObj.attr("action", "cfileDown.do");
		formObj.submit();
	}
</script>
<body>
	<b>일정 상세 보기</b>
	<br>
	<br>
	<section id="container">
		<form method="post" name="readForm">
			<input type="hidden" name="employee_no" value="${mc_employee_no}">
			<input type="hidden" id="calendar_no" name="calendar_no" value="${calendar.calendar_no}">
			<input type="hidden" id="file_no" name="file_no" value=""> 
			<input type="hidden" id="pageNum" value="${pageNum}">
		
			<table width="740" border="1" cellspacing="0" cellpadding="0"
				align="center">
				<tr height="30">
					<td align="center" width="185">제 목</td>
					<td align="left" width="185">&nbsp;${calendar.subject}</td>
					<td align="center" width="185">작성자</td>
					<td align="left" width="185">&nbsp;${calendar.name}</td>
				</tr>
				<tr height="30">
					<td align="center" width="185">작성일</td>
					<td align="left" width="555" colspan="4">&nbsp;<fmt:formatDate
							value="${calendar.start_time}" pattern="yyyy-MM-dd (E) HH:mm" />&nbsp;~&nbsp;<fmt:formatDate
							value="${calendar.end_time}" pattern="yyyy-MM-dd (E) HH:mm" /></td>
				</tr>
				<tr height="30">
					<td align="center" width="185">장 소</td>
					<td align="left" width="555" colspan="4"><pre>&nbsp;${calendar.location}</pre></td>
				</tr>
				<tr height="100">
					<td align="center" width="185">글내용</td>
					<td align="left" width="555" colspan="4"><pre>&nbsp;${calendar.contents}</pre></td>
				</tr>
				<tr height="50">
					<td align="center" width="185">첨부파일</td>
					<td align="left" width="555" colspan="4">
					<c:forEach var="file" items="${file}">
						&nbsp;<a href="#" onclick="fn_fileDown('${file.file_no}'); return false;">${file.file_name}</a>&nbsp;(${file.filesize}kb)<br>
						</c:forEach></td>
				</tr>
				<tr height="30">
					<td colspan="4" align="right">
					<c:if test="${mc_employee_no == calendar.employee_no}">
							<input type="button" value="글수정"
								onclick="document.location.href='calendarUpdate.do?calendar_no=${calendar.calendar_no}&p=${pageNum}'">
					&nbsp; <input class="delete_btn" type="button" value="글삭제">
					&nbsp; 
				</c:if> <input type="button" value="닫기"
						onclick="self.close()">&nbsp;
					</td>
				</tr>
			</table>
		</form>
	</section>
</body>
</html>