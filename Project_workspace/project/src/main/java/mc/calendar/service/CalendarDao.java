package mc.calendar.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import mc.calendar.model.CalendarDto;

public class CalendarDao extends SqlSessionDaoSupport {
	
	public List<CalendarDto> getList(int employee_no, int start, int per) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("start", start);
		m.put("per", per); 
		m.put("employee_no", employee_no);
		return getSqlSession().selectList("calendar.calendarList", m);
	}
	
	public int count() {
		return getSqlSession().selectOne("calendar.count");
	}

	public List<CalendarDto> search(int employee_no, int start, int per,int type, String searchType, String keyword) throws Exception {
		HashMap<String, Object> m = new HashMap<String, Object>();

		m.put("start", start);  
		m.put("per", per);
		m.put("type", type);

		m.put("searchType", searchType);
		m.put("keyword", keyword);
		m.put("employee_no", employee_no);
		if(type == 0) {
			return getSqlSession().selectList("calendar.searchListNoType",m);
		}

		return getSqlSession().selectList("calendar.searchList", m);
	}

	public int searchCount(int type, String searchType, String keyword) throws Exception {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("type", type);
		m.put("searchType", searchType);
		m.put("keyword", keyword);
		
		if(type == 0) { 
			return getSqlSession().selectOne("calendar.noTypeSearchCount", m);
		}
		return getSqlSession().selectOne("calendar.searchCount", m);
	}

	// content
	public CalendarDto getContent(int calendar_no) {
		return getSqlSession().selectOne("calendar.content", calendar_no);
	}
	
		
	// write
	public void insert(CalendarDto dto) {
		getSqlSession().insert("calendar.write", dto);
	}

	
	
	public void update(CalendarDto dto) {
		getSqlSession().update("calendar.update", dto);
	}
	
	public void update_file(CalendarDto dto) {
		getSqlSession().update("calendar.fileUpdate",dto);
	}

	public void delete(int calendar_no) {
		getSqlSession().delete("calendar.delete", calendar_no);

	}

	public void readCount(int calendar_no) {
		getSqlSession().update("calendar.readcount", calendar_no);
	}

	
	public int selectMax() {
		return getSqlSession().selectOne("calendar.max");
	}

	
	
	public void insert_file(Map<String, Object> map) throws Exception {
		getSqlSession().insert("calendar.fileWrite", map);
	}
	
	
	public Map<String, Object> getFileContent(Map<String, Object> map) throws Exception{
		return getSqlSession().selectOne("calendar.fileContent", map);
	}
	
	public List<Map<String, Object>> selectFileList(int calendar_no) throws Exception {
		return getSqlSession().selectList("calendar.selectFileList", calendar_no);
	}

	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {		
		return getSqlSession().selectOne("calendar.selectFileInfo", map);
	}
	
	public void updateFile(Map<String, Object> map) throws Exception {
		getSqlSession().update("calendar.updateFile", map); 
	}
}
