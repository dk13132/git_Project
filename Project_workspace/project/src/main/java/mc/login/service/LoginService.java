package mc.login.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
@Setter
public class LoginService {
	@Autowired
	LoginDao dao;
	
	public Map<String, Object> login(String employee_no) {
		return dao.login(employee_no);
	}
}
