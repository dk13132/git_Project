<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#appwarp {width: 720px;margin: 0 auto; margin-top: 30px;}
table{	border-collapse: collapse;}
tr, td {border: solid 1px #7A7A7A; text-align: center; }
input, button {border: solid 1px #7A7A7A;}
h2 {text-align: center;	margin-bottom: 60px;}
#domtinfortable {width: 98%;}
#apptable{margin: auto;margin-right: 0px; padding: 10px;font-size: 17px;}
h4 {margin:10px 0px 5px 0px;}
.subject{width: 98%; font-size: 16px; padding: 3px;}
.naversm{width: 98%;}
.barder {width: 98%;border: 1px solid #000;}
.barder2 {width: 97%; height:350px;  border: 1px solid #000;padding: 5px;}
h4{padding: 5px; margin: 0px;}
</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
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
</head>
<body>
	<div id="appwarp">
		<table id=apptable>
			<tr id="first">
				<td style="background-color: #f4f4f4;" rowspan="2">결<br>재</td>
				<c:forEach var="domt_appline_view" items="${domt_appline}">
					<td>${domt_appline_view.dept_name}</td>
				</c:forEach>
			</tr>
			<tr id="second">
				<c:forEach var="domt_appline_view" items="${domt_appline}">
					<td>${domt_appline_view.name}<br>
						<span class="no_han">${domt_appline_view.state}</span>
					</td>
				</c:forEach>
			</tr>
		</table>
		<h2>휴가신청서</h2>
	<table id="domtinfortable">
		<tr style="font-weight: bold;">
			<td>문서번호</td>
			<td>작성일</td>
			<td>작성부서</td>
			<td>작성자</td>
		</tr>
			<tr>
				<td>자동채번(${document_no})</td>
				<td>${reg_date} </td>
				<td>${dept_name}</td>
				<td>${name}</td>
			</tr>
	</table>
	<br>
	
	<form action="../insert_App_And_Domt.do" method="POST" id="app_line_add_input">

		<%-- <div class ="barder"><h4>&nbsp;${subject}</h4></div><br> --%>
		<div class ="barder2">&nbsp;${contents}</div>
		<input type="button" value="목록으로" onclick="history.go(-1)">
	</form>
	
	
	</div>
</body>
</html>