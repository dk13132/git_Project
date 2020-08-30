<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>게시판</title>
<style type='text/css'>
a:link {
	color: black;
	text-decoration: none; }
a:visited { }
a:active {
	text-decoration: underline;}
a:hover {
	text-decoration: underline;
	background-position: 50% 100%;}
</style>
<style>
<!--
@font-face {
	font-family: 굴림;
	src: url();
}
body, td, a, div, p, pre, input, textarea {
	font-family: 굴림;
	font-size: 9pt;
}
-->
</style>
</head>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){	
	 $("#listBtn").on('click', function listBtn(){
	         var url = "list.do?p=" + ${pageNum};
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
		formObj.attr("action", "fileDown.do");
		formObj.submit();
	}
</script>
<body>
	<header>
	<h1>일감번호: ${work_no}</h1>
	</header>
	<section id="container">
		<form name="projectWorkContent" id="projectWorkContent" role="form" method="post"  enctype="multipart/form-data">
			<input type="hidden" id="work_no" name="work_no" value="${work_no}" />
			<input type="hidden" value="" id="file_no" name="file_no">
			<input type="hidden" id="searchType" name="searchType" value="${search.searchType}"> 
			<input type="hidden" id="keyword" name="keyword" value="${search.keyword}">		
		<div class="form-group">
			<label for="subject" class="col-sm-2 control-label">일감 제목</label>
			<input type="text" id="title" name="title" class="form-control" value="${article.subject}" readonly="readonly" />
		</div>
		<div class="form-group">
			<label for="start_time" class="col-sm-2 control-label">시작 날짜</label>
			<fmt:formatDate value="${article.start_time}" pattern="yyyy-MM-dd" />	
		</div>
		<div class="form-group">
			<label for="end_time" class="col-sm-2 control-label">완료 날짜</label>
			<fmt:formatDate value="${article.end_time}" pattern="yyyy-MM-dd" />	
		</div>
		<div class="form-group">
			<label for="state" class="col-sm-2 control-label">진행 상태</label>
			  <c:set var = "state" scope = "session" value = "${article.state}"/>
			      <c:choose>
			         <c:when test = "${state == 0}">진행중</c:when>
			         <c:when test = "${state == 1}">완료</c:when>
			         <c:otherwise>보류</c:otherwise>
			      </c:choose>
		</div>
		<div class="form-group">
			<label for="priority" class="col-sm-2 control-label">중요도</label>
			<c:set var = "priority" scope = "session" value = "${article.priority}"/>
			<c:choose>
				<c:when test = "${priority == 0}">보통</c:when>
				<c:when test = "${priority == 1}">높음</c:when>
				<c:otherwise>낮음</c:otherwise>
			</c:choose>		
		</div>
		<div class="form-group">
			<label for="name" class="col-sm-2 control-label">작성자</label>
		<input type="text" id="name" name="name" class="form-control" value="${article.name}"  readonly="readonly"/>
		</div>
		<div class="form-group">
			<label for="contents" class="col-sm-2 control-label">일감 내용</label>
			<textarea id="contents" name="contents" class="form-control" readonly="readonly"><c:out value="${article.contents}" /></textarea>
		</div>
		<hr>
		<div>
		<span>파일 목록</span>
			<c:forEach var="file" items="${file}">
			&nbsp;<a href="#" onclick="fn_fileDown('${file.file_no}'); return false;">${file.file_name}</a>&nbsp;(${file.filesize}kb)<br>
			</c:forEach>
		</div>
		<hr>
		<div>  
			<input type="button" name="updateBtn" id="updateBtn" value="글수정" onclick="document.location.href='projectWorkUpdate.do?work_no=${work_no}&p=${pageNum}'">
					&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" name="deleteBtn" id="deleteBtn" value="글삭제" onclick="document.location.href='delete.do?work_no=${work_no}'">
					&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" name="listBtn" id="listBtn" value="글목록" onclick="document.location.href='list.do?p=${pageNum}'">
		</div>		
		</form>
	</section>		
</body>
</html>

