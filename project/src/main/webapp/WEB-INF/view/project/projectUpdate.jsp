<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<head>
<title>프로젝트 수정</title>
</head>
<script type="text/javascript">
	function updateSave() {
		if (document.write.subject.value == "") {
			alert("제목을 입력하십시요.");
			document.write.subject.focus();
			return false;
		}
		if (document.write.start_time.value == "") {
			alert("시작 날짜를 입력하십시요.");
			document.write.start_time.focus();
			return false;
		}
		if (document.write.end_time.value == "") {
			alert("완료 날짜를 입력하십시요.");
			document.write.end_time.focus();
			return false;
		}
		if (document.write.contents.value == "") {
			alert("내용을 입력하십시요.");
			document.write.contents.focus();
			return false;
		}
	}
</script>
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
				<h1>${project_no}:프로젝트수정</h1>
				<br>
				<form method="post" name="projectUpdate" action="projectUpdate.do"
					onsubmit="return proUpdateSave()">
					<input type="hidden" name="_method" value="put" /> <input
						type="hidden" name="project_no" value="${project_no}"
						readonly="readonly" />

					<table width="740" border="1" cellspacing="0" cellpadding="0"
						align="center">

						<tr>
							<td width="185" align="center">프로젝트 명</td>
							<td width="555" colspan="3"><input type="text" size="40"
								maxlength="50" name="subject" value="${article.subject}"></td>
						</tr>

						<tr>
							<td width="185" align="center">프로젝트 기간</td>
							<td width="555" colspan=3><input type="date" size="40"
								maxlength="50" name="start_time"
								value=<fmt:formatDate value="${article.start_time}" pattern="yyyy-MM-dd"/>>
								~ <input type="date" size="40" maxlength="50" name="end_time"
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
							<td width="185" align="center">내 용</td>
							<td width="555" colspan="3"><textarea name="contents"
									rows="13" cols="40" value="${article.contents}">${article.contents}</textarea></td>
						</tr>
						<tr>
							<td colspan="4" align="center"><input type="submit"
								value="수정"> <input type="button" value="취소"
								onclick="document.location.href='projectSearch.do?p=${pageNum}'">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
</body>
</html>