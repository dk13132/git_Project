package mc.admin.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;

import mc.admin.model.AnnualVo;
import mc.admin.model.AttenDto;
import mc.admin.model.AttenListModel;
import mc.admin.model.DeptDto;
import mc.admin.model.DeptInfo;
import mc.admin.model.DeptListModel;
import mc.admin.model.emName;
import mc.admin.service.DeptService;

@Controller
public class DeptController {

	@Autowired
	DeptService dept;
	
	@GetMapping("/list.do")
	public String list(@RequestParam(value = "p", defaultValue = "1") int pageNum,
			@RequestParam(value = "per", defaultValue = "5") int per, Model m) {
		// System.out.println("per::"+per);
		DeptListModel list = dept.list(pageNum, per);
		m.addAttribute("list", list);
		int number = list.getCount() - (pageNum - 1) * per;
		m.addAttribute("number", number);
		return "dept/deptInfo";
	} 
	
	@RequestMapping(value = "/delete.do", method = RequestMethod.GET)
	public String delete(@RequestParam("delete_dept") int[] dept_no, ModelMap modelMap)
	throws Exception{
		for(int delete : dept_no ) {
			System.out.println("�궗�슜�옄 �궘�젣 = "+dept_no);
			int count = dept.deleteUser(delete);
		}
		return "redirect:/list.do";
	}
	
	@RequestMapping("/insert.do")
	public String insert(DeptDto d) throws Exception {
		
		System.out.println(d);
		dept.insertDept(d);
		
		return "redirect:/list.do";
	}
	
	@RequestMapping(value = "emps.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String empList(String dept_name) throws Exception {
		
		System.out.println("dept_name::"+dept_name);
		
		List<Map<String,Object>> list = dept.getDept(dept_name);
		Gson json = new Gson(); 		
		return json.toJson(list);
	}
	
	@RequestMapping(value = "/updateForm.do")
	public String updateForm(@RequestParam("delete_dept") int dept_no, Model m) {
			
		DeptDto user = dept.updateUser(dept_no);
		m.addAttribute("user", user);
		
		return "dept/updateForm";
	}
	
	@RequestMapping("/updateDn.do")
	public String update(DeptDto d) {
		
		dept.update(d);
		
		//return "redirect:/list.do";
		return "redirect:/list.do";
	}
	
	@RequestMapping("/authority.do")
	public String  authority() {
				
		
		return "dept/authority";
	}
	
	@RequestMapping(value = "/depts.do", method = RequestMethod.POST)
	public void deptList(HttpServletResponse resp) throws Exception {
		
		List<DeptDto> list = dept.selectDepts();
		Gson json = new Gson(); 
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(json.toJson(list));
	}
	
	
	@RequestMapping(value = "position.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public String positionList(int dept_no) throws Exception {
		
		//System.out.println("dept_no::"+dept_no);
		
		List<Map<String,Object>> list = dept.selectpositions(dept_no);
		Gson json = new Gson(); 		
		return json.toJson(list);
	}
	
	@RequestMapping(value = "name.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public String nameList(DeptInfo e) throws Exception {
		
		//System.out.println("name List="+e);
		
		List<Map<String,Object>> list = dept.selectNames(e);
		Gson json = new Gson(); 		
		return json.toJson(list);
	}
	
	@RequestMapping(value = "employee_no.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public String noList(DeptInfo e) throws Exception {
				
		List<Map<String,Object>> list = dept.selectNo(e);
		Gson json = new Gson(); 		
		return json.toJson(list);
	}	

	@RequestMapping(value = "pushList.do", method = RequestMethod.GET, produces = "application/json; charset=utf8")
	@ResponseBody
	public String pushList(DeptInfo info) throws Exception {
		
		
		//System.out.println("push:: "+info);
		List<Map<String,Object>> list = dept.selectPush(info);
		Gson json = new Gson(); 		
		return json.toJson(list);
	}
	
	
	@RequestMapping(value = "update_auto.do", method = RequestMethod.POST)
	@ResponseBody
	public String update_auto(emName e) {
		
		System.out.println(e);
		
		int x  = dept.update_auto(e);
		
		Gson json = new Gson(); 		
		return json.toJson(x);
	}
	
