<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/tablebtn.css'/>" />
<head>
<title>공지사항 게시판</title>
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

</head>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form[name='readForm']");

		// 삭제
		$(".delete_btn").on("click", function() {
			var deleteYN = confirm("삭제하시겠습니까?");
			if (deleteYN == true) {

				formObj.attr("action", "/calendarDelete.do");
				formObj.attr("method", "post");
				formObj.submit();

			}
		})

	});

	function fn_fileDown(file_no) {
		var formObj = $("form[name='readForm']");
		$("#file_no").attr("value", file_no);
		formObj.attr("action", "DeptBoardFileDown.do");
		formObj.submit();
	}
</script>
<body>
	<div id="wrap">
		<jsp:include page="/WEB-INF/view/head.jsp" flush="false" />
		<section id="content">

			<div id="leftcontent">
				<ul>
					<li><a class="active" href="blist.do">공지사항 게시판</a></li>
					<li><a href="deptBoardList.do?type=2">부서 게시판</a></li>
				</ul>
			</div>


			<div id="rightcontent">
				<br> <b>글내용 보기</b> <br> <br>
				<form method="post" name="readForm">
					<input type="hidden" name="type" value="2"> 
					<input type="hidden" name="employee_no" value="${mc_employee_no}"> 
					<input type="hidden" name="board_no" value="${board_no}">
					<input type="hidden" id="file_no" name="file_no" value="">
					<table cellspacing="0" cellpadding="0" align="center">
						<tr height="30">
							<td align="center" width="185">제 목</td>
							<td align="left" width="555" colspan="3">&nbsp;${board.subject}</td>

						</tr>
						<tr height="30">
							<td align="center" width="185">작성자</td>
							<td align="left" width="185">&nbsp;${board.name}</td>
							<td align="center" width="185">조회수</td>
							<td align="center" width="185" align="center">${board.readcount}</td>
						</tr>
						<tr height="30">
							<td align="center" width="185">작성일</td>
							<td align="left" width="555" colspan="3">&nbsp;<fmt:formatDate
									value="${board.reg_date}" pattern="yyyy-MM-dd (E) HH:mm" /></td>

						</tr>
						<tr height="200">
							<td align="center" width="185">글내용</td>
							<td align="left" width="555" colspan="3">&nbsp;${board.contents}</td>
						</tr>
						<tr height="30">
							<td align="center" width="185">첨부파일</td>
							<td align="left" width="555" colspan="3"><c:forEach
									var="file" items="${file}">
					&nbsp;<a href="#"
										onclick="fn_fileDown('${file.file_no}'); return false;">${file.file_name}</a>&nbsp;(${file.filesize}kb)<br>
								</c:forEach></td>
						</tr>
					</table>
					<div id="listButton"> 
						<input id="list_btn" type="button" value="글목록"
							onclick="document.location.href='deptBoardList.do?type=${board.type}&p=${pageNum}'">
						<c:if test="${mc_employee_no == board.employee_no}">
							<input id="update_btn" type="button" value="글수정"
								onclick="document.location.href='deptUpdate.do?board_no=${board.board_no}&p=${pageNum}'">
							<input id="delete_btn" type="button" value="글삭제"
								onclick="document.location.href='deptDelete.do?board_no=${board.board_no}&p=${pageNum}'">

						</c:if>
					</div>
				</form>

			</div>
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
</body>
</html>
