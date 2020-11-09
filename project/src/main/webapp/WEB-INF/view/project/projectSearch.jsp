<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<head>
<title>프로젝트 리스트</title>
<style>
.centered { display: table; margin-left: auto; margin-right: auto; }
</style>
</head>
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
     	 $("input[name=proChBox]").prop("checked", true);
    	}else{
     	 $("input[name=proChBox]").prop("checked", false);
    }
})
 $("#proDelete_btn").on('click', function(){
  var result = confirm("정말 삭제하시겠습니까?");
  
  if(result) {
   $.ajax({
    url : "checkBoxDelete.do",
    type : "post",
    data : "project_no=" + $("#proChBox:checked").val()
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
	<div id="wrap">
		<jsp:include page="/WEB-INF/view/head.jsp" flush="false" />
		<section id="content">
			<div id="leftcontent">
				<ul>
					<li><a class="active" href="projectSearch.do">프로젝트 게시판</a></li>
				</ul>
			</div>

			<div id="Search" align="right">
				<div class="w100" style="padding-right: 10px">
					<select name="searchType" id="searchType">
						<option value="subject">제목</option>
						<option value="contents">본문</option>
					</select> <input type="text" name="keyword" id="keyword">
					<button class="btn btn-sm btn-primary" name="btnSearch"
						id="btnSearch">검색</button>
				</div>
			</div>

			<div id="rightcontent">
				<h1>총 ${list.count}의 프로젝트가 있습니다.</h1>
				<form method="post" name="projectWrite" action="Write.do" onsubmit="return writeSave()">

					<c:if test="${list.count == 0}">
						<table width="740" height="300" border="1" cellpadding="0" cellspacing="0">
							<tr>
								<td align="center">등록 된 프로젝트가 없습니다.</td>
							</tr>
							<tr>
								<td align="right">
								<td align="right"><input type="button" value="추가" onclick="document.location.href='projectWrite.do'"></td>
							</tr>
						</table>
					</c:if>

					<c:if test="${list.count > 0}">
						<table width="740" height="300" border="1" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td><c:forEach var="article" items="${list.boardList}">
								<td>
								<c:if test="${employee_no == 1}">
									<input type="checkbox" name="proChBox" id="proChBox" value="${article.project_no}">
								</c:if>
									<br><c:out value="${article.project_no}" />
									<br>${article.name}
									<br><a href="wlist.do?project_no=${article.project_no}&p=${list.requestPage}">${article.subject}</a>
									<br><fmt:formatDate value="${article.start_time}" type="date" dateStyle="long" />
									<br><fmt:formatDate value="${article.end_time}" type="date" dateStyle="long" />
									<br>${article.contents}
									<br><c:set var="progress" scope="session" value="${article.progress}" />
									<c:choose>
										<c:when test="${progress == 0}">진행중</c:when>
										<c:when test="${progress == 1}">완료</c:when>
										<c:otherwise>보류</c:otherwise>
									</c:choose>
								</td>
								</c:forEach>
								</td>		
							</tr>
							
						<tr>
						<td align="center" height="40" colspan="6">
						<input type="button" value="추가" onclick="document.location.href='projectWrite.do'">
						<input type="button" value="수정" onclick="document.location.href='projectUpdate.do?project_no=${project_no}'">
						<!-- <input type="checkbox" id="allCheck" name="allCheck" onclick="checkAll();"/> -->
						<input type="button" value="삭제" id="proDelete_btn" />
						</td>
						</tr>	
						</table>
						</c:if>
						<!-- 페이징  -->
				<div class="centered">
					<c:if test="${list.count > 0}">
						<c:if test="${list.p.beginPageNumber > 10}">
							<a href="projectSearch.do?p=${list.p.beginPageNumber-1}">이전</a>
						</c:if>
						<c:forEach var="pno" begin="${list.p.beginPageNumber}"
							end="${list.p.endPageNumber}">
							<a href="projectSearch.do?p=${pno}">[${pno}]</a>
						</c:forEach>
						<c:if test="${list.p.endPageNumber < list.p.totalPageCount}">
							<a href="projectSearch.do?p=${list.p.endPageNumber + 1}">다음</a>
						</c:if>
					</c:if>
				</div>
				</form>
				</div>
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
</body>
</html>