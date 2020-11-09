package mc.chat.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatListDto {
	private int chat_no;
	private String name;
	private String chat_name;
	private int count;
	private Timestamp send_time;
}
