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
<script type="text/javascript"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	function writeSave() {

		if (document.boardUpdate.reg_date.value == "") {
			alert("날짜를 입력하십시요.");
			document.boardUpdate.reg_date.focus();
			return false;
		}
		if (document.boardUpdate.subject.value == "") {
			alert("제목을 입력하십시요.");
			document.boardUpdate.subject.focus();
			return false;
		}

		if (document.boardUpdate.contents.value == "") {
			alert("내용을 입력하십시요.");
			document.boardUpdate.contents.focus();
			return false;
		}

	}

	$(document)
			.ready(
					function() {
						var formObj = $("form[name='boardUpdate']");

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
																"<div style='clear:both;'><input type='file' style='float:left;' name='file_"
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
	<div id="wrap">
		<jsp:include page="/WEB-INF/view/head.jsp" flush="false" />
		<section id="content">

			<div id="leftcontent">
				<ul>
					<li><a class="active" href="blist.do">공지사항 게시판</a></li>
					<li><a href="deptBoardList.do?type=2">부서 게시판</a></li>
				</ul>
			</div>


			<div id="rightcontent"><br>
				<b>글수정</b> <br><br>
				<form method="post" name="boardUpdate" action="deptUpdate2.do"
					onsubmit="return writeSave()" enctype="multipart/form-data">
					<input type="hidden" name="type" value="2"> <input
						type="hidden" name="board_no" value="${board.board_no}"> <input
						type="hidden" name="employee_no" value="${mc_employee_no}"> <input
						type="hidden" id="fileNoDel" name="fileNoDel[]" value="">
					<input type="hidden" id="fileNameDel" name="fileNameDel[]" value="">

					<table cellspacing="0" cellpadding="0" align="center">
						<tr>

							<td width="185" align="center">제 목</td>
							<td align="left" width="555"><input type="text" size="40"
								maxlength="50" name="subject" value="${board.subject}">
							</td>
						</tr>
						<tr>
							<td width="185" align="center">작성자</td>
							<td align="left" width="555">&nbsp;${board.name}</td>

						</tr>
						<tr>
							<td width="185" align="center">날 짜</td>
							<td width="555"><input type="date" size="40" maxlength="50"
								name="reg_date"
								value=<fmt:formatDate value="${board.reg_date}" pattern="yyyy-MM-dd"/>>
							</td>
						</tr>


						<tr>
							<td width="185" align="center">내 용</td>
							<td align="left" width="555"><textarea name="contents"
									rows="13" cols="50">${board.contents}</textarea></td>
						</tr>
						<tr>
							<td width="185" align="center">첨부파일</td>
							<td align="left" width="555" id="fileIndex">&nbsp;
								<button type="button" class="fileAdd_btn">파일추가</button>
								<br> <c:forEach var="file" items="${file}" varStatus="var">
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

					</table>
					<div id="listButton"> 
					<input id="list_btn" type="button" value="글목록"
								onclick="document.location.href='deptBoardList.do?p=${pageNum}'">
					<input id="update_btn" type="submit"
								value="글수정"> 
					</div>
				</form>
			</div>
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
</body>
</html>
