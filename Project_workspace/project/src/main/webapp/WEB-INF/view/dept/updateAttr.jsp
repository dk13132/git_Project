<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/deptcs.css'/>" />
</head>
<body>

<div>
<form action="attrUpdate.do" method="get" target="list">
<!-- form 태그의 target 속성은 폼 데이터(form data)를 서버로 제출한 후 받는 응답이 열릴 위치를 명시합니다. -->
<input type="hidden" id = "attendance_no" name ="attendance_no" value="${attr.attendance_no}"/>
<br>
<label for ="start_time">날 짜&nbsp;:&nbsp;</label>
<input readonly type="date" id= "start_time" name ="start_time" value ="<fmt:formatDate value="${attr.start_time}" pattern="yyyy-MM-dd"/>"><br> 

<%-- 날 짜 : <fmt:formatDate value="${attr.start_time}" pattern="yyyy-MM-dd"/>  --%>

이 름 :<c:out value="${attr.name}"/><br>
<label for ="state">구 분&nbsp;:&nbsp;</label>
<select id = "state" name = "state"><option value ="${attr.state}" ><c:choose>

			<c:when test="${attr.state eq 0}"> 정 상</c:when>
			<c:when test="${attr.state eq 0.5}"> 반 차 </c:when>
			<c:when test="${attr.state eq 1}"> 연 차</c:when>
			<%-- <c:when test="${attr.state eq 4}"> 외 근</c:when>
			<c:when test="${attr.state eq 5}"> 휴 가</c:when> --%>
			<c:otherwise> 휴 가 </c:otherwise> </c:choose> </option>
<option value='0'>정 상</option>						
<option value='0.5'>반 차</option>						
<option value='1'>연 차</option>						
<!-- <option value='4'>외 근</option>		 -->				
<option >휴 가</option>						
						
</select><br>

<input class="myButt" type ="submit" value="수 정" onclick="window.close()">
<button class="myButt" type="button" onclick="window.close()" >취 소</button>
</form>
</div>

</body>

</html>