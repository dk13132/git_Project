package mc.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import mc.board.model.BoardDto;

public class BoardDao extends SqlSessionDaoSupport {

	public List<BoardDto> search(int start, int per,int type, String searchType, String keyword) throws Exception {
		HashMap<String, Object> m = new HashMap<String, Object>();

		m.put("start", start);
		m.put("per", per);
		m.put("type",type);

		m.put("searchType", searchType);
		m.put("keyword", keyword);
		return getSqlSession().selectList("board.list", m);
	}
	public int searchCount(String searchType, String keyword,int type) throws Exception {
		HashMap<String, Object> m = new HashMap<String, Object>();

		m.put("searchType", searchType);
		m.put("keyword", keyword);
		m.put("type",type);
		return getSqlSession().selectOne("board.count",m);

	}

	// content
	public BoardDto getContent(int board_no) {
		return getSqlSession().selectOne("board.content", board_no);
	}

	// write
	public void insert(BoardDto dto) {
		getSqlSession().insert("board.write", dto);
	}

	public void update(BoardDto dto) {
		getSqlSession().update("board.update", dto);
	}

	public void delete(int board_no) {
		getSqlSession().delete("board.delete", board_no);

	}

	public int readCount(int board_no) {
		return getSqlSession().update("board.readcount", board_no);
	}

	public int selectMax() {
		return getSqlSession().selectOne("board.max");
	}
	
	
	public void insert_file(Map<String, Object> map) throws Exception {
		getSqlSession().insert("board.fileWrite", map);
	}
	
	
	public Map<String, Object> getFileContent(Map<String, Object> map) throws Exception{
		return getSqlSession().selectOne("board.fileContent", map);
	}
	
	// 첨부파일 조회
	public List<Map<String, Object>> selectFileList(int board_no) throws Exception {
		return getSqlSession().selectList("board.selectFileList", board_no);
	}
	
	// 첨부파일 다운
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {		
		return getSqlSession().selectOne("board.selectFileInfo", map);
	}
	
	public void updateFile(Map<String, Object> map) throws Exception {
		getSqlSession().update("board.updateFile", map); 
	}
	
	public void deleteFile(int file_no) {
		getSqlSession().delete("board.deleteFile", file_no);

	}

	
}
