package mc.project.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mc.project.model.ProjectDto;
import mc.project.model.ProjectModel;

@Service
public class ProjectService {

	@Autowired
	ProjectDao dao;

	// 1. 湲��벐湲�
	public void write(ProjectDto dto) {
		dao.write(dto);
	}	
	// 2. 湲��닔�젙
	public void update(ProjectDto dto) {
		dao.update(dto);
	}
	
	public ProjectDto updateForm(int project_no) {
		return dao.getContent(project_no);
	}
	
	// 3. 湲��씫湲�
	public ProjectDto getContent(int project_no) {
		return dao.getContent(project_no);
	}
	
	// 4. 湲��궘�젣
	public void delete(int project_no) {
		dao.delete(project_no);
	}
	
	// 7. 由ъ뒪�듃
	public ProjectModel list(int pageNum, int per) {
		int count = dao.count();
		if (count == 0) {                                                               
			return new ProjectModel();
		}
			
		int start = (pageNum - 1) * per;
		List<ProjectDto> list = dao.getList(start, per);
		Paging p = new Paging().paging(pageNum, count, per);
		return new ProjectModel(list, pageNum, p.totalPageCount, start, p, count);
		}
		
	// 8. 寃��깋
	public ProjectModel listSearch(int pageNum, int per, String searchType, String keyword) throws Exception {
		int count = dao.searchCount(searchType, keyword);
		if (count == 0) {
			return new ProjectModel();
		}
		int start = (pageNum - 1) * per;
		List<ProjectDto> list = dao.search(start, per, searchType, keyword);

		Paging p = new Paging().paging(pageNum, count, per);
		p.setSearchTypeKeyword(searchType, keyword);

		return new ProjectModel(list, pageNum, p.getTotalPageCount(), start, p, count);
	}
	
	//�씠由� 由ъ뒪�듃
	public List<Map<String, Object>> getNameList() throws Exception {
		List<Map<String, Object>> list = dao.getNameList();
		return list;
	}		
		
	public void setDao(ProjectDao dao) {
		this.dao = dao;
	}

}