<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<style type="text/css">
table {font-family: 'Noto Sans KR', sans-serif; border-collapse: collapse; width: 70%; text-decoration:none}
th, td { text-align: left; padding: 7px;}
tr:nth-child(even){background-color: #f2f2f2}
th { background-color: #767676; color: white;}
th:first-child { background-color: #767676; color: white; border-radius: 3px 0px 0px 0px }
th:last-child { background-color: #767676; color: white; border-radius: 0px 3px 0px 0px }
</style>
<title>Insert title here</title>

</head>


<body>
	<div id="wrap">
		<jsp:include page ="/WEB-INF/view/head.jsp" flush="false"/>
		<section id="content">
			<div id="nav">
			
				<div id="sidemenu">
					<ul>
						<li><a href="list.do">부서관리</a></li>
						<br>
						<li><a class="active" href="authority.do">권한관리</a></li>
						<br>					
					</ul>
				</div>
				
			</div>
			
			<div id="article">
			
	<h3>내가 작성한 기안서</h3>
	<table>
		<tr>
			<th>문서번호</th>
			<!-- 	<th>사원번호</th> -->
			<th>제목</th>
			<!-- 	<th>내용</th> -->
			<th>작성일</th>
			<th>타입</th>
		</tr>
		<c:forEach var="domt_list_view3" items="${domt_list3.boardList}">
			<tr>
				<td>${domt_list_view3.document_no}</td>
				<td><a
					href="domtViewApp.do?document_no=${domt_list_view3.document_no}">${domt_list_view3.subject}</a></td>
				<td><fmt:formatDate value="${domt_list_view3.reg_date}" /></td>
				<td>${domt_list_view3.type}</td>
			</tr>
		</c:forEach>
	</table>
	<!-- 1234 순서 -->
	<c:if test="${domt_list3.count > 0}">
		<c:if test="${domt_list3.p.beginPageNumber > 5}">
			<a href="appdomt.do?p=${domt_list3.p.beginPageNumber-1}"><<</a>&nbsp;
			</c:if>
		<c:forEach var="pno" begin="${domt_list3.p.beginPageNumber}"
			end="${domt_list3.p.endPageNumber}">
			<a href="appdomt.do?p=${pno}">[${pno}]</a>
		</c:forEach>
		<c:if
			test="${domt_list3.p.endPageNumber < domt_list3.p.totalPageCount}">
				&nbsp;<a href="appdomt.do?p=${domt_list3.p.endPageNumber + 1}">>></a>
		</c:if>
	</c:if>


	<h3>진행중인 기안서</h3>
	<table>
		<tr>
			<th>문서번호</th>
			<!-- 	<th>사원번호</th> -->
			<th>제목</th>
			<!-- 	<th>내용</th> -->
			<th>작성일</th>
			<th>타입</th>
		</tr>
		<c:forEach var="domt_list_view4" items="${domt_list4.boardList}">
			<tr>
				<td>${domt_list_view4.document_no}</td>
				<td><a
					href="domtViewApp.do?document_no=${domt_list_view4.document_no}">${domt_list_view4.subject}</a></td>
				<td><fmt:formatDate value="${domt_list_view4.reg_date}" /></td>
				<td>${domt_list_view4.type}</td>
			</tr>
		</c:forEach>
	</table>
	<!-- 1234 순서 -->
	<c:if test="${domt_list4.count > 0}">
		<c:if test="${domt_list4.p.beginPageNumber > 5}">
			<a href="appdomt.do?p=${domt_list4.p.beginPageNumber-1}"><<</a>&nbsp;
			</c:if>
		<c:forEach var="pno" begin="${domt_list4.p.beginPageNumber}"
			end="${domt_list4.p.endPageNumber}">
			<a href="appdomt.do?p=${pno}">[${pno}]</a>
		</c:forEach>
		<c:if
			test="${domt_list4.p.endPageNumber < domt_list4.p.totalPageCount}">
				&nbsp;<a href="appdomt.do?p=${domt_list4.p.endPageNumber + 1}">>></a>
		</c:if>
	</c:if>


	<a href="domt_imok_list.do">결재완료 페이지</a>
	<a href="domt_write_form.do">전자결재작성</a>

			</div>
			
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp"  flush="false"/>
	</div>
</body>
</html>