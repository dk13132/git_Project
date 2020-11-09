<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방</title>
<style>
th, td { text-align: left; padding: 7px;}
tr:nth-child(even){background-color: #f2f2f2}
th { background-color: #767676; color: white;}
th:first-child { background-color: #767676; color: white; border-radius: 3px 0px 0px 0px }
th:last-child { background-color: #767676; color: white; border-radius: 0px 3px 0px 0px }
</style>
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
</head>
<body>
	<h1>${chat_name}</h1>
	<input type="hidden" id="childMsg">
	<br>
	<input type="hidden" id="chat_no" value="${chat_no}">
	<input type="hidden" id="employee_no" value="${mc_employee_no}">
	<input type="hidden" id="name" value="${mc_name}">
	<table border="1"
		style="border-collapse: collapse; float: left; margin-left: 0px; margin-right: 5px">
		<tr>
			<td colspan="2" width="350" height="500" valign="top">
				<div id="messageArea" style="height: 500px; overflow: auto;"></div>
			</td>
		</tr>
		<tr>
			<td width="300"><input style="width: 97%; text-align: top"
				type="text" id="message" onkeyup="messageChange()" /></td>
			<td><input type="button" id="sendBtn" value="전송"
				disabled="disabled" /></td>
		</tr>
	</table>
	<table id="headCount" border="1"
		style="width: 180px; border-collapse: collapse; margin-bottom: 5px;">
	</table>
	<input type=button id="addEmp"
		value="선택한 상대 초대" onclick="openWindowInvitation()">

</body>
<script type="text/javascript">
	let sock = new SockJS("echo");
	sock.onopen = function() {
		sendMessage(0);
	};
	sock.onmessage = onMessage;
	sock.onclose = onClose;

	$(function() {
		var url = "messageInfo.do";
		var employee_no = $('#employee_no').val();
		var chat_no = $("#chat_no").val();
		var params = "chat_no=" + chat_no + "&employee_no=" + employee_no;
		var messageArea = document.getElementById("messageArea");

		$.ajax({
			type : "post",
			url : url,
			data : params,
			dataType : "json"
		}).done(
				function(args) {//응답이 성공 상태 코드를 반환하면 호출되는 함수
					for (var i = 0; i < args.length; i++) {
						if (args[i].employee_no == $('#employee_no').val()) {
							var contentArr = args[i].contents.split(':');
							var msg = contentArr[1];
							$("#messageArea").append(
									"<p style='text-align:right'>" + msg
											+ "</p>");
						} else if (args[i].employee_no == 0) {
							var contentArr = args[i].contents.split(':');
							var msg = contentArr[1];
							$("#messageArea").append(
									"<p style='text-align:center'>" + msg
											+ "</p>");
						} else {
							$("#messageArea").append(
									"<p style='text-align:left'>"
											+ args[i].contents + "</p>");
						}
					}
					messageArea.scrollTop = messageArea.scrollHeight;
				}).fail(function(e) {
			alert(e.responseText);
		})
		peopleList();
	})
	
	function openWindowInvitation(){
		var chat_no = $('#chat_no').val();
		var url = "chat_invitation.do?chat_no=" + chat_no;
		window.open(url, "", "width=400,height=400,left=600");
	}
	
	function deptClick(dept_no){
		var url = "empInvitationList.do";
		var chat_no = $('#chat_no').val();
		var params = "dept_no=" + dept_no + "&chat_no=" + chat_no;

		$.ajax({
			type : "post",
			url : url,
			data : params,
			dataType : "json"
		}).done(
				function(args) {//응답이 성공 상태 코드를 반환하면 호출되는 함수
					$('#dept').empty();
					if (args !== null) {
						for (var i = 0; i < args.length; i++) {
							if (args[i].employee_no != $("#myNo").val()) {
								$('#dept').append(
										"<input type='checkbox' value='"+args[i].employee_no+"'>"
												+ args[i].name);
							}
						}
					}
				}).fail(function(e) {
			alert(e.responseText);
		})
	}

	function peopleList() {
		var url = "employeeInfo.do";
		var chat_no = $("#chat_no").val();
		var params = "chat_no=" + chat_no;

		$
				.ajax({
					type : "post",
					url : url,
					data : params,
					dataType : "json"
				})
				.done(
						function(args) {//응답이 성공 상태 코드를 반환하면 호출되는 함수
							$("#headCount").empty();
							$("#headCount").append(
									"<tr><th> 참여인원 : " + Object.keys(args)[0]
											+ "명 </th></tr>");
							$("#headCount")
									.append(
											"<tr><td id='td' height='205' valign='top'>");
							$("#td")
									.append(
											"<div id='people' style='height: 205px; overflow: auto;'>");
							for (var i = 0; i < args[Object.keys(args)[0]].length; i++) {
								$("#people")
										.append(
												args[Object.keys(args)[0]][i].dept_name
														+ " "
														+ args[Object
																.keys(args)[0]][i].position
														+ " "
														+ args[Object
																.keys(args)[0]][i].name
														+ "<br>");
							}
							$("#td").append("</div>");
							$("#headCount").append("</td></tr>");
							$("#headCount")
									.append(
											"<tr><td align='center'><input type='button' name='close' value='종료' onclick='javascript:self.close()'> <input type='button' name='exitBtn' value='퇴장' onclick='exit()'></td></tr>")
						}).fail(function(e) {
					alert(e.responseText);
				});
	}

	$("#sendBtn").click(function() {
		sendMessage(1);
		$('#message').val('');
		$("#sendBtn").attr("disabled", "disabled");
	});

	// 메시지 전송
	function sendMessage(num) {
		var item = $('#name').val();
		var chat_no = $('#chat_no').val();
		var employee_no = $('#employee_no').val();
		var childMsg = $('#childMsg').val();
		if (num == 0) {
			sock.send(chat_no + "," + employee_no + "," + item + ":");
		} else if (num == 2) {
			sock.send(chat_no + "," + employee_no + ",-1:" + childMsg);
		} else if (num == 3) {
			sock.send(chat_no + "," + employee_no + ",-2:" + childMsg);
		} else {
			sock.send(chat_no + "," + employee_no + "," + item + ":"
					+ $("#message").val());
		}
	}
	// 서버로부터 메시지를 받았을 때
	function onMessage(msg) {
		var data = msg.data;
		var index = data.indexOf(",")
		var content = data.substring(index + 1);
		var employee_no = data.substring(0, index);
		var msgArr = content.split(':');
		var msg = msgArr[1];
		var messageArea = document.getElementById("messageArea");

		if (employee_no != $('#employee_no').val() && msgArr[0] == -2) {
			history.go(0);
		} else if (msgArr[0] == -1) {
			history.go(0);
		} else if (employee_no == $('#employee_no').val()) {
			$("#messageArea").append(
					"<p style='text-align:right'>" + msg + "</p>");
		} else {
			$("#messageArea").append(
					"<p style='text-align:left'>" + content + "</p>");
		}
		messageArea.scrollTop = messageArea.scrollHeight;
		opener.history.go(0);
	}

	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		$("#messageArea").append("연결 끊김");
	}

	function messageChange() {
		if ($("#message").val() == "") {
			$("#sendBtn").attr("disabled", "disabled");
		} else {
			$("#sendBtn").removeAttr("disabled");
		}
	}

	function loadDept() {
		var chat_no = $('#chat_no').val();
		var url = "chat_invitation.do";
		$.ajax({
			type : "get",
			url : url,
			data : "chat_no=" + chat_no,
			dataType : "json"
		}).done(
				function(args) {//응답이 성공 상태 코드를 반환하면 호출되는 함수
					for (var i = 0; i < args.length; i++) {
						$("#dept").append(
								"<div id='dept_no" + args[i].dept_no +"' value=" + args[i].dept_no + " onclick='deptClick(" + args[i].dept_no + ")'>"
										+ args[i].dept_name + "</div>");
					}
				}).fail(function(e) {
			alert(e.responseText);
		});
	}

	function exit() {
		var url = "exitChat.do?";
		var chat_no = $('#chat_no').val();
		var employee_no = $('#employee_no').val();
		var name = $('#name').val();
		document.getElementById("childMsg").value = name + "님이 퇴장하였습니다.";

		location.href = url + "chat_no=" + chat_no + "&employee_no="
				+ employee_no;

		sendMessage(3);
	}
</script>
</html>