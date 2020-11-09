package mc.board.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mc.board.model.BoardDto;
import mc.board.model.BoardListModel;
import mc.board.service.BoardSearch;
import mc.board.service.BoardService;

@Controller
public class BoardController {
	@Autowired
	BoardService service;

	@RequestMapping(value = "/blist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String list(@RequestParam(value = "p", defaultValue = "1") int pageNum,
			@RequestParam(value = "per", defaultValue = "10") int per,
			@RequestParam(value = "type", defaultValue = "1") int type, Model m,
			@RequestParam(value = "searchType", required = false) String searchType,
			@RequestParam(value = "keyword", required = false) String keyword) throws Exception {
		BoardSearch search = new BoardSearch();
		search.setSearchType(searchType);
		search.setKeyword(keyword);

		BoardListModel list = service.list(pageNum, per, type, searchType, keyword);
		int number = list.getCount() - (pageNum - 1) * per;
		m.addAttribute("list", list);
		m.addAttribute("searchType", searchType);
		m.addAttribute("keyword", keyword);
		m.addAttribute("number", number);
		

		return "board/boardList";
	}

	@RequestMapping(value = "/content.do", method = RequestMethod.GET)
	public String content(@RequestParam(value = "p") int pageNum, int board_no, BoardDto dto, Model m, HttpSession session) throws Exception{
		
		List<Map<String, Object>> fileList = service.selectFileList(dto.getBoard_no());
		m.addAttribute("file", fileList);
		
		BoardDto dto2 = service.getContent(board_no);
		m.addAttribute("board", dto2);
		m.addAttribute("pageNum", pageNum);
		return "board/boardContent";
	}

	@RequestMapping(value = "/write.do", method = RequestMethod.GET)
	public String writeForm(@ModelAttribute("dto") BoardDto dto, HttpSession session) {
		return "board/boardWrite";
	}

	@RequestMapping(value = "/write2.do", method = RequestMethod.POST)
	public String write(BoardDto dto, MultipartHttpServletRequest mpRequest) throws Exception  {
		service.insert(dto, mpRequest);
		return "redirect:/blist.do";
	}

	@RequestMapping(value = "/update.do", method = RequestMethod.GET)
	public String updateForm(int board_no, int p, Model m, BoardDto dto, HttpSession session) throws Exception{
		
		List<Map<String, Object>> fileList = service.selectFileList(dto.getBoard_no());
		m.addAttribute("file", fileList);
		
		BoardDto dto2 = service.updateForm(board_no);
		m.addAttribute("board", dto2);
		m.addAttribute("pageNum", p);
		return "board/boardUpdate";
	}

	@RequestMapping(value = "/update2.do", method = RequestMethod.POST)
	public String update(BoardDto dto, 
			@RequestParam(value="fileNoDel[]") String[] files,
			 @RequestParam(value="fileNameDel[]") String[] fileNames,
			 MultipartHttpServletRequest mpRequest) throws Exception  {
		service.update(dto, files, fileNames, mpRequest);
		return "redirect:/blist.do";
	}

	@RequestMapping(value = "/bdelete.do", method = RequestMethod.GET)
	public String delete(int board_no, int p, Model m) throws Exception{
		m.addAttribute("board_no", board_no);
		m.addAttribute("pageNum", p);
		service.delete(board_no);
	
			 
		return "redirect:/blist.do";
	}
	
	@ResponseBody
	@RequestMapping(value = "/BoardDelete.do", method = RequestMethod.POST)
	public void deleteBoard(@RequestParam(value = "board_no")int board_no, Model m) {
	  System.out.println(board_no);
	  service.delete(board_no);
	}
	
	
	
	//�뙆�씪 �떎�슫
		@RequestMapping(value="BoardFileDown.do")
		public void BoardFileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception{
			System.out.println("file_no : " + map.get("file_no"));
			Map<String, Object> resultMap = service.selectFileInfo(map);
			String storedFileName = (String) resultMap.get("stored_file_name");
			String originalFileName = (String) resultMap.get("file_name");
			
			// �뙆�씪�쓣 ���옣�뻽�뜕 �쐞移섏뿉�꽌 泥⑤��뙆�씪�쓣 �씫�뼱 byte[]�삎�떇�쑝濡� 蹂��솚�븳�떎.
			byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("D:\\board\\"+storedFileName));
			
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition", "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
			
		}

	public void setService(BoardService service) {
		this.service = service;
	}

}
