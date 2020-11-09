<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<head>
<title>일감 보기</title>
</head>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){	
	 $("#listBtn").on('click', function listBtn(){
	         var url = "wlist.do?p=" + ${pageNum};
	         form.action = url;
	         form.method = 'POST';
	         form.submit();
	    	});
		});
</script>
<script>
function fn_fileDown(file_no) {
	 var formObj = $("form[name='projectWorkContent']");
		$("#file_no").attr("value", file_no);
		formObj.attr("action", "proFileDown.do");
		formObj.submit();
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
				<h1>일감 번호: ${work_no}</h1>
				<form name="projectWorkContent" id="projectWorkContent" role="form"	method="post" enctype="multipart/form-data">
					<input type="hidden" id="work_no" name="work_no" value="${work_no}" />
					<input type="hidden" value="" id="file_no" name="file_no">
					<input type="hidden" id="searchType" name="searchType"
						value="${search.searchType}"> <input type="hidden"
						id="keyword" name="keyword" value="${search.keyword}">

					<table width="740" border="1" cellspacing="0" cellpadding="0"
						align="center">
						<tr>
							<td width="185" align="center">일감 제목</td>
							<td width="555" colspan="3"><input type="text" size="40"
								maxlength="50" value="${article.subject}" readonly="readonly"></td>
						</tr>
						<tr>
							<td width="185" align="center">시작 날짜</td>
							<td width="555"><fmt:formatDate
									value="${article.start_time}" pattern="yyyy-MM-dd" /></td>
							<td width="185" align="center">완료 날짜</td>
							<td width="555"><fmt:formatDate value="${article.end_time}"
									pattern="yyyy-MM-dd" /></td>
						</tr>
						<tr>
							<td width="185" align="center">진행 상태</td>
							<td width="555"><c:set var="state" scope="session"
									value="${article.state}" /> <c:choose>
									<c:when test="${state == 0}">진행중</c:when>
									<c:when test="${state == 1}">완료</c:when>
									<c:otherwise>보류</c:otherwise>
								</c:choose></td>
							<td width="185" align="center">중요도</td>
							<td width="555"><c:set var="priority" scope="session"
									value="${article.priority}" /> <c:choose>
									<c:when test="${priority == 0}">보통</c:when>
									<c:when test="${priority == 1}">높음</c:when>
									<c:otherwise>낮음</c:otherwise>
								</c:choose></td>
						</tr>
						<tr>
							<td width="185" align="center">작성자</td>
							<td width="555" colspan="3"><input type="text" id="name"
								name="name" class="form-control" value="${article.name}"
								readonly="readonly" />
						</tr>
						<tr>
							<td width="185" align="center">내 용</td>
							<td width="555" colspan="3"><textarea name="contents"
									rows="13" cols="40" readonly="readonly"><c:out
										value="${article.contents}" /></textarea></td>
						</tr>

						<tr>
							<td width="185" align="center">첨부 파일</td>
							<td align="left" width="555" id="fileIndex" colspan="3">&nbsp;
								<c:forEach var="file" items="${file}">&nbsp;
									<a href="#" onclick="fn_fileDown('${file.file_no}'); return false;">${file.file_name}</a>&nbsp;(${file.filesize}kb)<br>
								</c:forEach> <br>
							</td>
						</tr>
						<tr>
							<td colspan="4" align="center"><input type="button"
								name="updateBtn" id="updateBtn" value="글수정"
								onclick="document.location.href='projectWorkUpdate.do?work_no=${work_no}&p=${pageNum}'">
								&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" name="deleteBtn"
								id="deleteBtn" value="글삭제"
								onclick="document.location.href='proWorkDelete.do?work_no=${work_no}'">
								&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" name="listBtn"
								id="listBtn" value="글목록"
								onclick="document.location.href='wlist.do?p=${pageNum}'">
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