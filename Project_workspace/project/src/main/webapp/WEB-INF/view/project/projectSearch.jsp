<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>프로젝트 리스트</title>
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
 $("#delete_btn").on('click', function(){
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
	<!-- search{s} -->
	<div class="form-group row justify-content-center">
	<div class="w100" style="padding-right: 10px">
		<select class="form-control form-control-sm" name="searchType" id="searchType">
			<option value="subject">제목</option>
			<option value="contents">본문</option>
		</select>
	</div>
	<div class="w300" style="padding-right: 10px">
		<input type="text" class="form-control form-control-sm" name="keyword" id="keyword"></div>
	<div>
		<button class="btn btn-sm btn-primary" name="btnSearch"	id="btnSearch">검색</button>
	</div>
	</div>
	<!-- search{e} -->
	<br>
	<div id="data">
		<table id="table" border="1"></table>
	</div>
	
<b>총 ${list.count}의 프로젝트가 있습니다.</b>
	<c:if test="${list.count == 0}">
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">등록 된 프로젝트가 없습니다.</td>
			</tr>
		</table>
	</c:if>
		
		<c:if test="${list.count > 0}">
			<form method="post" name="projectWrite" action="Write.do" onsubmit="return writeSave()">
			<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
			<tr><td align="center" width="50">프로젝트 전체 선택: <input type="checkbox" name="allCheck" id="allCheck" onclick="checkAll();"/></td></tr>
			<tr><td>
				<c:forEach var="article" items="${list.boardList}">
					<!-- 아이템즈에 집어넣어서 article로 사용 -->
						<input type="checkbox" name="proChBox" id="proChBox" value="${article.project_no}"> <br>
						
						<c:out value="${article.project_no}" /><br>
						
						<c:set var="number" value="${num - 1}" /><br>
						
						${article.name}<br>
						
						<a href="list.do?project_no=${article.project_no}&p=${list.requestPage}">${article.subject}</a><br>
						
						<fmt:formatDate value="${article.start_time}" type="date" dateStyle="long" /><br>
						
						<fmt:formatDate value="${article.end_time}" type="date" dateStyle="long" /><br>
						
						${article.contents}<br>
						
						<c:set var = "progress" scope = "session" value = "${article.progress}"/>
						<c:choose>
							<c:when test = "${progress == 0}">진행중</c:when>
							<c:when test = "${progress == 1}">완료</c:when>
							<c:otherwise>보류</c:otherwise>
						</c:choose><br>
				</c:forEach>
				</td></tr>
				
			</table>
			</form>
		</c:if>

<!-- 프로젝트 생성 버튼 -->
<table width="700">
	<tr>
		<td align="right"><input type="button" value="추가" onclick="document.location.href='projectWrite.do'"></td>
		<td align="right"><input type="button" value="수정" onclick="document.location.href='projectUpdate.do?project_no=${project_no}'"></td>
		<td align="right"><input type="button" value="글삭제" id="delete_btn" /></td>			
	</tr>
</table>

<!-- 페이징  -->
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
</body>
</html>