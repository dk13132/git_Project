<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>메인</title>
</head>
<body>
환영요 ${mc_name}님<br>
<input type="button" value="로그아웃" onclick="javascript:location.href='logout.do'">
<input type="button" value="회의실예약" onclick="javascript:location.href='meeting_room.do'">
<input type="button" value="채팅" onclick="javascipt:location.href='chat_list.do'">
<input type="button" value="일정" onclick="javascipt:location.href='calendar.do'">
</body>
</html>