<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
</head>
<body>
	<h1>${chat_name}</h1>
	<input type="hidden" id="chat_no" value="${chat_no}">
	<input type="hidden" id="employee_no" value="${employee_no}">
	<input type="hidden" id="name" value="${mc_name}">
	<table border="1" style="border-collapse: collapse;">
		<tr>
			<td colspan="2" width="350" height="500" valign="top">
				<div id="messageArea" style="height: 500px; overflow: auto;"></div>
			</td>
		</tr>
		<tr>
			<td width="300"><input style="width: 97%;" type="text"
				id="message" onkeyup="messageChange()"/></td>
			<td><input type="button" id="sendBtn" value="전송" disabled="disabled"/></td>
		</tr>
	</table>
</body>
<script type="text/javascript">
	let sock = new SockJS("http://192.168.0.118:8081/mc/echo");
	sock.onopen = function() {
		sendMessage(0);
	};
	sock.onmessage = onMessage;
	sock.onclose = onClose;

	$("#sendBtn").click(function() {
		sendMessage(1);
		$('#message').val('')
		$("#sendBtn").attr("disabled","disabled");
	});

	// 메시지 전송
	function sendMessage(num) {
		var item = $('#name').val();
		var chat_no = $('#chat_no').val();
		if (num == 0) {
			sock.send(num + "," + chat_no + "," + item + "");
		} else {
			sock.send(num + "," + chat_no + "," + item + " : "
					+ $("#message").val());
		}
	}
	// 서버로부터 메시지를 받았을 때
	function onMessage(msg) {
		var data = msg.data;
		$("#messageArea").append(data + "<br/>");
	}

	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		$("#messageArea").append("연결 끊김");
	}

	function messageChange(){
		if ($("#message").val() == ""){
			$("#sendBtn").attr("disabled","disabled");
		} else {
			$("#sendBtn").removeAttr("disabled");
		}
	}
</script>
</html>