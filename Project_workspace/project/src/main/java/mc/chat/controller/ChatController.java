package mc.chat.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import mc.chat.model.ChatDto;
import mc.chat.model.ChatListDto;
import mc.chat.model.DeptDto;
import mc.chat.model.EmpDto;
import mc.chat.model.Employee_info;
import mc.chat.model.MessageDto;
import mc.chat.service.ChatService;

@Controller
public class ChatController {
	
	@Autowired
	ChatService service;
	
	@RequestMapping("/chat_list.do")
	public ModelAndView chat_list(HttpSession session) {
		ModelAndView mav = new ModelAndView("chat_list");
		int employee_no = Integer.parseInt((String)session.getAttribute("mc_employee_no"));
		List<ChatListDto> list = service.chatList(employee_no);
		mav.addObject("list", list);
		return mav;
	}
	
	@RequestMapping("/chat_room.do")
	public ModelAndView chat_room(int chat_no, String chat_name) {
		ModelAndView mav = new ModelAndView("chat_room");
		mav.addObject("chat_no", chat_no);
		mav.addObject("chat_name", chat_name);
		return mav;
	}
	
	@GetMapping("/create_chat.do")
	public ModelAndView chat_createForm() {
		ModelAndView mav = new ModelAndView("create_chat");
		List<DeptDto> deptList = service.deptList();
		mav.addObject("deptList", deptList);
		return mav;
	}
	
	@RequestMapping(value = "/empList.do", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String empList(int dept_no) {
		List<EmpDto> empList = service.empList(dept_no);
		Gson json = new Gson();
		return json.toJson(empList); 
	}
	
	@PostMapping(value = "/create_chat.do", produces = "text/plain;charset=UTF-8")
	public ModelAndView chat_createPro(HttpSession session, String chat_name, int[] empSelect) {
		ModelAndView mav = new ModelAndView("create_chatPro");
		ChatDto dto = new ChatDto();
		dto.setChat_name(chat_name);
		dto.setEmployee_no(Integer.parseInt((String)session.getAttribute("mc_employee_no")));
		int updateCount = service.addChat(dto, empSelect);
		mav.addObject("count", updateCount);
		return mav;
	}
	
	@RequestMapping(value = "/messageInfo.do", produces="text/plane;charset=UTF-8")
	@ResponseBody
	public String messageInfo(int chat_no, int employee_no) {
		Map<String,Integer> map = new HashMap<>();
		map.put("chat_no", chat_no);
		map.put("employee_no", employee_no);
		List<MessageDto> messageList = service.selectMessageInfo(map);
		Gson json = new Gson();
		return json.toJson(messageList);
	}
	
	/*
	 * @GetMapping(value = "/chat_invitation.do" ,produces =
	 * "text/plain;charset=UTF-8")
	 * 
	 * @ResponseBody public String chat_invitationForm(int chat_no) { List<DeptDto>
	 * deptList = service.deptList(); Gson json = new Gson(); return
	 * json.toJson(deptList); }
	 */
	
	@GetMapping(value = "/chat_invitation.do" ,produces = "text/plain;charset=UTF-8")
	public ModelAndView chat_invitationForm(int chat_no) {
		ModelAndView mav = new ModelAndView("chat_invitation");
		List<DeptDto> deptList = service.deptList();
		mav.addObject("chat_no", chat_no);
		mav.addObject("deptList", deptList);
		return mav;
	}
	
	@PostMapping(value = "/chat_invitation.do", produces = "text/plain;charset=UTF-8")
	public ModelAndView chat_invitationPro(int chat_no, int[] empSelect) {
		ModelAndView mav = new ModelAndView("chat_invitationPro");
		Map<String, Object> map = service.chat_invitation(chat_no, empSelect);
		mav.addObject("count", map.get("updateCount"));
		mav.addObject("msg", map.get("msg"));
		return mav;
	}
	
	@RequestMapping(value = "/empInvitationList.do", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String empInvitationList(int dept_no, int chat_no) {
		List<EmpDto> empList = service.participationInfo(dept_no, chat_no);
		Gson json = new Gson(); 
		return json.toJson(empList); 
	}
	
	@RequestMapping(value = "/employeeInfo.do", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String employeeInfo(int chat_no) {
		Map<Integer, List<Employee_info>> map = service.employeeInfo(chat_no);
		Gson json = new Gson(); 
		return json.toJson(map);
	}
	
	@RequestMapping(value = "/exitChat.do")
	public String exitChat_room(int chat_no, int employee_no) {
		Map<String, Integer> map = new HashMap<>();
		map.put("chat_no", chat_no);
		map.put("employee_no",employee_no);
		service.exitChat_room(map);
		return "exit_chat";
	}
}
