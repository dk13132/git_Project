package mc.calendar.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class CalendarDto {
	private int readcount;
	private int employee_no;

	private String subject; // �씪�젙�젣紐�
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date start_time;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date end_time; 
	private int type;
	private String name;
	private String location; // �옣�냼
	private String contents; // �씪�젙�궡�슜
	private int public_availability; // 怨듦컻�뿬遺�
	private String password; // 鍮꾨�踰덊샇

	private int calendar_no;
	private int file_no;
	private String file_name; // �뙆�씪紐�
	private String file_path; // �뙆�씪寃쎈줈
	private String stored_file_name; // �뙆�씪 蹂�寃�
	private String del_gb; // �궘�젣�뙆�씪
	private int filesize; // �뙆�씪�겕湲�

}
