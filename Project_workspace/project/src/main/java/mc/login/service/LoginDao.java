package mc.login.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.Setter;

@Repository
@Setter
public class LoginDao {
	@Autowired
	SqlSession session;
	
	public Map<String, Object> login(String employee_no) {
		return session.selectOne("login.login", employee_no);
	}
}
