<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>일정 게시판</title>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>
	function btnSearch() {
		$("#btnSearch").click(function(e) {
			e.preventDefault();
			var url = "${getBoardList}";
			url = url + "?type=" + $('#type').val();
			url = url + "&searchType=" + $('#searchType').val();
			url = url + "&keyword=" + $('#keyword').val();
			location.href = url;
			console.log(url);
		});
	};
</script>
<script>
	function search() {
		var type = document.getElementsByName("type")[0].value;
		var searchType = document.getElementsByName("searchType")[0].value;
		var keyword = document.getElementsByName("keyword")[0].value;
		console.log(searchType)
		console.log(keyword)
		location.href = "searchList?p=1" + "&type=" + type + "&searchType="
				+ searchType + "&keyword=" + keyword;
	};
</script>

</head>
<body onload="btnSearch()">
	<div id="board1" align="left">
		<b>일정 게시판</b><br> <br>
	</div>
	<form align="center" id="data" method="post">
		<input type="hidden" name="type" value="${type}">
		<input type="date" size="40" maxlength="50" name="start_time"
			value=<fmt:formatDate value="${dto.start_time}" pattern="yyyy-MM-dd"/>>
		~ <input type="date" size="40" maxlength="50" name="end_time"
			value=<fmt:formatDate value="${dto.end_time}" pattern="yyyy-MM-dd"/>>
		&nbsp; <select id="type" name="type" style="padding: 1px 0.5px 6px 1px;">
			<option value="1" ${type == "1"?"selected":""}>개인 일정</option>
			<option value="2" ${type == "2"?"selected":""}>회사 일정</option>
		</select>&nbsp; 
		<select id="searchType" name="searchType" style="padding: 1px 0.5px 6px 1px;">
			<option value="subject" ${searchType == "subject"?"selected":""}>제목</option>
			<option value="name" ${searchType == "name"?"selected":""}>작성자</option>
		</select> &nbsp; 
		<input id="keyword" name="keyword" type="text"> 
		<input name="btnSearch" id="btnSearch" type="button" value="검색"> <br>
		<br>

		<c:if test="${list.count == 0}">
			<table width="700" border="1" cellpadding="0" cellspacing="0"
				align="center">
				<tr>
					<td align="center">게시판에 저장된 글이 없습니다.</td>
				</tr>
				<tr>
					<td colspan="6" align="right"><input type="button" value="글쓰기"
						onclick="document.location.href='calendarWrite.do'"></td>
				</tr>
			</table>
		</c:if>


		<c:if test="${list.count > 0}">
			<table border="1" width="750" cellpadding="0" cellspacing="0"
				align="center">

				<tr height="40">
					<td align="center" width="50">번 호</td>
					<td align="center" width="200">날 짜</td>
					<td align="center" width="250">제 목</td>
					<td align="center" width="100">분 류</td>
					<td align="center" width="100">작성자</td>
					<!-- <td align="center" width="100">조회수</td>   -->
				</tr>

				<c:forEach var="calendar" items="${list.boardList}">
					<tr height="40">
						<td align="center" width="50"><c:out value="${number}" /> <c:set
								var="number" value="${number - 1}" /></td>
						<td align="center" width="200"><fmt:formatDate
								value="${calendar.start_time}" type="date" dateStyle="long" /></td>
						<td align="center" width="250"><a
							href="calendarContent.do?calendar_no=${calendar.calendar_no}&p=${list.requestPage}">${calendar.subject}</a></td>

						<c:if test="${calendar.type == 0}">
							<td align="center" width="100">null</td>
						</c:if>
						<c:if test="${calendar.type == 1}">
							<td align="center" width="100">개인 일정</td>
						</c:if>
						<c:if test="${calendar.type == 2}">
							<td align="center" width="100">회사 일정</td>
						</c:if>
						<td align="center" width="100">${calendar.name}</td>
						<!-- <td align="center" width="100">${calendar.readcount}</td> -->

					</tr>
				</c:forEach>
				

				<tr>
					<td colspan="6" align="right">
					
					<input type="button" value="글쓰기" onclick="document.location.href='calendarWrite.do'">
					</td>
				</tr>
			</table>
			</c:if>
	</form>


	<form align="center">
		<c:if test="${list.count > 0}">
			<c:if test="${list.p.beginPageNumber > 10}">
				<a href="calendar.do?p=${list.p.beginPageNumber-1}">이전</a>
			</c:if>
			<c:forEach var="pno" begin="${list.p.beginPageNumber}"
				end="${list.p.endPageNumber}">
				<a href="calendar.do?p=${pno}">[${pno}]</a>
			</c:forEach>
			<c:if test="${list.p.endPageNumber < list.p.totalPageCount}">
				<a href="calendar.do?p=${list.p.endPageNumber + 1}">다음</a>
			</c:if>
		</c:if>
	</form>
</body>
</html>