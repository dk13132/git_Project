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
<style type="text/css">

</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
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
				<div id="appwarp">
					<table id=apptable>
						<tr id="first">
							<td rowspan="2">결<br>재
							</td>
							<c:forEach var="domt_appline_view" items="${domt_appline}">
								<td>${domt_appline_view.dept_name}</td>
							</c:forEach>
						</tr>
						<tr id="second">
							<c:forEach var="domt_appline_view" items="${domt_appline}">
								<td>${domt_appline_view.name}<br> <span class="no_han">${domt_appline_view.state}</span>
								</td>
							</c:forEach>
						</tr>
					</table>
					<h2 class="clear">휴가신청서</h2>
					<table id="domtinfortable">
						<tr>
							<td>문서번호</td>
							<td>작성일</td>
							<td>작성부서</td>
							<td>작성자</td>
						</tr>
						<tr>
							<td>자동채번(${document_no})</td>
							<td>${reg_date}</td>
							<td>${dept_name}</td>
							<td>${name}</td>
						</tr>
					</table>
					<br>

					<div class="subject">&nbsp;${subject}</div>
					<br>
					<div class="contenttt">&nbsp;${contents}</div>

					<input type="button" id="" class="myButton2" value="목록으로" onclick="history.go(-1)">
					<input type="button" id="Domt_no" value="반려" class="myButton3" onclick="javascript:location.href='imnono.do?document_no=${document_no}'">
					<input type="button" id="Domt_yes" value="승인" class="myButton3" onclick="javascript:location.href='imokok.do?document_no=${document_no}'">
				</div>

			</div>

		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
</body>
<script>
	$(function() {
		$('#Domt_yes').click(function() {
			alert('승인완료');
		});
		$('#Domt_no').click(function() {
			alert('반려하였습니다');
		});
	});
</script>
<script>
	$(document).ready(function() {
		var ttt = "";
		$('.no_han').each(function() {
			ttt = $(this).text();
			if (ttt == 0) {
				$(this).text('-');
			} else if (ttt == 1) {
				$(this).text('승인');
			} else if (ttt == 2) {
				$(this).text('반려');
			}
		});
	});
</script>
</html>
