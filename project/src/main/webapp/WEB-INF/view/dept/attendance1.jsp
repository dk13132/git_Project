<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/deptcs.css'/>" />
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
	<div id="wrap">
		<jsp:include page ="/WEB-INF/view/head.jsp" flush="false"/>
		<section id="content">
			<div id="leftcontent">
					<ul>
						
						<li><a class="active" href="attendance.do">근태 현황</a></li>
											
					</ul>

			</div>
			
		<div id="rightcontent">

				<h2>근태 현황</h2>
				
		<div class="bttbl1">
			
	<form class="alin" action="attenList.do" method="get">
	<label for="start_time"><b>조회일자</b></label>&nbsp;&nbsp;
	<input type="date" name="start_time" id="start_time" value="<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>">
	
	<input class="myButt" type="submit" value = "조회">
	
	</form>
	
	<form action="deptAttr.do">
	<input type="hidden" name="start_time" value="<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>">
	<table id = "empList">
		<tr>
			<th>&nbsp;&nbsp;</th> 
			<th><select id = "dept_no" name="dept_no">
			<option value="${dept_no}"><c:if test="${dept_no == null}"> 부 서</c:if>
			<c:if test="${dept_no != null}">${dept_name}</c:if>
			</option></select><input class="myButt1" type="submit" value="검색"/></th>
			<th>직 급</th>
			<th>이 름</th>
			<th>일 자</th>
			<th>출근 시간</th>
			<th>퇴근 시간</th>
			<th>구 분</th>
		</tr>
		
		<c:forEach var="row" items="${list.boardList}">
		<tr>
			<td><input type="radio" id = "attendance_no" name="attendance_no" value="${row.attendance_no}"/></td>
			<td>${row.dept_name}</td>
			<td>${row.position}</td>		
			<td>${row.name}</td>
			<td><fmt:formatDate value="${row.start_time}" pattern="yyyy-MM-dd"/></td>
			<td><fmt:formatDate value="${row.start_time}" pattern="HH:mm"/></td>
			<td><fmt:formatDate value="${row.end_time}" pattern="HH:mm"/></td>
			<td><c:choose>
	
								<c:when test="${row.state eq 0}"> 정 상</c:when>
								<c:when test="${row.state eq 0.5}"> 반 차 </c:when>
								<c:when test="${row.state eq 1}"> 연 차</c:when>
								<%-- <c:when test="${row.state eq 4}"> 외 근</c:when>
								<c:when test="${row.state eq 5}"> 휴 가</c:when> --%>
								<c:otherwise> 휴 가</c:otherwise> </c:choose> </td> </tr>	
		</c:forEach>	
	</table><br>
	<div class="relbut1">
	<button class="myButt" type="button" onclick="updateAttr()">수 정</button>
	</div>
	</form>
	</div>
	
	<div class="paging1">
	<c:if test="${list.count > 0}">
		<c:if test="${dept_no == null}">
	 	<c:if test="${list.p.beginPageNumber > 5}">
				<a href="attenList.do?p=${list.p.beginPageNumber-1}&start_time=<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>"><<</a>&nbsp;
		</c:if>
			<c:forEach var="pno" begin="${list.p.beginPageNumber}" end="${list.p.endPageNumber}">
			<a href="attenList.do?p=${pno}&start_time=<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>">[${pno}]</a>
			</c:forEach>
			
			<c:if test="${list.p.endPageNumber < list.p.totalPageCount}">
				&nbsp;<a href="attenList.do?p=${list.p.endPageNumber + 1}&start_time=<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>">>></a>
		</c:if>
		</c:if>
		
		<c:if test="${dept_no != null}">
		
		<c:if test="${list.p.beginPageNumber > 5}">
				<a href="deptAttr.do?p=${list.p.beginPageNumber-1}&start_time=<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>&dept_no=${dept_no}"><<</a>&nbsp;
		</c:if>
		
			<c:forEach var="pno" begin="${list.p.beginPageNumber}" end="${list.p.endPageNumber}">
			<a href="deptAttr.do?p=${pno}&start_time=<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>&dept_no=${dept_no}">[${pno}]</a>
			</c:forEach>
			
			<c:if test="${list.p.endPageNumber < list.p.totalPageCount}">
				&nbsp;<a href="deptAttr.do?p=${list.p.endPageNumber + 1}&start_time=<fmt:formatDate value="${start_time}" pattern="yyyy-MM-dd"/>&dept_no=${dept_no}">>></a>
		</c:if>
		
		</c:if>
	</c:if>
	</div>
			</div>
			</section>
			<jsp:include page="/WEB-INF/view/foot.jsp"  flush="false"/>
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
		
	window.open('updateAttr.do?attendance_no='+update_attr,'update_Attr','width=350,height=230,location=no,status=no,scrollbars=yes');
	
}

</script>

</html>