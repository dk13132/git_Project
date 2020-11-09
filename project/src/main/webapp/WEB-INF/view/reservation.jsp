<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
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

input{padding:4px 10px 4px 10px; boder:1px solid #f2f2f2; border-radius: 3px; font-size: 14px;}
</style>
<title>회의실 예약</title>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>
	var index = 0; //예약시간처리용 변수
	var start = -1;
	var end = -1;

	$(function() { //현재날짜 이전선택 막고 기본값 현재날짜로 하는 부분, ajax로 부서명 출력
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

		var url = "meeting_roomList.do";

		$.ajax({
			type : "post",
			url : url,
			dataType : "json"
		}).done(
				function(args) {//응답이 성공 상태 코드를 반환하면 호출되는 함수
					for (var i = 0; i < args.length; i++) {
						$("#room").append(
								"<option value='"+args[i].room_no+"'>"
										+ args[i].room_name + "</option>");
					}
				}).fail(function(e) {
			alert(e.responseText);
		})
	});//ready 끝

	function divClick(i) { //예약 시간 선택 예외처리부분
		var id = i + "";

		if (index == 0) {
			if (document.getElementById(id).style.backgroundColor == "blue") {
				alert("선택하신 시간에 예약이 존재합니다.");
			} else {
				document.getElementById(id).style.backgroundColor = "red";
				document.getElementById("start_time").value = i;
				document.getElementById("end_time").value = eval(i + 1);
				start = i;
				index = 1;
			}
		} else if (index == 1) {
			var error = 0;
			if (document.getElementById(id).style.backgroundColor == "blue") {
				alert("선택하신 시간에 예약이 존재합니다.");
			} else if (document.getElementById(id).style.backgroundColor == "red") {
				document.getElementById(id).style.backgroundColor = "white";
				start = -1;
				index = 0;
			} else {
				if (start > i) {
					end = start;
					start = i;
				} else {
					end = i;
				}
				for (var j = start; j <= end; j++) {
					var jId = j + "";
					if (document.getElementById(jId).style.backgroundColor == "blue") {
						error = -1;
						if (start == i) {
							start = end;
							end = i;
						}
						break;
					}
				}
				if (error == -1) {
					alert("선택하신 시간대에 예약이 존재합니다.");
				} else {
					for (var j = start; j <= end; j++) {
						var jId = j + "";
						document.getElementById(jId).style.backgroundColor = "red";
					}
					document.getElementById("start_time").value = start;
					document.getElementById("end_time").value = eval(end + 1);
					index = 2;
				}
			}
		} else {
			var error = 0;
			if (document.getElementById(id).style.backgroundColor == "red") {
				for (var j = start; j <= end; j++) {
					var jId = j + "";
					document.getElementById(jId).style.backgroundColor = "white";
				}
				document.getElementById("start_time").value = "";
				document.getElementById("end_time").value = "";
				index = 0;
				end = -1;
				start = -1;
			} else {
				if (start < i) {
					for (var j = end + 1; j <= i; j++) {
						var jId = j + "";
						if (document.getElementById(jId).style.backgroundColor == "blue") {
							error = -1;
							break;
						}
					}
					if (error == -1) {
						alert("선택하신 시간대에 예약이 존재합니다.");
					} else {
						for (var j = end + 1; j <= i; j++) {
							var jId = j + "";
							document.getElementById(jId).style.backgroundColor = "red";
						}
						end = i;
						document.getElementById("start_time").value = start;
						document.getElementById("end_time").value = eval(end + 1);
					}
				} else {
					for (var j = start - 1; j >= i; j--) {
						var jId = j + "";
						if (document.getElementById(jId).style.backgroundColor == "blue") {
							error = -1;
							break;
						}
					}
					if (error == -1) {
						alert("선택하신 시간대에 예약이 존재합니다.");
					} else {
						for (var j = start - 1; j >= i; j--) {
							var jId = j + "";
							document.getElementById(jId).style.backgroundColor = "red";
						}
						start = i;
						document.getElementById("start_time").value = start;
						document.getElementById("end_time").value = eval(end + 1);
					}
				}
			}
		}
	}

	function dateOrRoomChange() { //예약 현황 불러오는 ajax
		index = 0;
		start = 0;
		end = 0;
		var url = "reservationInfoOne.do";

		var date = $("#date").val();
		var room_no = $("#room").val();

		var params = "date=" + date + "&room_no=" + room_no;

		$
				.ajax({
					type : "post",
					url : url,
					data : params,
					dataType : "json"
				})
				.done(
						function(args) {//응답이 성공 상태 코드를 반환하면 호출되는 함수
							$('#table').empty();
							$('#table').append("<tr>")
							for (var i = 0; i < 24 / 2; i++) {
								$('#table').append("<th>" + i + "</th>");
							}
							$('#table').append("</tr>")
							$('#table').append("<tr>")
							for (var i = 0; i < args.length / 2; i++) {
								if (args[i] == null) {
									$('#table')
											.append(
													"<td width='50' height='30'><div id="
															+ i
															+ " value="
															+ i
															+ " style='height:100%; width:100%; background-color:white;' onclick='divClick("
															+ i
															+ ")'></div></td>");
								} else {
									$('#table')
											.append(
													"<td width='50' height='30'><div id="
															+ i
															+ " value="
															+ i
															+ " style='height:100%; width:100%; background-color:blue;' onclick='divClick("
															+ i
															+ ")'></div></td>");
								}
							}
							$('#table').append("</tr>")
							$('#table').append("<tr>")
							for (var i = 24 / 2; i < 24; i++) {
								$('#table').append("<th>" + i + "</th>");
							}
							$('#table').append("</tr>")
							$('#table').append("<tr>")
							for (var i = args.length / 2; i < args.length; i++) {
								if (args[i] == null) {
									$('#table')
											.append(
													"<td width='50' height='30'><div id="
															+ i
															+ " value="
															+ i
															+ " style='height:100%; width:100%; background-color:white;' onclick='divClick("
															+ i
															+ ")'></div></td>");
								} else {
									$('#table')
											.append(
													"<td width='50' height='30'><div id="
															+ i
															+ " value="
															+ i
															+ " style='height:100%; width:100%; background-color:blue;' onclick='divClick("
															+ i
															+ ")'></div></td>");
								}
							}
							$('#table').append("</tr>")
						}).fail(function(e) {
					alert(e.responseText);
				})
	}

	function check() {
		var room_no = form.room_no.value;
		var purpose = form.purpose.value;
		var date = form.date.value;
		var personnel = form.date.value;
		var start_time = form.st_time.value;
		var end_time = form.ed_time.value;

		if (room_no == -1) {
			alert("회의실을 선택해주세요.");
			return false;
		}
		if (purpose == "") {
			alert("사용 목적을 입력해 주세요.");
			return false;
		}
		if (date == "") {
			alert("날짜를 입력해 주세요.");
			return false;
		}
		if (personnel == "") {
			alert("예약인원을 입력해 주세요.");
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<h1>회의실 예약</h1>
	<br>
	<form method="post" name="form" onsubmit="check()">
		회의실 <select id="room" name="room_no" onchange="dateOrRoomChange()">
			<option value="-1">::회의실 선택::</option>
		</select><br> 사용목적 <input type="text" name="purpose"><br> 날짜
		<input type="date" id="date" name="date" onchange="dateOrRoomChange()"><br>
		예약인원 <input type="number" name="personnel"><br>
		<h3>회의실 시간</h3>
		<table id="table" border="1" style="border-collapse: collapse;">
		</table>
		<input type="hidden" id="start_time" name="st_time" value="">
		<input type="hidden" id="end_time" name="ed_time" value=""> <input
			class="myButton" type="submit" value="등록"> <input class="myButton" type="button" value="취소"
			onclick="javascript:window.close()">
	</form>
</body>
</html>