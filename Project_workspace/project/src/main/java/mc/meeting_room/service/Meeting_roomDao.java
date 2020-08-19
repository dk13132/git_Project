package mc.meeting_room.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.Setter;
import mc.meeting_room.model.Meeting_roomDto;
import mc.meeting_room.model.MyMeeting_room;
import mc.meeting_room.model.Time;
import mc.meeting_room.model.ReservationDto;

@Repository
@Setter
public class Meeting_roomDao {
	@Autowired
	SqlSession session;

	public List<Meeting_roomDto> roomList() {
		return session.selectList("meeting_room.roomList");
	}

	public List<Time> timeList(Map<String, Object> map) {
		return session.selectList("meeting_room.time", map);
	}
	
	public List<MyMeeting_room> myroomList(int employee_no){
		return session.selectList("meeting_room.myroom", employee_no);
	}
	
	public int roomReservation(ReservationDto data) {
		return session.insert("meeting_room.reservation", data);
	}
	
	public int getLastNo() {
		return session.selectOne("meeting_room.lastNo");
	}
}
