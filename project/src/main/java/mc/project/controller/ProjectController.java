package mc.project.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import mc.project.model.ProjectDto;
import mc.project.model.ProjectModel;
import mc.project.service.ProjectService;
import mc.project.model.Search;

@Controller
public class ProjectController {

	@Autowired
	ProjectService service;

	@RequestMapping(value = "/projectSearch.do")
	public String proList(ProjectDto dto,
			@RequestParam(value = "p", defaultValue = "1") int pageNum,
			@RequestParam(value = "per", defaultValue = "5") int per, Model m,
			@RequestParam(value = "searchType", required = false) String searchType,
			@RequestParam(value = "keyword", required = false) String keyword) throws Exception {
		Search search = new Search();
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		
		ProjectModel list = service.listSearch(pageNum, per, searchType, keyword);
		int number = list.getCount() - (pageNum - 1) * per;
		

		m.addAttribute("employee_no", dto.getEmployee_no());
		m.addAttribute("name", dto.getName());
		m.addAttribute("list", list);
		m.addAttribute("searchType", searchType);
		m.addAttribute("keyword", keyword);
		m.addAttribute("number", number);

		return "project/projectSearch";
	}
	
	@RequestMapping(value = "/proWrite.do")
	public String proWrite(ProjectDto dto) throws Exception {
		service.write(dto);
		return "redirect:projectSearch.do";
	}
	
	@RequestMapping(value = "/projectWrite.do")
	public String writeFrom(Model m) throws Exception {
		List<Map<String, Object>> list = service.getNameList();
		m.addAttribute("list", list);
		return "project/projectWrite";
	} 

	
	@RequestMapping(value = "/projectUpdate.do")
	public String proUpdate(ProjectDto dto) {
		service.update(dto);
		return "redirect:projectSearch.do";
	}

	@RequestMapping(value = "/projectDelete.do")
	public String proDelete(int project_no) {
		service.delete(project_no);
		return "redirect:projectList.do";
	}
	
	@ResponseBody
	@RequestMapping(value = "/checkBoxDelete.do")
	public void checkBoxDelete(@RequestParam(value = "project_no") int project_no) throws Exception {
		service.delete(project_no);
	}
	
	public void setService(ProjectService service) {
		this.service = service;
	}

	/*	@GetMapping("/projectUpdate.do")
	public String updateForm(int project_no, int p, Model m) {
		ProjectDto dto = service.updateForm(project_no);
		m.addAttribute("article", dto);
		m.addAttribute("pageNum", p);
		return "project/projectUpdate";
	}*/
	
/*	@GetMapping("/projectDelete.do")
	public String deleteForm(@RequestParam("project_no") int project_no) {
		service.delete(project_no);
		return "redirect:projectList.do";
	}*/
	

}