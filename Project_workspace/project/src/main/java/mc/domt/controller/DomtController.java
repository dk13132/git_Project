package mc.domt.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import mc.domt.model.DomtApprovalDto;
import mc.domt.model.DomtAutoDto;
import mc.domt.model.DomtDto;
import mc.domt.model.Domt_P_ApprovalDto;
import mc.domt.model.EmployeeDto;
import mc.domt.model.domtListModel;
import mc.domt.service.DomtService;

@Controller
public class DomtController {

	@Autowired
	DomtService domtService;

	@RequestMapping(value = "/appdomt.do", method = RequestMethod.GET)
	public String appDomt_domtList(@RequestParam(value = "p", defaultValue = "1") int pageNum,
			@RequestParam(value = "per", defaultValue = "5") int per, //처음 페이지가 없을때를 위한 코드 
		Model model, HttpSession request) {
		// ▼ 리스트 내용
		String employee_no = (String) request.getAttribute("mc_employee_no");
//		List<DomtDto> list = domtService.appDomt_domt_listselect(employee_no);
//		model.addAttribute("domt_list", list);
//		List<DomtDto> list2 = domtService.appDomt_domt_listselect2(employee_no);
//		model.addAttribute("domt_list2", list2);
		
		// ▼ 페이징 처리 적용된 리스트
		domtListModel list3 = domtService.list(pageNum, per,employee_no);
		model.addAttribute("domt_list3", list3);
		int number = list3.getCount() - (pageNum - 1) * per;
		model.addAttribute("number", number);
		
		domtListModel list4 = domtService.list2(pageNum, per,employee_no);
		model.addAttribute("domt_list4", list4);
		int number2 = list4.getCount() - (pageNum - 1) * per;
		model.addAttribute("number2", number2);
		
		
		
		
		return "domtList";
	}

	@RequestMapping(value = "/domt_write_form.do", method = RequestMethod.GET)
	public String move() {
		return "domtWriteDataList";
	}

	@RequestMapping(value = "/domtpage/1.do", method = RequestMethod.GET)
	public String appDomtAuto(Model model2, HttpSession request) {
		String employee_no = (String) request.getAttribute("mc_employee_no");

		DomtAutoDto dadto = domtService.appDomt_domt_auto(employee_no);
		model2.addAttribute("employee_no", dadto.getEmployee_no());
		model2.addAttribute("dept_name", dadto.getDept_name());
		model2.addAttribute("name", dadto.getName());
		int domtcount = domtService.appDomt_domt_auto_Nemder();
		model2.addAttribute("document_no", domtcount);
		int appcount = domtService.insert_app_app_auto_Nemder();
		model2.addAttribute("approval_no", appcount);
		return "domtpage/1";
	}
	//승인완료 문서
	@RequestMapping(value = "/domt_imok_list.do", method = RequestMethod.GET)
	public String domtImoklist(Model model, HttpSession request) {
		String employee_no = (String) request.getAttribute("mc_employee_no");
		List<DomtDto> list3 = domtService.appDomt_domt_imok_list(employee_no);
		model.addAttribute("domt_list3", list3); // 20200826 추가후 오류가 등장함
		return "/domtImokList";
	}

	@RequestMapping(value = "/domtpage/appLineAdd.do", method = RequestMethod.GET)
	public String appLineAdd() {
		return "/appLineAddForm";
	}

	@RequestMapping(value = "/emplist_selectAdd.do", method = RequestMethod.GET)
	public String empListappLineAdd() {
		return "/appLineAddForm";
	}

