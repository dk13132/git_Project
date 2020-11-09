package mc.meeting_room.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ReservationDto {
	private int reservation_no;
	private int room_no;
	private int employee_no;
	private Timestamp start_time;
	private Timestamp end_time;
	private int personnel;
	private String purpose;
	private String st_time;
	private String ed_time;
	private String date;
}