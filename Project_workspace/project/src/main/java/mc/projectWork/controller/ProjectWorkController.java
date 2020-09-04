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

	// 寃뚯떆臾� 紐⑸줉 + �럹�씠吏� 異붽� + 寃��깋 + �뙆�씪
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
		m.addAttribute("list", list);	//list�뿉 �떞湲� �뜲�씠�꽣瑜� "list"�씪�뒗 �씠由꾩쑝濡� �떞�뒗�떎.
		m.addAttribute("searchType", searchType);
		m.addAttribute("keyword", keyword);
		m.addAttribute("number", number);
				
		//�뙆�씪 selectFileList�뿉 �뙆�씪誘명꽣媛�(寃뚯떆湲� 議고쉶�븳 踰덊샇)�쓣 �꽔�뼱二쇨퀬 Map���엯�쓽 List���엯 fileList�뿉 �꽔�뼱以띾땲�떎.
		//model.addAttribute瑜� �씠�슜�븯�뿬 fileList瑜� file�씠�씪�뒗 �씠由꾩쑝濡� jsp�뿉 媛믪쓣 蹂대궪以�鍮꾨�� �빀�땲�떎.
		List<Map<String, Object>> fileList = service.selectFileList(dto.getWork_no());
		m.addAttribute("file", fileList);
			
		return "projectWork/projectWorkSearch";
	}

	//湲� �옉�꽦履쎌뿉 泥⑤��뙆�씪�쓽 �뙆�씪誘명꽣媛믪쓣 諛쏆쓣�닔 �엳�뒗 MultipartHttpServlertRequest mpRequest瑜� 異붽�,
	@RequestMapping(value = "/write.do")
	public String write(Model m, ProjectWorkDto dto, MultipartHttpServletRequest mpRequest) throws Exception{
		service.write(dto, mpRequest);//�꽌鍮꾩뒪瑜� �떎�뻾�븷�븣�뿉 諛쏅뒗 �뙆�씪誘명꽣(mpRequest)�룄 異붽��빐以띾땲�떎.
		return "redirect:list.do";
	}
	
	@RequestMapping(value = "/projectWorkWrite.do")
	public String projectWorkWrite(Model m) throws Exception{
		//�떞�떦�옄 由ъ뒪�듃 - 紐⑤뜽 異붽�
		List<Map<String, Object>> list = service.getNameList();
		m.addAttribute("list", list);
		return "projectWork/projectWorkWrite";
	}
	
	// 寃뚯떆�뙋 �닔�젙
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
	
	@RequestMapping(value="/fileDown.do")
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
	
	@RequestMapping(value = "/delete.do")
	public String deleteForm(@RequestParam(value ="work_no") int work_no) {
		service.delete(work_no);
		return "redirect:list.do"; 
	}
	
	// 泥댄겕諛뺤뒪 �꽑�깮, �궘�젣
	@ResponseBody
	@RequestMapping(value = "/checkDelete.do")
	public void checkDelete(@RequestParam(value = "work_no") int work_no) throws Exception {
		service.delete(work_no);
	}

}
