package mc.main.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.Setter;
@Repository
@Setter
public class MainDao {

		@Autowired
		SqlSession session;
		
		public List<Map<String,Object>> getBoard() {
			return session.selectList("login.notice");
		}
		
	
		
	
}
