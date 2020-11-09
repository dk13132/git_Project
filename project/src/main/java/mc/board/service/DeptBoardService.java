package mc.board.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.Setter;
import mc.board.model.BoardDto;
import mc.board.model.BoardListModel;
import mc.board.util.DeptBoardFileUtils;


@Service
public class DeptBoardService {

	@Resource(name = "DeptBoardFileUtils")
	private DeptBoardFileUtils fileUtils;

	@Autowired
	@Setter
	private DeptBoardDao dao;

	public BoardListModel list(int pageNum, int per, int type, int employee_no, String searchType, String keyword)
			throws Exception {
		int count = dao.searchCount(type, searchType, keyword, employee_no);
		if (count == 0) {
			return new BoardListModel();
		}

		int start = (pageNum - 1) * per;
		List<BoardDto> list = dao.getList(start, per, type, employee_no, searchType, keyword);

		Paging p = new Paging().paging(pageNum, count, per);
		p.setSearchTypeKeyword(searchType, keyword);

		System.out.println("서비스");
		return new BoardListModel(list, pageNum, p.totalPageCount, start, p, count);
	}

	public BoardDto getContent(int board_no) {
		dao.readCount(board_no);
		return dao.getContent(board_no);
	}

	public void insert(BoardDto dto, MultipartHttpServletRequest mpRequest) throws Exception {
		dto.setReg_date(new Timestamp(System.currentTimeMillis()));
		dao.insert(dto);

		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(dto, mpRequest);
		int size = list.size();
		for (int i = 0; i < size; i++) {
			dao.insert_file(list.get(i));
		}

	}

	// 첨부파일 조회
	public List<Map<String, Object>> selectFileList(int board_no) throws Exception {
		return dao.selectFileList(board_no);
	}

	// 첨부파일 다운
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return dao.selectFileInfo(map);
	}

	public void update(BoardDto dto, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest)
			throws Exception {
		dao.update(dto);

		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(dto, files, fileNames, mpRequest);
		Map<String, Object> tempMap = null;
		int size = list.size();
		for (int i = 0; i < size; i++) {
			tempMap = list.get(i);
			if (tempMap.get("del_gb").equals("N")) {
				dao.insert_file(tempMap);
			} else {
				dao.updateFile(tempMap);
			}
		}

	}

	public BoardDto updateForm(int board_no) {
		return dao.getContent(board_no);
	}

	public void delete(int board_no) {
		dao.delete(board_no);

	}

}
