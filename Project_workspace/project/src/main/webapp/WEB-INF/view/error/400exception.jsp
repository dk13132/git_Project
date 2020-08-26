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
	resultMsg += "alert('형식을 맞춰주세요.'); history.go(-1); ";	
	resultMsg += "</script>"; 
	out.print(resultMsg); 	
%>

</body>
</html>