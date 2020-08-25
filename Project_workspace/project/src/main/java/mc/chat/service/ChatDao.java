package mc.chat.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mc.chat.model.ChatDto;
import mc.chat.model.ChatListDto;
import mc.chat.model.Chat_participationDto;
import mc.chat.model.DeptDto;
import mc.chat.model.EmpDto;

@Repository
public class ChatDao {
	@Autowired
	SqlSession session;//a
	
	public List<ChatListDto> chatList(int employee_no){
		return session.selectList("chat.chat_list", employee_no);
	}
	
	public List<DeptDto> deptList(){
		return session.selectList("chat.selectDept");
	}
	
	public List<EmpDto> empList(int dept_no){
		return session.selectList("chat.selectEmp", dept_no);
	}
	
	public int chatMaxNo() {
		return session.selectOne("chat.chatMaxNo");
	}
	
	public int chat_participationMaxNo() {
		return session.selectOne("chat.participationMaxNo");
	}
	
	public int insertChat(ChatDto dto) {
		return session.insert("chat.chatInsert",dto);
	}
	
	public int insertParticipation(Chat_participationDto dto) {
		return session.insert("chat.participationInsert", dto);
	}
}
