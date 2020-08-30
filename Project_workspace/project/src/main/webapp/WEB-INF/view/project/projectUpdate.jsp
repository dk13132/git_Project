<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>게시판</title>
</head>

<body>
	<b>프로젝트 수정</b>
	<br>
	<form method="post" name="projectUpdate" action="projectUpdate.do" onsubmit="">
		<input type="hidden" name="_method" value="put" />
		<table width="400" border="1" cellspacing="0" cellpadding="0" align="center">
			<tr>
				<td width="70" align="center">프로젝트 명</td>
				<td align="left" width="330"><input type="text" size="10" maxlength="10" name="subject" value="${article.subject}">
				<input type="hidden" name="project_no" value="${article.project_no}"></td>
			</tr>
			<tr>
				<td width="70" align="center">프로젝트 기간</td>
				<td align="left" width="330"><input type="date" size="40"
					maxlength="50" name="start_time"
					value=<fmt:formatDate value="${article.start_time}" pattern="yyyy-MM-dd"/>>
					~ <input type="date" size="40" maxlength="50" name="end_time"
					value=<fmt:formatDate value="${article.end_time}" pattern="yyyy-MM-dd"/>></td>
			</tr>
			<tr>
				<td width="70" align="center">진행 상태</td>
				<td align="left" width="330">
				<textarea name="state" rows="13" cols="40">${article.progress}</textarea></td>
			</tr>
			<tr>
				<td width="70" align="center">중요도</td>
				<td align="left" width="330"><textarea name="content" rows="13"
						cols="40">${article.priority}</textarea></td>
			</tr>
			<tr>
				<td width="70" align="center">작성자</td>
				<td align="left" width="330"><textarea name="employee_no"
						rows="13" cols="40">${article.employee_no}</textarea></td>
			</tr>
			<tr>
				<td width="70" align="center">프로젝트 설명</td>
				<td align="left" width="330"><textarea name="contents"
						rows="13" cols="40">${article.contents}</textarea></td>
			</tr>
			<tr>
				<td width="150" height="60" align="center">공개 여부</td>
				<td width="700" height="60"><input type="checkbox" name="public_availability"></td>
			</tr>
			<tr>
				<td colspan=2 align="center"><input type="submit" value="수정">
					<input type="button" value="취소" onclick="document.location.href='projectSearch.do?p=${pageNum}'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
