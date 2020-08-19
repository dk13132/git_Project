package mc.chat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mc.chat.model.ChatDto;
import mc.chat.model.ChatListDto;
import mc.chat.model.Chat_participationDto;
import mc.chat.model.DeptDto;
import mc.chat.model.EmpDto;

@Service
public class ChatService {
	@Autowired
	ChatDao dao;
	
	public List<ChatListDto> chatList(int employee_no){
		return dao.chatList(employee_no);
	}
	
	public List<DeptDto> deptList(){
		return dao.deptList();
	}
	
	public List<EmpDto> empList(int dept_no){
		return dao.empList(dept_no);
	}
	
	public int addChat(ChatDto dto, int[] empSelect) {
		int updateCount = 0;
		dto.setChat_no(dao.chatMaxNo());
		dao.insertChat(dto);
		int count = dao.chat_participationMaxNo();
		for(int i = 0; i < empSelect.length + 1; i++) {
			Chat_participationDto pdto = new Chat_participationDto();
			pdto.setParticipation_no(count + i);
			pdto.setChat_no(dto.getChat_no());
			if(i == empSelect.length) {
				pdto.setEmployee_no(dto.getEmployee_no());
			} else {
				pdto.setEmployee_no(empSelect[i]);
			}
			updateCount = dao.insertParticipation(pdto);
		}
		return updateCount;
	}
}
