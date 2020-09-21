<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<link href="style.css" rel="stylesheet" type="text/css">
<head>
<title>${dto.project_no}프로젝트의 일감 게시판</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
	/* 파일 첨부 관련 */
	$(document)
			.ready(
					function() {
						var formObj = $("form[name='projectWorkWrite']");

						fn_addFile();

						function fn_addFile() {
							var fileIndex = 1;
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
																		+ "</button></div>"
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
	<div id="wrap">
		<jsp:include page="/WEB-INF/view/head.jsp" flush="false" />
		<section id="content">
			<div id="leftcontent">
				<ul>
					<li><a class="active" href="projectSearch.do">프로젝트 게시판</a></li>
				</ul>
			</div>
	
			<div id="rightcontent">
				<h1>일감 등록</h1>
				<form method="post" name="projectWorkWrite" action="proWorkWrite.do" enctype="multipart/form-data" onsubmit="return writeSave()">
					<input type="hidden" name="employee_no" value="${dto.employee_no}">
					<input type="hidden" name="project_no" value="${dto.project_no}">
					<br>
					<table width="740" border="1" cellspacing="0" cellpadding="0" align="center">
						<tr>
							<td width="185" align="center">일감 제목</td>
							<td width="555" colspan="3"><input type="text" size="40" maxlength="50"	name="subject"></td>
						</tr>
						<tr>
							<td width="185" align="center">시작 날짜</td>
							<td width="555"><input type="date" size="40" maxlength="50"	name="start_time"
								value=<fmt:formatDate value="${article.start_time}" pattern="yyyy-MM-dd"/>></td>
							<td width="185" align="center">완료 날짜</td>
							<td width="555"><input type="date" size="40" maxlength="50"	name="end_time"
								value=<fmt:formatDate value="${article.end_time}" pattern="yyyy-MM-dd"/>></td>
						</tr>
						<tr>
							<td width="185" align="center">진행 상태</td>
							<td width="555"><select name="state">
									<option value="0" selected>진행중</option>
									<option value="1">완료</option>
									<option value="2">보류</option>
							</select></td>
							<td width="185" align="center">중요도</td>
							<td width="555"><select name="priority">
									<option value="0" selected>보통</option>
									<option value="1">높음</option>
									<option value="2">낮음</option>
							</select></td>
						</tr>
						<tr>
							<td width="185" align="center">담당자</td>
							<td width="555" colspan="3"><select>
									<c:forEach items="${list}" var="list">
										<option value="${list.name}">${list.name}</option>
									</c:forEach>
							</select>
						</tr>
						<tr>
							<td width="185" align="center">내 용</td>
							<td width="555" colspan="3"><textarea name="contents" rows="13"	cols="40"></textarea></td>
						</tr>
						<tr>
							<td width="185" align="center">첨부 파일</td>
							<td align="left" width="555" id="fileIndex" colspan="3">&nbsp;
								<button type="button" class="fileAdd_btn">파일추가</button> <br>
							</td>
						</tr>
						<tr>
							<td colspan="4" align="center">
							<input type="submit" value="글쓰기">
							<input type="button" value="글취소" OnClick="window.location='wlist.do'"></td>
						</tr>
					</table>
				</form>
			</div>
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
</body>
</html>