package mc.myInfo.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mc.myInfo.Dto.MyInfoDto;
import mc.myInfo.Service.MyInfoService;

@Controller
public class MyInfoController {

	@Autowired
	private MyInfoService myInfoService;

	// 硫붿씤 > �궡 �젙蹂� �솗�씤
	@GetMapping("/conPw.do")
	public String goConPw(MyInfoDto dto) throws Exception {
		return "conPw";
	}

	// �궡 �젙蹂� �솗�씤 > �궡 �젙蹂� 議고쉶
	@PostMapping("/conPw.do")
	public String confirm(Model model, @ModelAttribute MyInfoDto dto) throws Exception {
		/*
		 * 濡쒓렇�씤 肄붾뱶 諛쏆쑝硫� �궗�슜�븷 寃�. 
		 * dto.setEmployee_no(Integer.parseInt((String)hs.getAttribute("employee_no")));
		 */
		
		System.out.println(dto.getEmployee_no()+ " " + dto.getPassword());
		MyInfoDto vDto = myInfoService.confirmPw(dto); 

		model.addAttribute("myInfo", vDto);

		int rsint;
		if (vDto == null) {
			rsint = 1;
			model.addAttribute("rsint", rsint);
			return "conPw"; // 鍮꾨�踰덊샇 �떎瑜� 寃쎌슦 媛숈� �럹�씠吏�.
		} else {
			return "myPage"; // 鍮꾨�踰덊샇 媛숈쓣 寃쎌슦 �젙蹂� 議고쉶 �럹�씠吏� �씠�룞
		}
	}

	// 鍮꾨�踰덊샇 �옱議고쉶
	@PostMapping("/reSltPw.do")
	public String reSltPw(Model model, @ModelAttribute MyInfoDto dto) throws Exception {
		dto.setEmployee_no(20100001); // dto�뿉 �젙蹂� �엫�쓽濡� �떞�쓬

		MyInfoDto vDto = myInfoService.sltInfo(dto);
		model.addAttribute("myInfo", vDto);

		return "udtPw";
	}

	// 鍮꾨�踰덊샇 蹂�寃�
	@ResponseBody
	@PostMapping("/udtPw.do")
	public Map<String, Object> udtPw(@ModelAttribute MyInfoDto dto) throws Exception {
		dto.setEmployee_no(20100001);
		Map<String, Object> resultMap = myInfoService.chgPw(dto);
		return resultMap;

	}

	// �궡 �젙蹂� �닔�젙
	@PostMapping("/myPage.do")
	public String updInfo(Model model, MultipartHttpServletRequest request, @ModelAttribute MyInfoDto dto)
			throws Exception {
		dto.setEmployee_no(20100001); // dto�뿉 �젙蹂� �엫�쓽濡� �떞�쓬

		myInfoService.udtInfo(dto, request);
		MyInfoDto vDto = myInfoService.sltInfo(dto);
		model.addAttribute("myInfo", vDto);

		return "myPage";
	}

}