package mc.calendar.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.Setter;
import mc.calendar.model.CalendarDto;
import mc.calendar.model.CalendarListModel;
import mc.calendar.util.CalendarFileUtils;

@Service
public class CalendarService {

	@Resource(name = "CalendarFileUtils")
	private CalendarFileUtils fileUtils;

	@Autowired
	@Setter
	private CalendarDao dao;

	public CalendarListModel list(int employee_no, int pageNum, int per) {
		int count = dao.count();
		if (count == 0) {
			return new CalendarListModel();
		}

		int start = (pageNum - 1) * per;
		List<CalendarDto> list = dao.getList(employee_no, start, per);

		Paging p = new Paging().paging(pageNum, count, per);

		return new CalendarListModel(list, pageNum, p.totalPageCount, start, p, count);
	}

	public CalendarListModel listSearch(int employee_no, int pageNum, int per, int type, String searchType, String keyword)
			throws Exception {
		int count = dao.searchCount(type, searchType, keyword);

		if (count == 0) {
			return new CalendarListModel();
		}
		int start = (pageNum - 1) * per;
		List<CalendarDto> list = dao.search(employee_no, start, per, type, searchType, keyword);

		Paging p = new Paging().paging(pageNum, count, per);
		p.setSearchTypeKeyword(type, searchType, keyword); // p.setSearchTypeKeyword(searchType, keyword);

		return new CalendarListModel(list, pageNum, p.getTotalPageCount(), start, p, count);
	}

	public CalendarDto getContent(int calendar_no) {
		return dao.getContent(calendar_no);
	}

	public void insert(CalendarDto dto, MultipartHttpServletRequest mpRequest) throws Exception {
		dao.insert(dto); 
		// dao.insert_file(dto);

		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(dto, mpRequest);
		int size = list.size();
		for (int i = 0; i < size; i++) {
			dao.insert_file(list.get(i));
		}
	}

	public CalendarDto updateForm(int calendar_no) {
		return dao.getContent(calendar_no);
	}

	public void delete(int calendar_no) {
		dao.delete(calendar_no);
	}

	public List<Map<String, Object>> selectFileList(int calendar_no) throws Exception {
		return dao.selectFileList(calendar_no);
	}

	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return dao.selectFileInfo(map);
	}

	public void update(CalendarDto dto, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest)
			throws Exception {

		dao.update(dto);

		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(dto, files, fileNames, mpRequest);
		Map<String, Object> tempMap = null;
		int size = list.size();
		for (int i = 0; i < size; i++) {
			tempMap = list.get(i);
			if (tempMap.get("del_gb").equals("N")) {
				dao.insert_file(tempMap);
			} else {
				dao.updateFile(tempMap);
			}
		}
		
		
	}
}
