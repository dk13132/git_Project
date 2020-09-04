package mc.chat.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import mc.chat.model.MessageDto;
import mc.chat.service.ChatService;

@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler {

	@Autowired
	ChatService service;
	// 세션 리스트
	private Map<String, List<WebSocketSession>> sessionMap = new TreeMap<String, List<WebSocketSession>>();

	private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);

	// 클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
		int index = message.getPayload().indexOf(",");
		int index2 = message.getPayload().indexOf(",", index + 1);
		String chat_no = message.getPayload().substring(0, index);
		String employee_no = message.getPayload().substring(index + 1, index2);
		String idMsg = message.getPayload().substring(index2 + 1);
		index = idMsg.indexOf(":");
		String name = idMsg.substring(0, index);
		String msg = idMsg.substring(index + 1);

		if (msg.equals("")) {
			if (sessionMap.containsKey(chat_no)) {
				sessionMap.get(chat_no).add(session);
			} else {
				List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
				sessionList.add(session);
				sessionMap.put(chat_no, sessionList);
			}
		} else {
			// 모든 유저에게 메세지 출력
			for (WebSocketSession sess : sessionMap.get(chat_no)) {
				sess.sendMessage(new TextMessage(employee_no + "," + idMsg));
			}
			MessageDto dto = new MessageDto();
			dto.setChat_no(Integer.parseInt(chat_no));
			if (name.equals("-1") || name.equals("-2")) {
				dto.setEmployee_no(0);
			} else {
				dto.setEmployee_no(Integer.parseInt(employee_no));
			} 
			dto.setContents(idMsg);
			service.insertMessage(dto);
		}
	}

	// 클라이언트 연결을 끊었을 때 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// sessionList.remove(session);
		EXIT: for (String key : sessionMap.keySet()) {
			for (WebSocketSession sess : sessionMap.get(key)) {
				if (sess.equals(session)) {
					sessionMap.get(key).remove(session);
					break EXIT;
				}
			}
		}
		logger.info("{} 연결 끊김.", session.getId());
	}
}
