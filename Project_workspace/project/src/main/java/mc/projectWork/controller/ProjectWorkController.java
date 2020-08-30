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

	// 게시물 목록 + 페이징 추가 + 검색 + 파일
	@RequestMapping(value = "/list.do")
	public String list(ProjectWorkDto dto,
			@RequestParam(value = "p", defaultValue = "1") int pageNum,
			@RequestParam(value = "per", defaultValue = "20") int per, Model m,
			@RequestParam(value = "searchType", required = false) String searchType,
			@RequestParam(value = "keyword", required = false) String keyword) throws Exception {
		Search search = new Search();
		search.setSearchType(searchType);
		search.setKeyword(keyword);

		ProjectWorkModel list = service.listSearch(pageNum, per, searchType, keyword);	//매퍼에서 리졸트타입을 dto로 선언해주고, dto에 담아서 하나씩 뽑아오기
		int number = list.getCount() - (pageNum - 1) * per;
		
		m.addAttribute("employee_no", dto.getEmployee_no());
		m.addAttribute("name", dto.getName());
		m.addAttribute("list", list);	//list에 담긴 데이터를 "list"라는 이름으로 담는다.
		m.addAttribute("searchType", searchType);
		m.addAttribute("keyword", keyword);
		m.addAttribute("number", number);
				
		//파일 selectFileList에 파라미터값(게시글 조회한 번호)을 넣어주고 Map타입의 List타입 fileList에 넣어줍니다.
		//model.addAttribute를 이용하여 fileList를 file이라는 이름으로 jsp에 값을 보낼준비를 합니다.
		List<Map<String, Object>> fileList = service.selectFileList(dto.getWork_no());
		m.addAttribute("file", fileList);
			
		return "projectWork/projectWorkSearch";
	}

	//글 작성쪽에 첨부파일의 파라미터값을 받을수 있는 MultipartHttpServlertRequest mpRequest를 추가,
	@RequestMapping(value = "/write.do")
	public String write(Model m, ProjectWorkDto dto, MultipartHttpServletRequest mpRequest) throws Exception{
		service.write(dto, mpRequest);//서비스를 실행할때에 받는 파라미터(mpRequest)도 추가해줍니다.
		return "redirect:list.do";
	}
	
	@RequestMapping(value = "/projectWorkWrite.do")
	public String projectWorkWrite(Model m) throws Exception{
		//담당자 리스트 - 모델 추가
		List<Map<String, Object>> list = service.getNameList();
		m.addAttribute("list", list);
		return "projectWork/projectWorkWrite";
	}
	
	// 게시판 수정
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
	
	@RequestMapping(value = "/update.do", method = RequestMethod.POST)
	public String update(ProjectWorkDto dto, 
						@ModelAttribute("search") Search search, 
						RedirectAttributes rttr,
						 @RequestParam(value="fileNoDel[]") String[] files,
						 @RequestParam(value="fileNameDel[]") String[] fileNames,
						 MultipartHttpServletRequest mpRequest) throws Exception {

		service.update(dto, files, fileNames, mpRequest);
		rttr.addAttribute("searchType", search.getSearchType());
		rttr.addAttribute("keyword", search.getKeyword());

		System.out.println("#### Cont2 : update");
		
		return "redirect:list.do";
	}
	
	@RequestMapping(value = "/content.do")
	public String content(@RequestParam(value = "p") int pageNum, int work_no, Model m, ProjectWorkDto dto) throws Exception {
		ProjectWorkDto dto2 = service.getContent(work_no);
		
		List<Map<String, Object>> fileList = service.selectFileList(dto.getWork_no());
		m.addAttribute("file", fileList);
		m.addAttribute("work_no", work_no);
		m.addAttribute("article", dto2);
		m.addAttribute("pageNum", pageNum);
		
		return "projectWork/projectWorkContent";
	}
	
	//10. 첨부 파일 다운
	@RequestMapping(value="/fileDown.do")
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception{
		Map<String, Object> resultMap = service.selectFileInfo(map);
		String storedFileName = (String) resultMap.get("stored_file_name");
		String fileName = (String) resultMap.get("file_name");
		
		// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\file\\"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\""+URLEncoder.encode(fileName, "UTF-8")+"\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
	
	@RequestMapping(value = "/delete.do")
	public String deleteForm(@RequestParam(value ="work_no") int work_no) {
		service.delete(work_no);
		return "redirect:list.do"; 
	}
	
	// 체크박스 선택, 삭제
	@ResponseBody
	@RequestMapping(value = "/checkDelete.do")
	public void checkDelete(@RequestParam(value = "work_no") int work_no) throws Exception {
		service.delete(work_no);
	}

}
