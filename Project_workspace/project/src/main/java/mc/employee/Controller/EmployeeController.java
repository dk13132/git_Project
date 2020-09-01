package mc.employee.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;

import mc.employee.Dto.EmployeeDto;
import mc.employee.Service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	private EmployeeService employeeService;

	// �궗�썝 �젙蹂� 議고쉶
	@GetMapping("/sltEmp.do")
	public String sltEmp(Model model, @ModelAttribute EmployeeDto dto) throws Exception {

		List<Map<String, EmployeeDto>> list = employeeService.sltbxDno();
		List<Object> vDto = employeeService.sltEmp(dto);
		model.addAttribute("employee", vDto);
		model.addAttribute("department", list);
		return "sltEmp";
	}

	// �궗�썝 �젙蹂� 議고쉶 - �븘�꽣
	@ResponseBody
	@PostMapping("/sltFtEmp")
	public Map<String, Object> sltFtEmp(Model model, @ModelAttribute EmployeeDto dto) throws Exception {
		List<Map<String, EmployeeDto>> list = employeeService.sltbxDno();
		List<Object> vDto = employeeService.sltEmp(dto);

		Map<String, Object> map = new HashMap<>();
		map.put("department", list);
		map.put("employee", vDto);

		return map;
	}

	// �궗�썝�젙蹂� �긽�꽭 議고쉶
	@PostMapping("/sltDtlEmp.do")
	public Object sltDtlEmp(Model model, @ModelAttribute EmployeeDto dto) throws Exception {
		List<Map<String, EmployeeDto>> list = employeeService.sltbxDno();
		EmployeeDto vDto = employeeService.sltDtlEmp(dto);
		model.addAttribute("employee", vDto);
		model.addAttribute("department", list);

		return "sltDtlEmp";
	}

	// �궗�썝 �젙蹂� �닔�젙
	@PostMapping("/udtEmp.do")
	public String udtEmp(Model model, MultipartHttpServletRequest request, @ModelAttribute EmployeeDto dto)
			throws Exception {

		employeeService.udtEmp(dto, request);

		List<Map<String, EmployeeDto>> list = employeeService.sltbxDno();
		EmployeeDto vDto = employeeService.sltDtlEmp(dto);
		model.addAttribute("employee", vDto);
		model.addAttribute("department", list);

		return "sltDtlEmp";
	}

	// �궗�썝 �궘�젣
	@ResponseBody // ajax�벝 �븣 �뜥以섏빞 媛� jsp濡� 媛��졇媛�..
	@PostMapping("/dltEmp.do")
	public Map<String, Object> dltEmp(Model model, HttpSession hs, @ModelAttribute EmployeeDto dto) throws Exception {

		hs.setAttribute("employee_no", 15200110);
		hs.setAttribute("authority", 2);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		String errMsg = "";
		String errCode = "";
		System.out.println("#### 而⑦듃濡ㅻ윭");
		int cntatrt = employeeService.cntatrt(hs);
		if (cntatrt == 1) {
			employeeService.dltEmp(dto);
			errMsg = "�젙�긽�쟻�쑝濡� 蹂�寃쎈릺�뿀�뒿�땲�떎.";
			errCode = "1";
		} else {
			errMsg = "沅뚰븳�씠 �뾾�뒿�땲�떎.";
			errCode = "0";
		}
		resultMap.put("errMsg", errMsg);
		resultMap.put("errCode", errCode);
		// model.addAttribute("map", resultMap);
		return resultMap;
	}

	// �궗�썝 �벑濡�
	@PostMapping("/istEmp.do")
	public String istEmp(Model model, MultipartHttpServletRequest request, @ModelAttribute EmployeeDto dto)
			throws Exception {

		// �궗�썝�벑濡앺럹�씠吏�濡� 媛��꽌 �옉�꽦�븯寃뚮걫 泥섎━�븯�뒗寃� �븘�슂.

		employeeService.istEmp(dto);
		employeeService.istEmpPt(dto, request);

		// �궗�썝 �젙蹂� 由ъ뒪�듃 議고쉶�빐�꽌 肉뚮젮二쇨린

		List<Map<String, EmployeeDto>> list = employeeService.sltbxDno();
		List<Object> vDto = employeeService.sltEmp(dto);
		model.addAttribute("employee", vDto);
		model.addAttribute("department", list);
		return "sltEmp";
	}

	@PostMapping("/empInsert.do")
	public Object insertForm(Model model) throws Exception {
		List<Map<String, EmployeeDto>> map = employeeService.sltbxDno();
		model.addAttribute("department", map);
		return "empInsert";
	}

	@RequestMapping(value = "/deptInfo.do", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String deptInfo(@ModelAttribute EmployeeDto dto) {

		EmployeeDto vDto = employeeService.deptInfo(dto);

		Gson gson = new Gson();
		return gson.toJson(vDto);
	}
}
