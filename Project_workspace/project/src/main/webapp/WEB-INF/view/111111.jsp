<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
</head>
<body>
	<div id="wrap">
		<jsp:include page ="/WEB-INF/view/head.jsp" flush="false"/>
		<section id="content">
			<div id="leftcontent">		
					<ul>
						<li><a href="list.do">부서관리</a></li>
						<br>
						<li><a class="active" href="authority.do">권한관리</a></li>
						<br>					
					</ul>			
			</div>
			
			<div id="rightcontent">
			
			
			</div>
			
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp"  flush="false"/>
	</div>
</body>
</html>

