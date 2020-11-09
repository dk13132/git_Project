package mc.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import mc.project.model.ProjectDto;

public class ProjectDao extends SqlSessionDaoSupport {

	// 1. 글쓰기
	public void write(ProjectDto dto) {
		getSqlSession().insert("ProjectMapper.write", dto);
	}
	
	// 2. 글수정
	public void update(ProjectDto dto) {
		getSqlSession().update("ProjectMapper.update", dto);
	}

	// 3. 글 읽기
	public ProjectDto getContent(int project_no) {
		return getSqlSession().selectOne("ProjectMapper.readOne", project_no);
	}

	// 4. 글삭제
	public void delete(int project_no) {
		getSqlSession().update("ProjectMapper.delete", project_no);
	}
			
	// 5. 마지막 게시글 번호 가져오기
	public int selectMax() {
		return getSqlSession().selectOne("ProjectMapper.max");
	}
		
	// 6. 글 개수
	public int count() {
		return getSqlSession().selectOne("ProjectMapper.count");
	}

	// 7. 프로젝트 가져오기
	public List<ProjectDto> getList(int start, int per) {
		Map<String, Integer> m = new HashMap<String, Integer>();
		m.put("start", start);
		m.put("per", per);
		return getSqlSession().selectList("ProjectMapper.list", m);
	}
	// 8. 검색했을 때 프로젝트 가져오기.
	public List<ProjectDto> search(int start, int per, String searchType, String keyword) throws Exception {
		HashMap<String, Object> m = new HashMap<String, Object>();

		m.put("start", start);
		m.put("per", per);
		m.put("searchType", searchType);
		m.put("keyword", keyword);

		return getSqlSession().selectList("ProjectMapper.getBoardList", m);
	}
	// 8. 검색했을 때 프로젝트 가져오기.
	public int searchCount(String searchType, String keyword) throws Exception {
		HashMap<String, Object> m = new HashMap<String, Object>();

		m.put("searchType", searchType);
		m.put("keyword", keyword);

		return getSqlSession().selectOne("ProjectMapper.getBoardListCnt", m);
	}
	
	//이름 리스트 가져오기
	public List<Map<String, Object>> getNameList() {
		return getSqlSession().selectList("ProjectMapper.getNameList");
	}
	
	// 참여자 인원수 가져오기
	public int getParticipationCount() {
		return getSqlSession().selectOne("ProjectMapper.participationCount");
	}
	
}
