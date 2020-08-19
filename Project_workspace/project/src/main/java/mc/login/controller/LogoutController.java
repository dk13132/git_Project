package mc.login.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LogoutController {
	@RequestMapping("/logout.do")
	 public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:login.do";
	}
}
