package mc.calendar.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mc.calendar.model.CalendarDto;
import mc.calendar.model.CalendarListModel;
import mc.calendar.service.CalendarSearch;
import mc.calendar.service.CalendarService;

@Controller
public class CalendarController {

	@Autowired
	CalendarService service; 

	@RequestMapping(value = "/calendar.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String listSearch(@RequestParam(value = "p", defaultValue = "1") int pageNum,
			@RequestParam(value = "per", defaultValue = "10") int per,
			@RequestParam(value = "type", defaultValue = "0", required = false) int type, Model m,
			@RequestParam(value = "searchType", required = false) String searchType,
			@RequestParam(value = "keyword", required = false) String keyword,
			HttpSession session) throws Exception {
		
		
		CalendarSearch search = new CalendarSearch();
		CalendarListModel list;
		search.setType(type);
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		int employee_no = Integer.parseInt((String)session.getAttribute("mc_employee_no"));
		
		if(type == 0 && keyword == null || type == 0 && keyword.equals("")) {
			list = service.list(employee_no, pageNum, per);
		} else {
			list = service.listSearch(employee_no, pageNum, per, type, searchType, keyword);
		}
		
		int number = list.getCount() - (pageNum - 1) * per;
		m.addAttribute("list", list);
		m.addAttribute("searchType", searchType);
		m.addAttribute("keyword", keyword);
		m.addAttribute("number", number);
		m.addAttribute("type", type);
		return "calendar/calendar";
	}

	@RequestMapping(value = "/calendarContent.do", method = RequestMethod.GET)
	public String content(@RequestParam(value = "p") int pageNum, int calendar_no,CalendarDto dto, Model m, HttpSession session) throws Exception{

		List<Map<String, Object>> fileList = service.selectFileList(dto.getCalendar_no());
		m.addAttribute("file", fileList);
		
		CalendarDto dto2 = service.getContent(calendar_no);
		
		m.addAttribute("calendar", dto2);
		m.addAttribute("pageNum", pageNum);
		
		return "calendar/calendarContent";
	}

	@RequestMapping(value = "/calendarWrite.do", method = RequestMethod.GET)
	public String writeForm(@ModelAttribute("dto") CalendarDto dto, HttpSession session) {
		return "calendar/calendarWrite";
	}

	@RequestMapping(value = "/calendarWrite2.do", method = RequestMethod.POST)
	public String write(CalendarDto dto, MultipartHttpServletRequest mpRequest) throws Exception {
		System.out.println(dto.getType());
		System.out.println(dto.getFile_name());
		System.out.println(dto.getFile_path());

		service.insert(dto, mpRequest);
		return "calendar/calendarReload";
	}

	@RequestMapping(value = "/calendarUpdate.do", method = RequestMethod.GET)
	public String updateForm(CalendarDto dto, int calendar_no, int p, Model m, HttpSession session) throws Exception{
		List<Map<String, Object>> fileList = service.selectFileList(dto.getCalendar_no());
		m.addAttribute("file", fileList);
		
		CalendarDto dto2 = service.updateForm(calendar_no);
		m.addAttribute("calendar", dto2);
		m.addAttribute("pageNum", p);
		
		return "calendar/calendarUpdate";
	}

	@RequestMapping(value = "/calendarUpdate2.do")
	public String update(CalendarDto dto, 
			@RequestParam(value="fileNoDel[]") String[] files,
			 @RequestParam(value="fileNameDel[]") String[] fileNames,		 
			 MultipartHttpServletRequest mpRequest) throws Exception {
		System.out.println(dto.getType());
		service.update(dto, files, fileNames, mpRequest);
		
		return "calendar/calendarReload";
	}

	@RequestMapping("/calendarDelete.do")
	public String delete(int calendar_no, int p, Model m) {
		m.addAttribute("calendar_no", calendar_no);
		m.addAttribute("pageNum", p);
		service.delete(calendar_no);

		return "calendar/calendarReload"; 
	}

	public void setService(CalendarService service) {
		this.service = service;
	}
	
	@RequestMapping(value="/cfileDown.do")
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception{
		Map<String, Object> resultMap = service.selectFileInfo(map);
		String storedFileName = (String) resultMap.get("stored_file_name");
		String originalFileName = (String) resultMap.get("file_name");
		
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("D:\\upload\\"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
		
	}
	
	@RequestMapping(value = "/calendarMonth.do", method = RequestMethod.GET)
	public String calendar(CalendarDto dto){
		
		//service.insert(dto);
		return "calendar/calendar";
	}
	
	
	
}