<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/deptdomlist.css'/>" />

<title>Insert title here</title>
</head>


<body>
	<div id="wrap">
		<jsp:include page="/WEB-INF/view/head.jsp" flush="false" />
		<section id="content">
			<div id="leftcontent">
				<ul>
					<li><a>결재진행함</a></li>
					<li><a href="domt_imok_list.do">결재완료함</a></li>
				</ul>
			</div>

			<div id="rightcontent">
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
							<td><a href="domtView.do?document_no=${domt_list_view3.document_no}">${domt_list_view3.subject}</a></td>
							<td><fmt:formatDate value="${domt_list_view3.reg_date}" /></td>
							<td>${domt_list_view3.type}</td>
						</tr>
					</c:forEach>
				</table>
				<!-- 1234 순서 -->
				<div class="tableundermenu">
					<div class="nemberbtncss">
					<c:if test="${domt_list3.count > 0}">
						<c:if test="${domt_list3.p.beginPageNumber > 5}">
							<a href="appdomt.do?p=${domt_list3.p.beginPageNumber-1}"><</a>&nbsp;
						</c:if>
						<c:forEach var="pno" begin="${domt_list3.p.beginPageNumber}" end="${domt_list3.p.endPageNumber}">
							<a href="appdomt.do?p=${pno}">${pno}</a>
						</c:forEach>
						<c:if test="${domt_list3.p.endPageNumber < domt_list3.p.totalPageCount}">&nbsp;
							<a href="appdomt.do?p=${domt_list3.p.endPageNumber + 1}">></a>
						</c:if>
					</c:if>
					</div>
				<a class="myButton" href="domt_write_form.do">전자결재작성</a>
				</div>
				<div class="clear"></div>
				
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
							<td><a href="domtViewApp.do?document_no=${domt_list_view4.document_no}">${domt_list_view4.subject}</a></td>
							<td><fmt:formatDate value="${domt_list_view4.reg_date}" /></td>
							<td>${domt_list_view4.type}</td>
						</tr>
					</c:forEach>
				</table>
				<!-- 1234 순서 -->
				<div class="nemberbtncss">
				<c:if test="${domt_list4.count > 0}">
					<c:if test="${domt_list4.p.beginPageNumber > 5}">
						<a href="appdomt.do?p=${domt_list4.p.beginPageNumber-1}"><<</a>&nbsp;
					</c:if>
					<c:forEach var="pno" begin="${domt_list4.p.beginPageNumber}"
						end="${domt_list4.p.endPageNumber}">
						<a href="appdomt.do?p=${pno}">${pno}</a>
					</c:forEach>
					<c:if test="${domt_list4.p.endPageNumber < domt_list4.p.totalPageCount}">&nbsp;
						<a href="appdomt.do?p=${domt_list4.p.endPageNumber + 1}">>></a>
					</c:if>
				</c:if>
				</div>
			</div>
		</section>
		
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
</body>
</html>