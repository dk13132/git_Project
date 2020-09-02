<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>게시판</title>
</head>
<!-- <script src="https://code.jquery.com/jquery-3.1.0.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
function btnSearch(){
	$("#btnSearch").click(function(e){
	e.preventDefault();
	var url = "${getBoardList}";
	url = url + "?searchType=" + $('#searchType').val();
	url = url + "&keyword=" + $('#keyword').val();
	location.href = url;
	console.log(url);
	});
	};	
</script>
<script>
function search() {  
  var searchType = document.getElementsByName("searchType")[0].value;
  var keyword =  document.getElementsByName("keyword")[0].value;
  console.log(searchType)
  console.log(keyword)
 location.href = "searchList?p=1" + "&searchType=" + searchType + "&keyword=" + keyword; 
};
</script>
<script type="text/javascript">	/* 전체 선택 */
$(document).ready(function(){
	$("#allCheck").click(function(){
		if( $("#allCheck").is(':checked') ){
     	 $("input[name=workCheck]").prop("checked", true);
    	}else{
     	 $("input[name=workCheck]").prop("checked", false);
    }
})
 $("#delete_btn").on('click', function(){
  var result = confirm("정말 삭제하시겠습니까?");
  
  if(result) {
   $.ajax({
    url : "checkDelete.do",
    type : "post",
    data : "work_no=" + $("#workChBox:checked").val()
   }).done(function(data){
	   alert("삭제되었습니다.");
	   location.reload();
   });
  } else {
	  alert("취소되었습니다.");
	  }
 });

});
 </script>

<body onload="btnSearch()">
	<div align="right">
		<!-- search{s} -->
		<div class="form-group row justify-content-center">
			<div class="w100" style="padding-right: 10px">
				<select class="form-control form-control-sm" name="searchType" id="searchType">
					<option value="subject">제목</option>
					<option value="contents">본문</option>
				</select>
			</div>
			<div class="w300" style="padding-right: 10px">
				<input type="text" class="form-control form-control-sm" name="keyword" id="keyword">
			</div>
			<div>
				<button class="btn btn-sm btn-primary" name="btnSearch"	id="btnSearch">검색</button>
			</div>
		</div>
		<!-- search{e} -->
		<br>
		<div id="data">
			<table id="table" border="1"></table>
		</div>
	</div>
	<b>프로젝트명 - 일감 게시판 (전체 글:${list.count})</b>
	<c:if test="${list.count == 0}">
		<table>
			<tr>
				<td align="center">게시판에 저장된 글이 없습니다.</td>
			</tr>
		</table>
	</c:if>

	<c:if test="${list.count > 0}">
		<form method="post" name="projectWorkSearch" action="list.do">
		</form>
		<table>
			<tr height="30">
				<td align="center" width="50"><input type="checkbox" name="allCheck" id="allCheck" onclick="checkAll();"/></td>
				<td align="center" width="50">#</td>
				<td align="center" width="100">진행 상태</td>
				<td align="center" width="100">중요도</td>
				<td align="center" width="400">제목</td>
				<td align="center" width="100">담당자</td>
				<td align="center" width="230">시작 날짜</td>
				<td align="center" width="230">완료 날짜</td>
			</tr>
			<c:forEach var="article" items="${list.boardList}">
				<!-- 아이템즈에 집어넣어서 article로 상숑 -->
				<tr height="30">
					<td align="center" width="50">
					<input type="checkbox" name="chk" id="workChBox" value="${article.work_no}"></td> <%--  onclick="fn_checked(this,${article.work_no});"> --%>

					<td align="center" width="50"><c:out value="${number}" /> <c:set
							var="number" value="${number - 1}" /></td>
					
				<td><c:set var = "state" scope = "session" value = "${article.state}"/>
					<c:choose>
						<c:when test = "${state == 0}">진행중</c:when>
						<c:when test = "${state == 1}">완료</c:when>
						<c:otherwise>보류</c:otherwise>
					</c:choose></td>

				<td><c:set var = "priority" scope = "session" value = "${article.priority}"/>
					<c:choose>
						<c:when test = "${priority == 0}">보통</c:when>
						<c:when test = "${priority == 1}">높음</c:when>
						<c:otherwise>낮음</c:otherwise>
					</c:choose></td>

					<td align="center" width="400"><a href="wcontent.do?work_no=${article.work_no}&p=${list.requestPage}">${article.subject}</a></td>

					<td align="center" width="100">${article.name}</td>
					<td align="center" width="230"><fmt:formatDate value="${article.start_time}" type="date" dateStyle="long" /></td>
					<td align="center" width="230"><fmt:formatDate value="${article.end_time}" type="date" dateStyle="long" /></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<!-- 글쓰기 버튼 -->
	<table width="800">
		<tr>
			<td align="right"><input type="button" value="글쓰기" onclick="document.location.href='projectWorkWrite.do'"></td>
			<td align="right"><input type="button" value="글삭제" id="delete_btn"  /></td><!-- onclick="fn_Delete()" -->
		</tr>
	</table>

	<!-- 페이징  -->
	<c:if test="${list.count > 0}">
		<c:if test="${list.p.beginPageNumber > 10}">
			<a href="list.do?p=${list.p.beginPageNumber-1}">이전</a>
		</c:if>
		<c:forEach var="pno" begin="${list.p.beginPageNumber}"
			end="${list.p.endPageNumber}">
			<a href="list.do?p=${pno}">[${pno}]</a>
		</c:forEach>
		<c:if test="${list.p.endPageNumber < list.p.totalPageCount}">
			<a href="list.do?p=${list.p.endPageNumber + 1}">다음</a>
		</c:if>
	</c:if>

</body>
</html>