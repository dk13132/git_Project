package mc.projectWork.model;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import mc.projectWork.service.Paging;

@Getter
@Setter
public class ProjectWorkModel {
	private int count; //전체 글 수 
	private List<ProjectWorkDto> boardList;//현재 페이지에서 보여줄 글들
	private int requestPage;//요청 페이지 번호
	private int totalPageCount;//전체 페이지 수
	private int startRow;//현재 페이지의 첫번째 글 번호
	private Paging p;
	
	public ProjectWorkModel() {
		this(new ArrayList<ProjectWorkDto>(), 0, 0, 0, new Paging(),0);	
	}
	
	public ProjectWorkModel(List<ProjectWorkDto> boardList, int requestPage, int totalPageCount, int startRow, Paging p,int count) {
		super();
		
		this.boardList = boardList;
		this.requestPage = requestPage;
		this.totalPageCount = totalPageCount;
		this.startRow = startRow;
		this.p = p;
		this.count = count;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public List<ProjectWorkDto> getBoardList() {
		return boardList;
	}

	public void setBoardList(List<ProjectWorkDto> boardList) {
		this.boardList = boardList;
	}

	public int getRequestPage() {
		return requestPage;
	}

	public void setRequestPage(int requestPage) {
		this.requestPage = requestPage;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public Paging getP() {
		return p;
	}

	public void setP(Paging p) {
		this.p = p;
	}
	
	
}
