package mc.chat.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MessageDto {
	private int message_no;
	private int chat_no;
	private int employee_no;
	private String contents;
	private Timestamp send_time;
}
