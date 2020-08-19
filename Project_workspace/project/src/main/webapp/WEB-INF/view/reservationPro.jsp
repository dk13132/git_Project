<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>예약</title>
</head>
<body>
<c:choose>
	<c:when test="${check > 0}">
		<script>
			alert("예약성공");
			opener.location.reload();
			self.close();
		</script>
	</c:when>
	<c:otherwise>
		<script>
			alert("예약실패");			
			location.href = "reservation.do";
		</script>
	</c:otherwise>
</c:choose>
</body>
</html>