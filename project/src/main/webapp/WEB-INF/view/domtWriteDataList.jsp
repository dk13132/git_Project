<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/deptdomlist.css'/>" />
</head>
<body>
	<div id="wrap">
		<jsp:include page="/WEB-INF/view/head.jsp" flush="false" />
		<section id="content">
			<div id="leftcontent">
				<ul>
					<li><a href="appdomt.do">결재진행함</a></li>
					<li><a href="domt_imok_list.do">결재완료함</a></li>
				</ul>
			</div>

			<div id="rightcontent">
			<h2>결재문서 리스트</h2>
				<table>
					<tr>
						<th>NO</th>
						<th>시스템</th>
						<th>서식함</th>
						<th>양식명</th>
						<th>담당자</th>
					</tr>
					<tr>
						<td><a href="domtpage/1.do">5</a></td>
						<td><a href="domtpage/1.do">문서결재</a></td>
						<td><a href="domtpage/1.do">공통</a></td>
						<td><a href="domtpage/1.do">휴가신청서</a></td>
						<td><a href="domtpage/1.do">-</a></td>
					</tr>
					<tr>
						<td><a href="domtpage/1.do">4</a></td>
						<td><a href="domtpage/1.do">문서결재</a></td>
						<td><a href="domtpage/1.do">공통</a></td>
						<td><a href="domtpage/1.do">업무일지</a></td>
						<td><a href="domtpage/1.do">-</a></td>
					</tr>
					<tr>
						<td><a href="domtpage/1.do">3</a></td>
						<td><a href="domtpage/1.do">문서결재</a></td>
						<td><a href="domtpage/1.do">공통</a></td>
						<td><a href="domtpage/1.do">품의요청서</a></td>
						<td><a href="domtpage/1.do">-</a></td>
					</tr>
					<tr>
						<td><a href="domtpage/1.do">2</a></td>
						<td><a href="domtpage/1.do">문서결재</a></td>
						<td><a href="domtpage/1.do">공통</a></td>
						<td><a href="domtpage/1.do">협조요청서</a></td>
						<td><a href="domtpage/1.do">-</a></td>
					</tr>
					<tr>
						<td><a href="domtpage/1.do">1</a></td>
						<td><a href="domtpage/1.do">문서결재</a></td>
						<td><a href="domtpage/1.do">공통</a></td>
						<td><a href="domtpage/1.do">기타</a></td>
						<td><a href="domtpage/1.do">-</a></td>
					</tr>
				</table>
			</div>
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
</body>
</html>