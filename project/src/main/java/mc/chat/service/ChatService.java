package mc.chat.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mc.chat.model.ChatDto;
import mc.chat.model.ChatListDto;
import mc.chat.model.Chat_participationDto;
import mc.chat.model.DeptDto;
import mc.chat.model.EmpDto;
import mc.chat.model.Employee_info;
import mc.chat.model.MessageDto;

@Service
public class ChatService {
	@Autowired
	ChatDao dao;

	public List<ChatListDto> chatList(int employee_no) {
		return dao.chatList(employee_no);
	}

	public List<DeptDto> deptList() {
		List<DeptDto> deptDto = dao.deptList();
		deptDto.remove(0);
		return deptDto;
	}

	public List<EmpDto> empList(int dept_no) {
		return dao.empList(dept_no);
	}

	public int addChat(ChatDto dto, int[] empSelect) {
		int updateCount = 0;
		int max = 1;
		if (dao.chatMaxNo() != null) {
			max = Integer.parseInt(dao.chatMaxNo());
		}
		dto.setChat_no(max);
		dao.insertChat(dto);
		int count = 1;
		if (dao.chat_participationMaxNo() != null) {
			count = Integer.parseInt(dao.chat_participationMaxNo());
		}
		String s = "";
		for (int i = 0; i < empSelect.length + 1; i++) {
			Chat_participationDto pdto = new Chat_participationDto();
			pdto.setParticipation_no(count + i);
			pdto.setChat_no(dto.getChat_no());
			if (i == empSelect.length) {
				pdto.setEmployee_no(dto.getEmployee_no());
			} else {
				pdto.setEmployee_no(empSelect[i]);
			}
			updateCount = dao.insertParticipation(pdto);

			if (i == empSelect.length) {
				s += dao.searchEmployeeName(dto.getEmployee_no());
			} else {
				s += dao.searchEmployeeName(empSelect[i]) + ", ";
			}
		}
		MessageDto mdto = new MessageDto();
		mdto.setChat_no(dto.getChat_no());
		mdto.setEmployee_no(0);
		mdto.setContents(":" + s + "님이 입장하였습니다.");
		autoInsertMessage(mdto);
		return updateCount;
	}

	public Map<String, Object> chat_invitation(int chat_no, int[] empSelect) {
		int updateCount = 0;
		int count = 1;
		if (dao.chat_participationMaxNo() != null) {
			count = Integer.parseInt(dao.chat_participationMaxNo());
		}
		String s = "";
		for (int i = 0; i < empSelect.length; i++) {
			Chat_participationDto pdto = new Chat_participationDto();
			pdto.setParticipation_no(count + i);
			pdto.setChat_no(chat_no);
			pdto.setEmployee_no(empSelect[i]);
			updateCount = dao.insertParticipation(pdto);
			if (i == empSelect.length - 1) {
				s += dao.searchEmployeeName(empSelect[i]);
			} else {
				s += dao.searchEmployeeName(empSelect[i]) + ", ";
			}
		}
		Map<String, Object> map = new HashMap<>();
		map.put("updateCount", updateCount);
		map.put("msg", s + "님이 입장하였습니다.");
		return map;
	}

	public void insertMessage(MessageDto dto) {
		int max = 1;
		if (dao.messageMaxNo() != null) {
			max = Integer.parseInt(dao.messageMaxNo());
		}
		dto.setMessage_no(max);
		dao.insertMessage(dto);
	}

	public List<MessageDto> selectMessageInfo(Map<String,Integer> map) {
		return dao.selectMessageInfo(map);
	}

	public List<EmpDto> participationInfo(int dept_no, int chat_no) {
		List<EmpDto> empList = dao.empList(dept_no);
		List<Chat_participationDto> participationList = dao.participationInfo(chat_no);

		for (int i = 0; i < empList.size(); i++) {
			for (int j = 0; j < participationList.size(); j++) {
				if (empList.get(i).getEmployee_no() == participationList.get(j).getEmployee_no()) {
					empList.remove(i);
				}
			}
		}
		return empList;
	}

	private void autoInsertMessage(MessageDto dto) {
		int max = 1;
		if (dao.messageMaxNo() != null) {
			max = Integer.parseInt(dao.messageMaxNo());
		}
		dto.setMessage_no(max);
		dao.insertMessage(dto);
	}
 
	public void exitChat_room(Map<String, Integer> map) {
		dao.exitChat_room(map);
	}
	
	public Map<Integer, List<Employee_info>> employeeInfo(int chat_no) {
		Map<Integer, List<Employee_info>> map = new HashMap<>();
		List<Employee_info> list = dao.employeeInfo(chat_no);
		map.put(dao.headCount(chat_no), list);
		return map;
	}
}
