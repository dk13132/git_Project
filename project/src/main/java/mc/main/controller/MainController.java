package mc.main.controller;

import java.io.PrintWriter;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.google.gson.Gson;

import mc.main.service.MainService;


@Controller
public class MainController {
	
	@Autowired
	MainService service;
	
	@RequestMapping(value = "notice.do", method = RequestMethod.POST)
	public void noticeList(HttpServletResponse resp) throws Exception {
		
		List<Map<String,Object>> list = service.getBoard();
		
		Gson json = new Gson();
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(json.toJson(list));
	}
	
	@RequestMapping("/test.do")
	public String returnList() throws Exception {
		
		return "test";
	}
	
}