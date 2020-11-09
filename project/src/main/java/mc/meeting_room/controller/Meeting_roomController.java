package mc.meeting_room.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import mc.meeting_room.model.Meeting_roomDto;
import mc.meeting_room.model.MyMeeting_room;
import mc.meeting_room.model.ReservationDto;
import mc.meeting_room.service.Meeting_roomService;

@Controller
public class Meeting_roomController {
	@Autowired
	Meeting_roomService service;
	
	@RequestMapping("/meeting_room.do")
	public ModelAndView meeting_roomForm(Date date, HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView("meeting_roomForm");
		List<MyMeeting_room> list = service.myroomList(Integer.parseInt((String)session.getAttribute("mc_employee_no")));
		mav.addObject("list", list);
		return mav;
	}
	
	@GetMapping(value = "/reservation.do", produces = "text/plain;charset=UTF-8")
	public String reservationForm() {
		return "reservation";
	}
	
	@PostMapping(value = "/reservation.do", produces = "text/plain;charset=UTF-8")
	public ModelAndView reservationPro(ReservationDto data, HttpSession session) {
		ModelAndView mav = new ModelAndView("reservationPro");
		data.setEmployee_no(Integer.parseInt((String)session.getAttribute("mc_employee_no")));
		int check = service.reservationInsert(data);
		mav.addObject("check", check);
		return mav;
	}
	
	@RequestMapping(value= "/meeting_roomList.do", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String roomList(String name) {
		List<Meeting_roomDto> r_list = service.roomList();
		Gson json = new Gson();
		return json.toJson(r_list); 
	}
	
	@RequestMapping(value= "/reservationInfo.do", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String reservationInfo(@DateTimeFormat(pattern="yyyy-MM-dd") Date date) {
		Map<String, String[]> result = service.roomList(date);
		Gson json = new Gson();
		return json.toJson(result);
	}
	
	@RequestMapping(value= "/reservationInfoOne.do", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String reservationInfoOne(@DateTimeFormat(pattern="yyyy-MM-dd")Date date, int room_no) {
		String[] result = service.roomListOne(date, room_no);
		Gson json = new Gson();
		return json.toJson(result);
	}
	
	@RequestMapping("/reservationCancel.do")
	public String reservationCancel(int[] reservation_no) {
		service.cancel(reservation_no);
		return "redirect:meeting_room.do";
	}
}
