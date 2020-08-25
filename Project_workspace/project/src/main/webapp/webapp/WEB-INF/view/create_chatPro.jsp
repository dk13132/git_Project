<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>채팅 생성</title>
</head>
<body>
	<c:choose>
		<c:when test="${check == 0}">
			<script>
				alert("채팅방 생성 실패");
				history.go(-1);
			</script>
		</c:when>
		<c:otherwise>
			<script>
				alert("채팅방 생성 성공");
				opener.location.reload();
				self.close();
			</script>
		</c:otherwise>
	</c:choose>
</body>
</html>