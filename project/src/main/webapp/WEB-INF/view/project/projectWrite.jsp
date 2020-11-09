<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<head>
<title>프로젝트 등록</title>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>
function proWriteSave() {
	if (document.projectWrite.start_time.value == "") {
		alert("시작 날짜를 입력하세요.");
		document.projectWrite.start_time.focus();
		return false;
	}
	if (document.projectWrite.end_time.value == "") {
		alert("종료 날짜를 입력하세요.");
		document.projectWrite.end_time.focus();
		return false;
	}
	if (document.projectWrite.subject.value == "") {
		alert("제목을 입력하세요.");
		document.projectWrite.subject.focus();
		return false;
	}
	if (document.projectWrite.contents.value == "") {
		alert("내용을 입력하세요.");
		document.projectWrite.contents.focus();
		return false;
	}
}
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
				<h1>프로젝트 등록</h1>
				<br>
				<form method="post" name="projectWrite" action="proWrite.do"
					onsubmit="return proWriteSave()">
					<input type="hidden" name="employee_no" value="${mc_employee_no}">
					<table width="740" border="1" cellspacing="0" cellpadding="0"
						align="center">
						<tr>
							<td width="185" align="center">프로젝트명</td>
							<td width="555" colspan="3"><input type="text" size="40"
								maxlength="50" name="subject"></td>
						</tr>
						<tr>
							<td width="185" align="center">시작 날짜</td>
							<td width="555"><input type="date" size="40" maxlength="50"
								name="start_time"
								value=<fmt:formatDate value="${article.start_time}" pattern="yyyy-MM-dd"/>></td>
							<td width="185" align="center">완료 날짜</td>
							<td width="555"><input type="date" size="40" maxlength="50"
								name="end_time"
								value=<fmt:formatDate value="${article.end_time}" pattern="yyyy-MM-dd"/>></td>
						</tr>
						<tr>
							<td width="185" align="center">진행 상태</td>
							<td width="555"><select name="progress">
									<option value="0" selected>진행중</option>
									<option value="1">완료</option>
									<option value="2">보류</option>
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
							<td width="185" align="center">프로젝트 설명</td>
							<td width="555" colspan="3"><textarea name="contents"
									rows="13" cols="40"></textarea></td>
						</tr>
						<tr>
							<td colspan="4" align="center">
							<input type="submit" value="글쓰기">
							<input type="button" value="글취소" OnClick="window.location='/projectSearch.do'"></td>
						</tr>
					</table>
				</form>
			</div>
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
</body>
</html>