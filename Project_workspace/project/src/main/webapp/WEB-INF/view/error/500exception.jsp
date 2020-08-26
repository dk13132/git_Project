<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>

<%		
	String resultMsg = ""; 
	resultMsg += "<script type='text/javascript'>"; 
	resultMsg += "alert('테이블 정보를 확인해주세요.'); history.go(-1); ";	
	resultMsg += "</script>"; 
	out.print(resultMsg); 	
%>

</body>
</html>