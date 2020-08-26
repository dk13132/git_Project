<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>

$(function(){

	var url="depts.do";
	
	$.ajax({
		type:"post"		
		,url:url		
		,dataType:"json" })
		.done(function(args){	//응답이 성공 상태 코드를 반환하면 호출되는 함수

			 for(var i=0; i < args.length; i++) {
				 $("#dept_no").append("<option value='"+args[i].dept_no+"'>"+args[i].dept_name+"</option>");
			 }
 			})
	    .fail(function(e) {
	    	alert(e.responseText);
	    })
});//ready 끝


</script>


</head>
<body>
<h2>근태 현황</h2><br>
<div>
		
<form action="attenList.do" method="get">
<label for="start_time"><b>조회일자</b></label>&nbsp&nbsp
<input type="date" size="40" maxlength="50"  name="start_time" id="start_time" value="<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>">

<input type="submit" value = "조회">

</form><br>
</div>
<div>
<form action="deptAttr.do">
<input type="hidden" name="start_time" value="<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>">
<table id = "empList" frame="void" width="820">
	<tr>
		<th width="30"align="center">&nbsp&nbsp</th> 
		<th width="140" align="left"><select  style="width:80px"  id = "dept_no" name="dept_no" style="text-align-last:center">
		<option value="${dept_no}"><c:if test="${dept_no == null}"> 부 서</c:if>
		<c:if test="${dept_no != null}">${dept_name}</c:if>
		</option></select><input type="submit" value="검색" style="HEIGHT: 15.5pt"/></th>
		<th width="100"align="center">직 급</th>
		<th width="100"align="center">이 름</th>
		<th width="150"align="center">일 자</th>
		<th width="100"align="center">출근 시간</th>
		<th width="100"align="center">퇴근 시간</th>
		<th width="100"align="center">구 분</th>
	</tr>
	
	<c:forEach var="row" items="${list.boardList}">
	<tr>
		<td align="center"><input type="radio" id = "attendance_no" name="attendance_no" value="${row.attendance_no}"/></td>
		<td align="center">${row.dept_name}</td>
		<td align="center">${row.position}</td>		
		<td align="center">${row.name}</td>
		<td align="center"><fmt:formatDate value="${row.start_time}" pattern="yyyy-MM-dd"/></td>
		<td align="center"><fmt:formatDate value="${row.start_time}" pattern="HH:mm"/></td>
		<td align="center"><fmt:formatDate value="${row.end_time}" pattern="HH:mm"/></td>
		<td align="center"><c:choose>

							<c:when test="${row.state eq 0}"> 정 상</c:when>
							<c:when test="${row.state eq 0.5}"> 반 차 </c:when>
							<c:when test="${row.state eq 1}"> 연 차</c:when>
							<%-- <c:when test="${row.state eq 4}"> 외 근</c:when>
							<c:when test="${row.state eq 5}"> 휴 가</c:when> --%>
							<c:otherwise> 휴 가</c:otherwise> </c:choose> </td> </tr>	
	</c:forEach>	
</table><br>
<div style="position: relative; right:-748px; top:-11px">
<button type="button" onclick="updateAttr()">수 정</button>
</div>
</form>
</div>

<div style="position: relative; top:-38px; width: 650px;">
<c:if test="${list.count > 0}">
	<c:if test="${dept_no == null}">
 	<c:if test="${list.p.beginPageNumber > 5}">
			<a href="attenList.do?p=${list.p.beginPageNumber-1}&start_time=<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>"><<</a>&nbsp
	</c:if>
	
		<c:forEach var="pno" begin="${list.p.beginPageNumber}" end="${list.p.endPageNumber}">
		<a href="attenList.do?p=${pno}&start_time=<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>">[${pno}]</a>
		</c:forEach>
		
		<c:if test="${list.p.endPageNumber < list.p.totalPageCount}">
			&nbsp<a href="attenList.do?p=${list.p.endPageNumber + 1}&start_time=<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>">>></a>
	</c:if>
	</c:if>
	
	<c:if test="${dept_no != null}">
	
	<c:if test="${list.p.beginPageNumber > 5}">
			<a href="deptAttr.do?p=${list.p.beginPageNumber-1}&start_time=<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>&dept_no=${dept_no}"><<</a>&nbsp
	</c:if>
	
		<c:forEach var="pno" begin="${list.p.beginPageNumber}" end="${list.p.endPageNumber}">
		<a href="deptAttr.do?p=${pno}&start_time=<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>&dept_no=${dept_no}">[${pno}]</a>
		</c:forEach>
		
		<c:if test="${list.p.endPageNumber < list.p.totalPageCount}">
			&nbsp<a href="deptAttr.do?p=${list.p.endPageNumber + 1}&start_time=<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>&dept_no=${dept_no}">>></a>
	</c:if>
	
	</c:if>
</c:if>
</div>

</body>

<script>

function updateAttr(){
	
	window.name = "list"
		
	var update_attr = $("#attendance_no:checked").val();

	if(update_attr == null){

	alert("사원정보를 선택해주세요.")
	return false
		}
		
	window.open('updateAttr.do?attendance_no='+update_attr,'update_Attr','width=330,height=200,location=no,status=no,scrollbars=yes');
	
}



</script>

</html>