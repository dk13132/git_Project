package mc.projectWork.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import mc.projectWork.model.ProjectWorkDto;

public class ProjectWorkDao extends SqlSessionDaoSupport {

	// 1. 글쓰기
	public int write(ProjectWorkDto dto) {
		getSqlSession().insert("ProjectWorkMapper.write", dto);
		return dto.getWork_no();
	}

	// 2. 글수정
	public void update(ProjectWorkDto dto) {
		getSqlSession().update("ProjectWorkMapper.update", dto);
	}

	// 3. 글 읽기
	public ProjectWorkDto getContent(int work_no) {
		return getSqlSession().selectOne("ProjectWorkMapper.readOne", work_no);
	}

	// 4. 글삭제
	public void delete(int work_no) {
		getSqlSession().update("ProjectWorkMapper.delete", work_no);
	}
	
	
	// 5. 마지막 게시글 번호 가져오기
	public int selectMax() {
		return getSqlSession().selectOne("ProjectWorkMapper.max");
	}

	// 6. 글 개수
	public int count() {
		return getSqlSession().selectOne("ProjectWorkMapper.count");
	}

	// 7. 일감 게시판 끊어서 가져오기
	public List<ProjectWorkDto> getList(int start, int per) {
		Map<String, Integer> m = new HashMap<String, Integer>();
		m.put("start", start);
		m.put("per", per);
		return getSqlSession().selectList("ProjectWorkMapper.list", m);
	}
	
	// 8. 파일 첨부
	public void insertFile(Map<String, Object> map) throws Exception{
		getSqlSession().insert("ProjectWorkMapper.insertFile", map);	
	}
	
	// 9. 파일 조회
	//파라미터는 work_no로 보냄 타입을 List형식으로 한 이유는 나중에 여러개의 파일을 등록할 수 있도록 하기 위함
	public List<Map<String, Object>> selectFileList(int work_no) throws Exception{
		return getSqlSession().selectList("ProjectWorkMapper.selectFileList", work_no);
	}
	
	// 10. 파일 다운
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return getSqlSession().selectOne("ProjectWorkMapper.selectFileInfo", map);
	}
	
	// 11. 파일 업로드
	public void updateFile(Map<String, Object> map) throws Exception {
		System.out.println("##### Dao : update" + map);
		getSqlSession().update("ProjectWorkMapper.updateFile", map);
	}
	
	
	//이름 리스트
	public List<Map<String, Object>> getNameList() {
		return getSqlSession().selectList("ProjectWorkMapper.getNameList");
	}

	
			
	public List<ProjectWorkDto> search(int start, int per, String searchType, String keyword) throws Exception {
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("start", start);
		data.put("per", per);
		data.put("searchType", searchType);
		data.put("keyword", keyword);

		return getSqlSession().selectList("ProjectWorkMapper.getBoardList", data);
	}

	public int searchCount(String searchType, String keyword) throws Exception {
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("searchType", searchType);
		data.put("keyword", keyword);

		return getSqlSession().selectOne("ProjectWorkMapper.getBoardListCnt", data);
	}	
}
