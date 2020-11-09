package mc.projectWork.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import mc.projectWork.model.ProjectWorkModel;
import mc.projectWork.model.Search;
import mc.projectWork.model.ProjectWorkDto;
import mc.projectWork.service.ProjectWorkService;

@Controller
public class ProjectWorkController {

	@Autowired
	ProjectWorkService service;

	@RequestMapping(value = "/wlist.do")
	public String list(ProjectWorkDto dto,
			@RequestParam(value = "p", defaultValue = "1") int pageNum,
			@RequestParam(value = "per", defaultValue = "20") int per, Model m,
			@RequestParam(value = "searchType", required = false) String searchType,
			@RequestParam(value = "keyword", required = false) String keyword) throws Exception {
		Search search = new Search();
		search.setSearchType(searchType);
		search.setKeyword(keyword);

		ProjectWorkModel list = service.listSearch(pageNum, per, searchType, keyword);	//留ㅽ띁�뿉�꽌 由ъ「�듃���엯�쓣 dto濡� �꽑�뼵�빐二쇨퀬, dto�뿉 �떞�븘�꽌 �븯�굹�뵫 戮묒븘�삤湲�
		int number = list.getCount() - (pageNum - 1) * per;
		
		m.addAttribute("employee_no", dto.getEmployee_no());
		m.addAttribute("name", dto.getName());
		m.addAttribute("list", list);
		m.addAttribute("searchType", searchType);
		m.addAttribute("keyword", keyword);
		m.addAttribute("number", number);
				
		List<Map<String, Object>> fileList = service.selectFileList(dto.getWork_no());
		m.addAttribute("file", fileList);
			
		return "projectWork/projectWorkSearch";
	}

	@RequestMapping(value = "/proWorkWrite.do")
	public String write(Model m, ProjectWorkDto dto, MultipartHttpServletRequest mpRequest) throws Exception{
		service.write(dto, mpRequest);
		return "redirect:wlist.do";
	}
	
	@RequestMapping(value = "/projectWorkWrite.do")
	public String projectWorkWrite(Model m) throws Exception{
		List<Map<String, Object>> list = service.getNameList();
		m.addAttribute("list", list);
		return "projectWork/projectWorkWrite";
	}
	
	@RequestMapping(value = "/projectWorkUpdate.do")
	public String projectWorkUpdate(int work_no, int p, Model m, ProjectWorkDto dto) throws Exception{
		//session.setAttribute("employee_no", 2);
		
		List<Map<String, Object>> fileList = service.selectFileList(dto.getWork_no());
	    m.addAttribute("file", fileList);
		List<Map<String, Object>> list = service.getNameList();
		m.addAttribute("list", list);
	      
		ProjectWorkDto dto2 = service.updateForm(work_no);
		m.addAttribute("article", dto2);
		m.addAttribute("pageNum", p);

		System.out.println("#### Cont1 : update");		
		return "projectWork/projectWorkUpdate";
	}
	
	@RequestMapping(value = "/proWorkUpdate.do", method = RequestMethod.POST)
	public String update(ProjectWorkDto dto, 
						@ModelAttribute("search") Search search, 
						RedirectAttributes rttr,
						 @RequestParam(value="fileNoDel[]") String[] files,
						 @RequestParam(value="fileNameDel[]") String[] fileNames,
						 MultipartHttpServletRequest mpRequest) throws Exception {

		service.update(dto, files, fileNames, mpRequest);
		rttr.addAttribute("searchType", search.getSearchType());
		rttr.addAttribute("keyword", search.getKeyword());

		return "redirect:wlist.do";
	}
	
	@RequestMapping(value = "/wcontent.do")
	public String content(@RequestParam(value = "p") int pageNum, int work_no, Model m, ProjectWorkDto dto) throws Exception {
		ProjectWorkDto dto2 = service.getContent(work_no);
		
		List<Map<String, Object>> fileList = service.selectFileList(dto.getWork_no());
		m.addAttribute("file", fileList);
		m.addAttribute("work_no", work_no);
		m.addAttribute("article", dto2);
		m.addAttribute("pageNum", pageNum);
		
		return "projectWork/projectWorkContent";
	}
	
	@RequestMapping(value="/proFileDown.do")
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception{
		Map<String, Object> resultMap = service.selectFileInfo(map);
		String storedFileName = (String) resultMap.get("stored_file_name");
		String fileName = (String) resultMap.get("file_name");
		
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\file\\"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\""+URLEncoder.encode(fileName, "UTF-8")+"\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
	
	@RequestMapping(value = "/proWorkDelete.do")
	public String deleteForm(@RequestParam(value ="work_no") int work_no) {
		service.delete(work_no);
		return "redirect:wlist.do"; 
	}
	
	@ResponseBody
	@RequestMapping(value = "/checkDelete.do")
	public void checkDelete(@RequestParam(value = "work_no") int work_no) throws Exception {
		service.delete(work_no);
	}

}