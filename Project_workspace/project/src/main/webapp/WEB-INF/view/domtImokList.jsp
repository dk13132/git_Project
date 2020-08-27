<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

table {
	 width: 73%;
}

table, th, tr, td {
	border-collapse: collapse;
	border: solid 1px #cccccc;
	text-align: center;
}
</style>
<title>Insert title here</title>
</head>


<body>
	<h3>승인완료</h3>
	<table>
		<tr>
			<th>문서번호</th>
			<!-- <th>사원번호</th> -->
			<th>제목</th>
			<!-- <th>내용</th> -->
			<th>작성일</th>
			<th>타입</th>
		</tr>
		<c:forEach var="domt_imok_list_view" items="${domt_list3}">
			<tr>
				<td>${domt_imok_list_view.document_no}</td>
				<%-- <td>${domt_list_view.employee_no}</td> --%>
				<td><a href="domtView.do?document_no=${domt_imok_list_view.document_no}">${domt_imok_list_view.subject}</a></td>
			<%-- 	<td><a href="domtView.do?document_no=${domt_list_view.document_no}">${domt_list_view.contents}</a></td> --%>
				<td><fmt:formatDate value="${domt_imok_list_view.reg_date}" /></td>
				<td>${domt_imok_list_view.type}</td>
			</tr>
		</c:forEach>
	</table>
	<a href="domt_imok_list.do">목록으로</a>
</body>
</html>