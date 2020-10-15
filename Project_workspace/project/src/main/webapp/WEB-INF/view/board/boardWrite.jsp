<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/file.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/tablebtn.css'/>" />
<head>
<title>공지사항 게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript"></script>
<script>
	function writeSave() {

		if (document.boardWrite.reg_date.value == "") {
			alert("날짜를 입력하십시요.");
			document.boardWrite.reg_date.focus();
			return false;
		}
		if (document.boardWrite.subject.value == "") {
			alert("제목을 입력하십시요.");
			document.boardWrite.subject.focus();
			return false;
		}

		if (document.boardWrite.contents.value == "") {
			alert("내용을 입력하십시요.");
			document.boardWrite.contents.focus();
			return false;
		}
	}
</script>
<script>
	$(document)
			.ready(
					function() {
						var formObj = $("form[name='boardWrite']");

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
																"<div style='clear:both;'><input type='file' style='float:left;' name='file_"
																		+ (fileIndex++)
																		+ "'>"
																		+ "<button type='button' style='float:left;' id='fileDelBtn'>"
																		+ "취소"
																		+ "</button>"
																		+ "</div><br>");
											});
							$(document).on("click", "#fileDelBtn", function() {
								$(this).parent().remove();

							});
						}
					});
</script>
</head>


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
				<br> <b>글쓰기</b> <br><br>
				<form method="POST" name="boardWrite" action="write2.do" enctype="multipart/form-data" onsubmit="return writeSave()">
				
					<input type="hidden" name="type" value="1"> 
					
					<input type="hidden" name="employee_no" value="${mc_employee_no}"> 
						<input type="hidden" name="board_no" value="${dto.board_no}"> 
						<input type="hidden" name="readcount" value="${dto.readcount}">

					<table cellspacing="0" cellpadding="0"
						align="center">

						<tr>
							<td width="185" align="center">제 목</td>
							<td width="555"><input type="text" size="40" maxlength="50" name="subject"></td>
							
							
						</tr>
						

						<tr>
							<td width="185" align="center">날 짜</td>
							<td width="555"><input type="date" size="40" maxlength="50"
								name="reg_date"
								value=<fmt:formatDate value="${dto.reg_date}" pattern="yyyy-MM-dd"/>>
							</td>
						</tr>

						<tr>
							<td width="185" align="center">내 용</td>
							<td width="555"><textarea name="contents" rows="13"
									cols="40"></textarea></td>
						</tr>
						<tr>
							<td width="185" align="center">첨부파일</td>
							<td align="left" width="555" id="fileIndex">&nbsp;
								<button type="button" class="fileAdd_btn" style="padding: .1em .5em;">파일 추가</button>
								<br>
							</td>
						</tr>
						
					</table>
					<div id="listButton">
					<input type="submit" id="write_btn" value="확인">
								<input id="list_btn" type="button" value="취소"
								OnClick="window.location='blist.do'">
					</div>
				</form>
			</div>
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
</body>
</html>
