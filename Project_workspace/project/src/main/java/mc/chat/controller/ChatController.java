package mc.chat.controller;

import java.util.List;

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
}
