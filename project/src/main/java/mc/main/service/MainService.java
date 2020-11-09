package mc.main.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
@Setter
public class MainService {
	
		@Autowired
		MainDao dao;
		
		public List<Map<String,Object>> getBoard() {
			return dao.getBoard();
		}
	

}
