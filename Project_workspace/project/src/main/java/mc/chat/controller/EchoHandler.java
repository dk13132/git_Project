package mc.chat.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler {
	// 세션 리스트
	// private List<WebSocketSession> sessionList = new
	// ArrayList<WebSocketSession>();
	private Map<String, List<WebSocketSession>> sessionMap = new TreeMap<String, List<WebSocketSession>>();
	
	private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);

	// 클라이언트가 연결 되었을 때 실행
	/*
	 * @Override public void afterConnectionEstablished(WebSocketSession session)
	 * throws Exception { sessionList.add(session); logger.info("{} 연결됨",
	 * session.getId()); }
	 */

	// 클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
		System.out.println(session.getId());
		int index = message.getPayload().indexOf(",");
		int index2 = message.getPayload().indexOf(",", index + 1);
		String num = message.getPayload().substring(0, index);
		String chat_no = message.getPayload().substring(index + 1, index2);
		String msg = message.getPayload().substring(index2 + 1);

		if (num.equals("0")) {
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
				sess.sendMessage(new TextMessage(msg));
			}
		}
		/*
		 * for (WebSocketSession sess : sessionList) { sess.sendMessage(new
		 * TextMessage(msg)); }
		 */
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
