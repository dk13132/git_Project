package mc.domt.model;

import java.util.ArrayList;
import java.util.List;

import mc.domt.service.Paging;

public class domtListModel {
	
	private int count;//전체 글 수
	private List<DomtDto> boardList;//현재 페이지에서 보여줄 글
	private int requestPage;//요청 페이지 번호
	private int totalPageCount;//전체 페이지 수
	private int startRow;//현재 페이지의 첫번째 글 번호
	private Paging p;
	
	
	public domtListModel() {
		this(new ArrayList<DomtDto>(), 0, 0, 0, new Paging(),0);	
	}
	
	public domtListModel(List<DomtDto> boardList, int requestPage, int totalPageCount, int startRow, Paging p,int count) {
		super();
		this.boardList = boardList;
		this.requestPage = requestPage;
		this.totalPageCount = totalPageCount;
		this.startRow = startRow;
		this.p = p;
		this.count = count;
	
	}
	public List<DomtDto> getBoardList() {
		return boardList;
	}
	public void setBoardList(List<DomtDto> boardList) {
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

	public void setCount(int count) {
		this.count = count;
	}

	public int getCount() {
		return count;
	}

	
	
	
}