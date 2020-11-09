<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>회의실 예약</title>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/depinfo.css'/>" />
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<style>
.myButton {
	background: linear-gradient(to bottom, #8c9ebd 5%, #578ac7 100%);
	background-color: #8c9ebd;
	border-radius: 3px;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	padding: 5px 10px;
	text-decoration: none;
	margin: 14px 0px 0px 0px;
}
</style>
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
		var index = 0;
		var date = $("#date").val();
		var params = "date=" + date;

		$.ajax({
			type : "post",
			url : url,
			data : params,
			dataType : "json"
		}).done(
				function(args) {//응답이 성공 상태 코드를 반환하면 호출되는 함수
					$('#table').empty();
					$('#table').append("<tr id='trMain'>");
					$('#trMain').append("<th>장소명</th>");
					for (var i = 0; i < 24; i++) {
						$('#trMain').append("<th>" + i + "</th>");
					}
					$('#table').append("</tr>");
					for ( var key in args) {
						$('#table').append("<tr id='tr" + index + "'>");
						$('#tr' + index).append("<td>" + key + "</td>");
						for (var i = 0; i < args[key].length; i++) {
							if (args[key][i] == null) {
								$('#tr' + index).append("<td>" + "</td>");
							} else {
								$('#tr' + index).append(
										"<td>" + args[key][i] + "</td>");
							}
						}
						$('#table').append("</tr>");
						index++;
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
<style>
#myTable {
	height: 300px;
	overflow: auto;
}
</style>
</head>
<body>
	<div id="wrap">
		<jsp:include page="/WEB-INF/view/head.jsp" flush="false" />
		<section id="content">
			<div id="leftcontent">
				<ul>
					<li><a class="active" href="meeting_room.do">회의실 예약</a></li>
				</ul>
			</div>
			<div id="rightcontent">
				<h1>회의실 예약 확인</h1>
				<h2>
					날짜 : <input type="date" id="date" name="date"
						onchange="changeDate()">
				</h2>
				<table id="table">
				</table>
				<input class="myButton" type="button" value="예약하기"
					onclick="openWindowPop()" />

				<br>
				<br>
				<h1>내 예약 현황</h1>
				<form action="reservationCancel.do" method="post">
					<div id="myTable">
						<table>
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
									<td><input type="checkbox" name="reservation_no" value="${item.reservation_no}"></td>
								</tr>
							</c:forEach>
						</table>
						<input class="myButton" type="submit" value="예약취소" />
					</div>
				</form>
			</div>
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
</body>
<script>
	var today = new Date();
	var date = new Date();
	function prevCalendar() {
		today = new Date(today.getFullYear(), today.getMonth() - 1, today
				.getDate());
		buildCalendar();
	}

	function nextCalendar() {
		today = new Date(today.getFullYear(), today.getMonth() + 1, today
				.getDate());
		buildCalendar();
	}
	function buildCalendar() {
		var doMonth = new Date(today.getFullYear(), today.getMonth(), 1);

		var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);

		var tbCalendar = document.getElementById("calendar");

		var tbCalendarYM = document.getElementById("tbCalendarYM");

		tbCalendarYM.innerHTML = today.getFullYear() + "년 "
				+ (today.getMonth() + 1) + "월";

		while (tbCalendar.rows.length > 2) {

			tbCalendar.deleteRow(tbCalendar.rows.length - 1);

		}
		var row = null;
		row = tbCalendar.insertRow();

		var cnt = 0;
		for (i = 0; i < doMonth.getDay(); i++) {

			cell = row.insertCell();
			cnt = cnt + 1;
		}

		for (i = 1; i <= lastDate.getDate(); i++) {

			cell = row.insertCell();
			cell.innerHTML = i;
			cnt = cnt + 1;
			if (cnt % 7 == 1) {
				cell.innerHTML = "<font color=#F79DC2>" + i

			}
			if (cnt % 7 == 0) {
				cell.innerHTML = "<font color=skyblue>" + i

				row = calendar.insertRow();

			}

			if (today.getFullYear() == date.getFullYear()
					&& today.getMonth() == date.getMonth()
					&& i == date.getDate()) {

				cell.bgColor = "#FAF58C";
			}
		}
	}
</script>
<script>
	buildCalendar();
</script>
</html>