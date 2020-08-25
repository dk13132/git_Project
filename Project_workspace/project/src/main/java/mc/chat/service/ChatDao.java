package mc.chat.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mc.chat.model.ChatDto;
import mc.chat.model.ChatListDto;
import mc.chat.model.Chat_participationDto;
import mc.chat.model.DeptDto;
import mc.chat.model.EmpDto;
import mc.chat.model.Employee_info;
import mc.chat.model.MessageDto;

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
	
	public String chatMaxNo() {
		return session.selectOne("chat.chatMaxNo");
	}
	
	public String chat_participationMaxNo() {
		return session.selectOne("chat.participationMaxNo");
	}
	
	public int insertChat(ChatDto dto) {
		return session.insert("chat.chatInsert",dto);
	}
	
	public int insertParticipation(Chat_participationDto dto) {
		return session.insert("chat.participationInsert", dto);
	}
	
	public String messageMaxNo() {
		return session.selectOne("chat.lastMessageNo");
	}
	
	public int insertMessage(MessageDto dto) { 
		return session.insert("chat.messageInsert", dto);
	}
	
	public List<MessageDto> selectMessageInfo(Map<String,Integer> map){
		return session.selectList("chat.messageInfo", map);
	}
	
	public List<Chat_participationDto> participationInfo(int chat_no){
		return session.selectList("chat.participationInfo", chat_no);
	}
	
	public String searchEmployeeName(int employee_no) {
		return session.selectOne("chat.searchEmployeeName", employee_no); 
	}
	
	public void exitChat_room(Map<String, Integer> map) {
		session.delete("chat.exitChat_room", map);
	}
	
	public int headCount(int chat_no) {
		return session.selectOne("chat.headCount", chat_no);
	}
	
	public List<Employee_info> employeeInfo(int chat_no){
		return session.selectList("chat.employeeInfo", chat_no);
	}
}
