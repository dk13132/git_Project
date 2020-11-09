package mc.meeting_room.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MyMeeting_room {
	private int reservation_no; 
	private String room_name;
	private Timestamp start_time;
	private Timestamp end_time;
	private int personnel;
	private String purpose;
}
