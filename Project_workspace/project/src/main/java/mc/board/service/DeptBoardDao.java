package mc.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import mc.board.model.BoardDto;

public class DeptBoardDao extends SqlSessionDaoSupport{
	
	public List<BoardDto> getList(int start,int per,int type,int employee_no,String searchType, String keyword){ //시작번호, 개수
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("start",start);
		m.put("per",per);
		m.put("type",type);
		
		m.put("employee_no", employee_no);
		m.put("searchType", searchType);
		m.put("keyword", keyword);
		System.out.println("dao");
		return getSqlSession().selectList("deptBoard.deptList",m);
	}	
	
	public int searchCount(int type,String searchType, String keyword, int employee_no) throws Exception {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("type",type);
		m.put("searchType", searchType);
		m.put("keyword", keyword);
		m.put("employee_no", employee_no);
		System.out.println("daoCount");
		return getSqlSession().selectOne("deptBoard.count",m);
		
	}
	
	//content
	public BoardDto getContent(int board_no){
		return getSqlSession().selectOne("deptBoard.content",board_no);
	}
	
	//write
	public void insert(BoardDto dto) {
		getSqlSession().insert("deptBoard.write", dto);
	}
	
	public void update(BoardDto dto) {
		getSqlSession().update("deptBoard.update",dto);
	}
	
	public void delete(int board_no) {
		getSqlSession().delete("deptBoard.delete",board_no);
		
	}
	
	public void readCount(int board_no) {
		getSqlSession().update("deptBoard.readcount",board_no);
	}
	
	
	public int selectMax() {
		return getSqlSession().selectOne("deptBoard.max");
	}
	
	  public void insert_file(Map<String, Object> map) throws Exception {
	  getSqlSession().insert("deptBoard.fileWrite", map); }
	  
	  
	  public Map<String, Object> getFileContent(Map<String, Object> map) throws
	  Exception{ return getSqlSession().selectOne("deptBoard.fileContent", map); }
	  
	  // 첨부파일 조회 
	  public List<Map<String, Object>> selectFileList(int board_no) throws Exception { return
	  getSqlSession().selectList("deptBoard.selectFileList", board_no); }
	  
	  // 첨부파일 다운 
	  public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception { return
	  getSqlSession().selectOne("deptBoard.selectFileInfo", map); }
	  
	  public void updateFile(Map<String, Object> map) throws Exception {
	  getSqlSession().update("deptBoard.updateFile", map); }
	  
	  public void deleteFile(int file_no) {
	  getSqlSession().delete("deptBoard.deleteFile", file_no);
	  
	  }
	 
}
