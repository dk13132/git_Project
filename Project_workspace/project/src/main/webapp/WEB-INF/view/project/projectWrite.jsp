<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>${dto.project_no}프로젝트의 일감 게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script src="script.js">
</script>
</head>

<body>
	<b>${dto.project_no} 프로젝트의 일감 등록</b>
	<br>
	<form method="post" name="projectWrite" action="proWrite.do">
		<table border="1" align="center">
			<tr>
				<td width="150" height="60" align="center">프로젝트명</td>
				<td width="700" height="60"><input type="text" size="40" maxlength="50" name="subject">
			</tr>
			<tr>
				<td width="70" align="center">프로젝트 기간</td>
				<td align="left" width="330">
				<input type="date" size="40" maxlength="50" name="start_time" value=<fmt:formatDate value="${article.start_time}" pattern="yyyy-MM-dd"/>>
				 ~ <input type="date" size="40" maxlength="50" name="end_time" value=<fmt:formatDate value="${article.end_time}" pattern="yyyy-MM-dd"/>></td>
			</tr>
			<tr>
				<td width="150" height="60" align="left">진행 상태</td>
				<td width="700" height="60">
				<select id="progress">
						<option value="0" selected>진행중</option>
						<option value="1">완료</option>
						<option value="2">보류</option>
				</select>
			</tr>
			 <tr>
				<td width="150" height="60" align="left">담당자</td>
				<td width="700" height="60">
				<select>
                  <c:forEach items="${list}" var="list">
                     <option value="${list.name}">${list.name}</option>
                  </c:forEach>
           		 </select>
			<tr>
			<tr>
				<td width="150" align="center">프로젝트 설명</td>
				<td width="700"><textarea name="contents" rows="13" cols="40"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan=2 align="center">
				<input type="submit" value="만들기">
				<input type="button" value="취소" OnClick="window.location='/projectSearch.do'"></td>
			</tr>
		</table>
	</form>
</body>
</html>
