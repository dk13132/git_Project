<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>일정 관리</title>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/component.css'/>" />
<link href="<%=request.getContextPath()%>/resources/lib/main.css"
	rel='stylesheet' />
<script src="<%=request.getContextPath()%>/resources/lib/main.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script>
	$(function(){
		$("#btnSearch").click(function() {
			var url = "calendar.do";
			url = url + "?type=" + $('#type').val();
			url = url + "&searchType=" + $('#searchType').val();
			url = url + "&keyword=" + $('#keyword').val();
			location.replace(url);
		});
	});
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			customButtons: {
		           addCalendar: {
		               text: '일정 추가',
		               click: function() {
		            		var url = "calendarWrite.do";
		            		var name = "calendarWrite.do";
		            		var option = "width = 600, height = 480 left = 100, top=50,location=no";
		            		window.open(url,name,option) 
		               }
		           }
		     },
			headerToolbar : {
				left : 'prev,next today',
				center : 'title',
				right : 'dayGridMonth,listMonth addCalendar'
			},
			locale : "ko",
			navLinks : true, // can click day/week names to navigate views
			eventLimit : true,
			events : [ 
				<c:forEach var="calendar" items="${list.boardList}">
				{
					title : '${calendar.subject}',
					start : '<fmt:formatDate value="${calendar.start_time}" pattern="yyyy-MM-dd hh:mm:ss" />',
					url : 'calendarContent.do?calendar_no=${calendar.calendar_no}&p=${list.requestPage}',
					end : '<fmt:formatDate value="${calendar.end_time}" pattern="yyyy-MM-dd hh:mm:ss" />',
					<c:choose>
						<c:when test="${calendar.type == 1}">
							color : '#FF0000'
						</c:when>
						<c:otherwise>
							color : '#0000FF'
						</c:otherwise>
					</c:choose>
				},
				</c:forEach>  
			]
	        ,eventClick:function(info) {
	        		info.jsEvent.preventDefault();
	        		if (info.event.url) {
	        			var option = "width = 800, height = 400 left = 100, top=50,location=no";
	            		window.open(info.event.url, info.event.title, option);
	            		return false;
	        		}
	         }
		});
		calendar.render();
	});
</script>
<style>
body {
	margin: 40px 10px;
	padding: 0;
	font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	font-size: 14px;
}

#calendar {
	max-width: 1100px;
	margin: 0 auto;
}

.add-button {
	position: absolute;
	background: #2C3E50;
	border: 0;
	color: white;
	height: 35px;
	border-radius: 3px;
	width: 157px;
}

.fc-day-sun {
	color: #FF0000;
}

.fc-day-sat {
	color: #0000FF;
}
</style>
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
	<form align="center" id="data" method="post">
		<input type="hidden" name="type" value="${type}"> <select
			id="type" name="type" style="padding: 1px 0.5px 6px 1px;">
			<option value="0" ${type == "0"?"selected":""}>전체 일정</option>
			<option value="1" ${type == "1"?"selected":""}>개인 일정</option>
			<option value="2" ${type == "2"?"selected":""}>회사 일정</option>
		</select>&nbsp; <select id="searchType" name="searchType"
			style="padding: 1px 0.5px 6px 1px;">
			<option value="subject" ${searchType == "subject"?"selected":""}>제목</option>
			<option value="name" ${searchType == "name"?"selected":""}>작성자</option>
		</select> &nbsp; <input id="keyword" name="keyword" type="text"> <input
			name="btnSearch" id="btnSearch" type="button" value="검색"> <br>
	</form>
	<br>
	<br>
	<div id='calendar' style="position: relative;"></div>
</body>
</html>
