<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>회의실 예약</title>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/component.css'/>" />
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>
	$(function() {
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth() + 1; //January is 0!
		var yyyy = today.getFullYear();

		if (dd < 10) {
			dd = '0' + dd
		}

		if (mm < 10) {
			mm = '0' + mm
		}

		today = yyyy + '-' + mm + '-' + dd;
		document.getElementById("date").setAttribute("min", today);
		document.getElementById("date").setAttribute("value", today);
		changeDate();
	});

	function changeDate() {
		var url = "reservationInfo.do";

		var date = $("#date").val();
		var params = "date=" + date;

		$.ajax({
			type : "post",
			url : url,
			data : params,
			dataType : "json"
		})
				.done(
						function(args) {//응답이 성공 상태 코드를 반환하면 호출되는 함수
							$('#table').empty();
							$('#table').append("<tr>");
							$('#table').append("<th>장소명</th>");
							for (var i = 0; i < 24; i++) {
								$('#table').append("<th>" + i + "</th>");
							}
							$('#table').append("</tr>");
							for ( var key in args) {
								$('#table').append("<tr>");
								$('#table').append("<th>" + key + "</th>");
								for (var i = 0; i < args[key].length; i++) {
									if (args[key][i] == null) {
										$('#table').append(
												"<td width='50'>" + "</td>");
									} else {
										$('#table').append(
												"<td width='50'>"
														+ args[key][i]
														+ "</td>");
									}
								}
								$('#table').append("</tr>");
							}
						}).fail(function(e) {
					alert(e.responseText);
				})
	}

	function openWindowPop() {
		var url = "reservation.do";
		window.open(url, "", "width=400,height=400,left=600");
	}
</script>
</head>
<body>
	<section id="header">
		<div id=headerwrap>
			<div class="logo">
				<a href="test.do"> <img src="resources/img/logo.png" alt="">
				</a>
			</div>
			<div class="gnb">
				<div class="gnb_list">
					<ul>
						<li><a href="#">사원정보</a></li>
						<li><a href="#">게시판</a></li>
						<li><a href="meeting_room.do">회의실</a></li>
						<li><a href="#">프로젝트</a></li>
						<li><a href="chat_list.do">채팅</a></li>
						<li><a href="calendar.do">일정(캘린더)</a></li>
						<li><a href="#">전자결재</a></li>
						<c:if test="${mc_authority >= 3 }">
							<li><a href="list.do">관리자</a></li>
							<li><a href="#">근태관리</a></li>
						</c:if>
					</ul>

				</div>
			</div>

		</div>
	</section>
	<h1>회의실 예약 확인</h1>
	<h2>
		날짜 : <input type="date" id="date" name="date" onchange="changeDate()">
	</h2>
	<table id="table" border="1" style="border-collapse: collapse;">
	</table>
	<input type="button" value="예약하기" onclick="openWindowPop()" />

	<h1>내 예약 현황</h1>
	<table border="1" style="border-collapse: collapse;">
		<tr>
			<th>회의실명</th>
			<th>예약자</th>
			<th>예약시간</th>
			<th>예약인원</th>
			<th>사용목적</th>
			<th>비고</th>
		</tr>
		<c:forEach var="item" items="${list}">
			<tr>
				<td>${item.room_name}</td>
				<td>${mc_name}</td>
				<td>${item.start_time}~${item.end_time}</td>
				<td>${item.personnel}</td>
				<td>${item.purpose}</td>
				<td><input type="button" value="예약취소"></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>