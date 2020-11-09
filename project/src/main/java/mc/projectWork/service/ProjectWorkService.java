package mc.projectWork.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mc.projectWork.Util.FileUtils;
import mc.projectWork.model.ProjectWorkDto;
import mc.projectWork.model.ProjectWorkModel;

@Service
public class ProjectWorkService {

	@Autowired
	ProjectWorkDao dao;

	@Resource(name = "fileUtils") // @Resource로 FileUtils를 사용할수 있게 추가..
	private FileUtils fileUtils;

	// 1. 글쓰기 + 파일 첨부!
	// Service에 첨부파일 파라미터를 받을 MultipartHttpServletRequest도 추가
	// Map타입의 List타입으로 list라는 이름에 fileUtils.parseInsertFileInfo(boardVO,
	// mpRequest);를 받아옴
	public void write(ProjectWorkDto dto, MultipartHttpServletRequest mpRequest) throws Exception {
		dto.setEnd_time(new Timestamp(System.currentTimeMillis()));
		int work_no = dao.write(dto);
		dto.setWork_no(work_no);
		
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(dto, mpRequest);
		int size = list.size(); // for문을 써서 list의 size만큼 넣어주는 이유는 나중에 여러개의 첨부파일을 등록하기 위해서
		for (int i = 0; i < size; i++) {
			dao.insertFile(list.get(i));
		}
	}

	public void update(ProjectWorkDto dto, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest)
			throws Exception {

		dao.update(dto);// 게시물을 업데이트하는 쿼리

		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(dto, files, fileNames, mpRequest); // 파일 업데이트할 값들을 list에 담습니다.
		Map<String, Object> tempMap = null;
		int size = list.size();
		for (int i = 0; i < size; i++) { // fileUtils.parseUpdateFileInfo()결과의 size만큼 for문
			tempMap = list.get(i);
			if (tempMap.get("del_ch").equals("Y")) { // tempMap에 list.get(i)를 담고 if문을 이용하여 tempMap에서 del_ch를 꺼내와서 값이Y와 같으면
				dao.insertFile(tempMap);
			} else {
				dao.updateFile(tempMap);
			}
		}
		System.out.println("##### Service : update" + dto);
	}

	// 2. 글수정
	public ProjectWorkDto updateForm(int work_no) {
		return dao.getContent(work_no);
	}

	// 3. 글읽기
	public ProjectWorkDto getContent(int work_no) {
		return dao.getContent(work_no);
	}

	// 4. 글삭제
	public void delete(int work_no) {
		dao.delete(work_no);
	}

	// 8. 검색해서 담기
	public ProjectWorkModel listSearch(int pageNum, int per, String searchType, String keyword) throws Exception {
		int count = dao.searchCount(searchType, keyword);
		if (count == 0) {
			return new ProjectWorkModel();
		}
		int start = (pageNum - 1) * per;
		List<ProjectWorkDto> list = dao.search(start, per, searchType, keyword);

		Paging p = new Paging().paging(pageNum, count, per);
		p.setSearchTypeKeyword(searchType, keyword); // p.setSearchTypeKeyword(searchType, keyword);

		return new ProjectWorkModel(list, pageNum, p.getTotalPageCount(), start, p, count);
	}

	// 9. 첨부 파일 조회
	public List<Map<String, Object>> selectFileList(int work_no) throws Exception {
		return dao.selectFileList(work_no);
	}

	// 10. 첨부 파일 다운
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return dao.selectFileInfo(map);
	}

	//이름 리스트
	public List<Map<String, Object>> getNameList() throws Exception {
		List<Map<String, Object>> list = dao.getNameList();
		return list;
	}
	
	public void setDao(ProjectWorkDao dao) {
		this.dao = dao;
	}

}