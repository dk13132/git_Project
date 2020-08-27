<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>회의실 예약</title>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
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
	<div id="wrap">
		<jsp:include page ="/WEB-INF/view/head.jsp" flush="false"/>
		<section id="content">
		 <div id="nav">
			<div id="login">
        		<br>                    
                <h1 align="left">환영합니다. ${mc_name}님</h1>
                <br>
				<button type="button">내정보</button>&nbsp;&nbsp;
				<button type="button" onclick="javascript:location.href='logout.do'">로그아웃</button>	
			</div>
			
			<div id="cal">
				<table id="calendar" frame="void">
				    <tr>
				        <td><label onclick="prevCalendar()"><<</label></td>
				        <td align="center" id="tbCalendarYM" colspan="5">
				        yyyy년 m월</td>
				        <td><label onclick="nextCalendar()">>>
					            
				        </label></td>
				    </tr>
				    <tr>
				        <td align="center"><font color ="#F79DC2">일</td>
				        <td align="center">월</td>
				        <td align="center">화</td>
				        <td align="center">수</td>
				        <td align="center">목</td>
				        <td align="center">금</td>
				        <td align="center"><font color ="skyblue">토</td>
					    </tr> 
					</table>
         	</div>
         </div>
			<div id="article">
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

			</div>
			
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp"  flush="false"/>
	</div>
</body>
<script>
        var today = new Date();
        var date = new Date();
        function prevCalendar() {
         today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
         buildCalendar(); 
        }
 
        function nextCalendar() {
             today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
             buildCalendar();
        }
        function buildCalendar(){
            var doMonth = new Date(today.getFullYear(),today.getMonth(),1);
            
            var lastDate = new Date(today.getFullYear(),today.getMonth()+1,0);
            
            var tbCalendar = document.getElementById("calendar");
           
            var tbCalendarYM = document.getElementById("tbCalendarYM");
             
             tbCalendarYM.innerHTML = today.getFullYear() + "년 " + (today.getMonth() + 1) + "월"; 
 
             
            while (tbCalendar.rows.length > 2) {
            
                  tbCalendar.deleteRow(tbCalendar.rows.length-1);
                  
             }
             var row = null;
             row = tbCalendar.insertRow();
             
             var cnt = 0;
             for (i=0; i<doMonth.getDay(); i++) {
            
                  cell = row.insertCell();
                  cnt = cnt + 1;
             }
           
             for (i=1; i<=lastDate.getDate(); i++) { 
             
                  cell = row.insertCell();
                  cell.innerHTML = i;
                  cnt = cnt + 1;
              if (cnt % 7 == 1) {
                cell.innerHTML = "<font color=#F79DC2>" + i
                
            }    
              if (cnt%7 == 0){
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