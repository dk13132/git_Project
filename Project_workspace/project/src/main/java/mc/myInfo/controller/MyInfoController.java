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

   // 메인 > 내 정보 확인
   @GetMapping("/conPw.do")
   public String goConPw(MyInfoDto dto) throws Exception {
      return "conPw";
   }

   // 내 정보 확인 > 내 정보 조회
   @PostMapping("/conPw.do")
   public String confirm(Model model,HttpSession hs, @ModelAttribute MyInfoDto dto) throws Exception {
      
       dto.setEmployee_no(Integer.parseInt((String)hs.getAttribute("mc_employee_no")));
       
      
      MyInfoDto vDto = myInfoService.confirmPw(dto);

      model.addAttribute("myInfo", vDto);

      int rsint;
      if (vDto == null) {
         rsint = 1;
         model.addAttribute("rsint", rsint);
         return "conPw"; // 비밀번호 다를 경우 같은 페이지.
      } else {
         return "myPage"; // 비밀번호 같을 경우 정보 조회 페이지 이동
      }
   }

   // 비밀번호 재조회
   @PostMapping("/reSltPw.do")
   public String reSltPw(Model model,HttpSession hs, @ModelAttribute MyInfoDto dto) throws Exception {
      
      dto.setEmployee_no(Integer.parseInt((String)hs.getAttribute("mc_employee_no")));

      MyInfoDto vDto = myInfoService.sltInfo(dto);
      model.addAttribute("myInfo", vDto);

      return "udtPw";
   }

   // 비밀번호 변경
   @ResponseBody
   @PostMapping("/udtPw.do")
   public Map<String, Object> udtPw(HttpSession hs, @ModelAttribute MyInfoDto dto) throws Exception {
      dto.setEmployee_no(Integer.parseInt((String)hs.getAttribute("mc_employee_no")));
      Map<String, Object> resultMap = myInfoService.chgPw(dto);
      return resultMap;

   }

   // 내 정보 수정
   @PostMapping("/myPage.do")
   public String updInfo(Model model,HttpSession hs, MultipartHttpServletRequest request, @ModelAttribute MyInfoDto dto)
         throws Exception {
      dto.setEmployee_no(Integer.parseInt((String)hs.getAttribute("mc_employee_no")));

      myInfoService.udtInfo(dto, request);
      MyInfoDto vDto = myInfoService.sltInfo(dto);
      model.addAttribute("myInfo", vDto);

      return "myPage";
   }

}