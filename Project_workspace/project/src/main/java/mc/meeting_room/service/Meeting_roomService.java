package mc.meeting_room.service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import mc.meeting_room.model.Meeting_roomDto;
import mc.meeting_room.model.MyMeeting_room;
import mc.meeting_room.model.ReservationDto;
import mc.meeting_room.model.Time;

@Service
@Setter
public class Meeting_roomService {
	@Autowired
	Meeting_roomDao dao;
	
	public Map<String, String[]> roomList(Date date) {
		List<Meeting_roomDto> list = dao.roomList();
		Map<String, String[]> result = new TreeMap<>();
		for(int i = 0; i < list.size(); i++) {
			Map<String, Object> map = new HashMap<>();
			map.put("currentDate", date);
			map.put("room_no", list.get(i).getRoom_no());
			List<Time> tlist = dao.timeList(map);
			String[] state = new String[24];
			for(int j = 0; j < tlist.size(); j++) {
				for(int k = tlist.get(j).getStart(); k <= tlist.get(j).getEnd() - 1; k++) {
					state[k] = tlist.get(j).getName();
				}
			}
			result.put(list.get(i).getRoom_name(), state);
		}
		return result;
	}
	
	public List<Meeting_roomDto> roomList(){
		return dao.roomList();
	}
	
	public List<MyMeeting_room> myroomList(int employee_no){
		return dao.myroomList(employee_no);
	}
	
	public void roomReservation(ReservationDto dto) {
		dao.roomReservation(dto);
	}
	
	public String[] roomListOne(Date date, int room_no){
		Map<String, Object> map = new HashMap<>();
		map.put("currentDate", date);
		map.put("room_no", room_no);
		List<Time> tlist = dao.timeList(map);
		String[] state = new String[24];
		for(int i = 0; i < tlist.size(); i++) {
			for(int j = tlist.get(i).getStart(); j <= tlist.get(i).getEnd() - 1; j++) {
				state[j] = tlist.get(i).getName();
			}
		}
		return state;
	}
	
	public int reservationInsert(ReservationDto data) {
		String st_time = data.getSt_time();
		String ed_time = data.getEd_time();
		String date = data.getDate();
		
		String start = date + " " + st_time + ":00:00.0";
		String end = date + " " + ed_time + ":00:00.0";

		Timestamp start_time = Timestamp.valueOf(start);
		Timestamp end_time = Timestamp.valueOf(end);
		data.setReservation_no(dao.getLastNo());
		data.setStart_time(start_time);
		data.setEnd_time(end_time);
		
		return dao.roomReservation(data);
	}
	
	public void cancel(int[] reservation_no) {
		for(int i = 0; i < reservation_no.length; i++) {
			dao.cancel(reservation_no[i]);
		}
	}
}
