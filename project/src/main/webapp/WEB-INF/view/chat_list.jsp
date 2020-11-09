<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/resources/css/depinfo.css'/>" />
<title>채팅 목록</title>
<style>
.myButton {
	background:linear-gradient(to bottom, #8c9ebd 5%, #578ac7 100%);
	background-color:#8c9ebd;
	border-radius:3px;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	padding:5px 10px;
	text-decoration:none;
	margin: 14px 0px 0px 0px;
}
</style>
<script>
	var tmp;
	var Clip;
	function openWindowCreate() {
		var url = "create_chat.do";

		if (!tmp) {
			Clip = window.open(url, "", "width=400,height=400,left=600");
			tmp = true;
		} else {
			if (!Clip.closed && Clip) {
				Clip.focus();
			} else {
				Clip = window.open(url, "", "width=400,height=400,left=600");
				tmp = true;
			}
		}
	}

	function openRoom(data) {
		Clip = window.open(data.href, data.href, 'width=600, height=700');
	}
</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="/WEB-INF/view/head.jsp" flush="false" />
		<section id="content">
			<div id="leftcontent">
				<ul>
					<li><a class="active" href="chat_list.do">참여 채팅방 목록</a></li>
				</ul>
			</div>
			<div id="rightcontent">
				<h1>내 채팅 목록</h1>
				<table border="1" style="border-collapse: collapse;">
					<tr>
						<th>번호</th>
						<th>채팅방 이름</th>
						<th>채팅방개설자</th>
						<th>인원수</th>
						<th>마지막 채팅 시간</th>
					</tr>
					<c:choose>
						<c:when test="${empty list}">
							<tr>
								<td colspan="5">참여중인 채팅이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="item" items="${list}" varStatus="status">
								<c:url value="chat_room.do" var="url">
									<c:param name="chat_no" value="${item.chat_no}" />
									<c:param name="chat_name" value="${item.chat_name}" />
								</c:url>
								<input type="hidden" id="url" value="${url}">
								<tr>
									<td>${status.count}</td>
									<td><a href="${url}"
										onclick="openRoom(this); return false">${item.chat_name}</a>
									<td>${item.name}</td>
									<td>${item.count}</td>
									<c:choose>
										<c:when test="${empty item.send_time}">
											<td>채팅 내역이 없습니다.</td>
										</c:when>
										<c:otherwise>
											<td>${item.send_time}</td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
				<input class="myButton" type="button" value="채팅방생성" onclick="openWindowCreate()">
			</div>
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
</body>
</html>