	@RequestMapping("/attendance.do")
	public String attendance() {
				
		return "dept/attendance";
	}
	
	
	@GetMapping("/attenList.do")
	public String attenList(@RequestParam(value = "p", defaultValue = "1") int pageNum, 
			@RequestParam(value = "per", defaultValue = "10") int per, @DateTimeFormat(pattern="yyyy-MM-dd")Date start_time, Model m) {
		// System.out.println("per::"+per);
		
		System.out.println(start_time);
		
		AttenListModel list = dept.attenList(pageNum, per,start_time);
		
		m.addAttribute("list", list);
		m.addAttribute("start_time", start_time);
		
		int number = list.getCount() - (pageNum - 1) * per;
		
		m.addAttribute("number", number);
		
		return "dept/attendance1";
	
	}
	
	@RequestMapping(value = "/updateAttr.do")
	public String attrForm(int attendance_no, Model m) {
			
		AttenDto attr = dept.attrForm(attendance_no);
		
		m.addAttribute("attr", attr);
		
		return "dept/updateAttr";
	}
	
	
	
	@RequestMapping(value = "attrUpdate.do")//�긽�깭媛믪쑝濡� �뿰李� 怨꾩궛
	public String updateAttr(AttenDto e, Model m) {
		
		dept.updateAttr(e);
		
		double calAnn = dept.getAnnual(e);
		
		AnnualVo an = new AnnualVo();
		
		an.setAttendance_no(e.getAttendance_no());
		an.setAnnual_leave(calAnn);
		
		dept.setAnnual(an);
		
		SimpleDateFormat format;
		
		format = new SimpleDateFormat("yyyy-MM-dd");
		//format.format(e.getStart_time());
		
		System.out.println("�쟾�떖媛�::"+format.format(e.getStart_time()));
		
		m.addAttribute("start_time", format.format(e.getStart_time()));
		
		return "redirect:/attenList.do";
	}
	
	
	@GetMapping("/deptAttr.do")
	public String deptAttr(@RequestParam(value = "p", defaultValue = "1") int pageNum, 
			@RequestParam(value = "per", defaultValue = "10") int per, @DateTimeFormat(pattern="yyyy-MM-dd")AttenDto a, Model m) {
		// System.out.println("per::"+per);
		
		System.out.println(a.getStart_time());
		AttenListModel list = dept.attenList1(pageNum, per, a);
		String dept_name = dept.getDeName(a.getDept_no());
		
		m.addAttribute("list", list);
		m.addAttribute("start_time", a.getStart_time());
		m.addAttribute("dept_no",a.getDept_no());
		m.addAttribute("dept_name",dept_name);
			
		int number = list.getCount() - (pageNum - 1) * per;
		
		m.addAttribute("number", number);
		
		return "dept/attendance1";
		/* return "redirect:/deptAttr.do"; */
	
	}
	
	@RequestMapping(value = "update_auto1.do", method = RequestMethod.POST)
	@ResponseBody
	public String update_auto1(@RequestBody List<emName> emName) {
		
		int x = 0;
		
		for (emName name : emName) {
			
			x = dept.update_auto(name);
		
		}
	
		Gson json = new Gson(); 		
		return json.toJson(x);	

	}	
	
	

	//@RequestMapping("/list.do")
	//public String board(Model model) {
		//model.addAttribute("list",dept.selectDepts());
		//return "dept/deptInfo";
	//}
	
	
	
	/*
	 * @RequestMapping("/list.do") public ModelAndView list() throws Exception{
	 * List<DeptDto> list = dept.selectDepts(); ModelAndView mav = new
	 * ModelAndView(); mav.setViewName("dept/deptInfo"); mav.addObject("list",list);
	 * return mav; }
	 */
	 
}