	@RequestMapping(value = "/appLineAddForm_select_one.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public void deptList(HttpServletResponse resp) {
		List<EmployeeDto> list = domtService.appDomt_domt_employee_add_listselect();
		Gson json = new Gson();
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out;
		try {
			out = resp.getWriter();
			out.print(json.toJson(list));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/appLineAddForm_select_two.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public String nameList(EmployeeDto emdto, HttpSession request) {
		String employee_no = (String) request.getAttribute("mc_employee_no");
		emdto.setEmployee_no((Integer.parseInt(employee_no)));
		List<Map<String, Object>> list = domtService.appDomt_domt_employee_add_listselect_two(emdto);
		Gson json = new Gson();
		return json.toJson(list);
	}

	@RequestMapping(value = "/appLineAddForm_select_thr.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String empOne(int employee_no) throws Exception {
		EmployeeDto empOne = domtService.appDomt_domt_employee_add_listselect_thr(employee_no);
		Gson json = new Gson();
		return json.toJson(empOne);
	}

	@RequestMapping(value = "/insert_App_And_Domt.do", method = RequestMethod.POST)
	public String insert_App_And_Domt(int[] employee_no1, DomtDto domtdto, DomtApprovalDto domtapp) {
		System.out.println(domtdto.getDocument_no());
		domtdto.setEmployee_no(employee_no1[0]);
		domtService.insert_app_domt(domtdto); // 내용관련인서트
		domtService.insert_app_domt_app(domtapp, employee_no1);
		domtService.insert_app_domt_app_up(domtdto);
		return "redirect:/appdomt.do";
	}
	

	@RequestMapping(value = "/domtView.do", method = RequestMethod.GET)
	public String domtViewPage(Model model2, int document_no) {
		Domt_P_ApprovalDto dpadto1 = domtService.domtViewPage_domt(document_no);
		model2.addAttribute("document_no", dpadto1.getDocument_no());
		model2.addAttribute("employee_no", dpadto1.getEmployee_no());
		model2.addAttribute("subject", dpadto1.getSubject());
		model2.addAttribute("contents", dpadto1.getContents());
		model2.addAttribute("reg_date", dpadto1.getReg_date());
		model2.addAttribute("type", dpadto1.getType());
		model2.addAttribute("dept_name", dpadto1.getDept_name());
		model2.addAttribute("name", dpadto1.getName());
		List<Domt_P_ApprovalDto> list = domtService.domtViewPage_appline(document_no);
		model2.addAttribute("domt_appline", list);
		return "/domtView";
	}
	
	@RequestMapping(value = "/domtViewApp.do", method = RequestMethod.GET)
	public String domtViewAppPage(Model model2, int document_no) {
		Domt_P_ApprovalDto dpadto1 = domtService.domtViewPage_domt(document_no);
		model2.addAttribute("document_no", dpadto1.getDocument_no());
		model2.addAttribute("employee_no", dpadto1.getEmployee_no());
		model2.addAttribute("subject", dpadto1.getSubject());
		model2.addAttribute("contents", dpadto1.getContents());
		model2.addAttribute("reg_date", dpadto1.getReg_date());
		model2.addAttribute("type", dpadto1.getType());
		model2.addAttribute("dept_name", dpadto1.getDept_name());
		model2.addAttribute("name", dpadto1.getName());
		List<Domt_P_ApprovalDto> list = domtService.domtViewPage_appline(document_no);
		model2.addAttribute("domt_appline", list);
		
		
		return "/domtViewApp";
	}

	@RequestMapping(value = "/imokok.do", method = RequestMethod.GET)
	public String imok(HttpSession request, DomtApprovalDto domt_app_no) {
		String employee_no = (String) request.getAttribute("mc_employee_no");
		domt_app_no.setEmployee_no((Integer.parseInt(employee_no)));
		domtService.imok(domt_app_no);
		return "redirect:/appdomt.do";
	}

	@RequestMapping(value = "/imnono.do", method = RequestMethod.GET)
	public String imno(HttpSession request, DomtApprovalDto domt_app_no) {
		String employee_no = (String) request.getAttribute("mc_employee_no");
		domt_app_no.setEmployee_no((Integer.parseInt(employee_no)));
		domtService.imno(domt_app_no);
		return "redirect:/appdomt.do";
	}

}
