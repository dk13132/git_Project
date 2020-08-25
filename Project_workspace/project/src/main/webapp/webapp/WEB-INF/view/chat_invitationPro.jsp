<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>채팅 참여 인원 추가</title>
</head>
<body>
<input type="hidden" id="msg" value="${msg}">
	<c:choose>
		<c:when test="${check == 0}">
			<script>
				alert("채팅방 초대 실패");
				history.go(-1);
			</script>
		</c:when>
		<c:otherwise>
			<script>
				opener.document.getElementById("childMsg").value = document.getElementById("msg").value;
				opener.sendMessage(2);
				self.close();
			</script>
		</c:otherwise>
	</c:choose>
</body>
</html>