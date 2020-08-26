package mc.admin.service;

public class Paging1 {

	int beginPageNumber;//첫번째 페이지 번호
	int endPageNumber;//마지막 페이지 번호
	int totalPageCount;//전체 페이지 수
	
	public Paging1() {}
	
	public Paging1(int beginPageNumber, int endPageNumber, int totalPageCount) {
		super();
		this.beginPageNumber = beginPageNumber;
		this.endPageNumber = endPageNumber;
		this.totalPageCount = totalPageCount;
	}

	public Paging1 paging1(int requestPage, int count, int per) {
		if (count == 0) {
			return new Paging1(0,0,0);
		}
		int pageCount = count / per;
		if (count % per > 0) {
			pageCount++;
		}
		int beginNumber = (requestPage - 1) / 10 * 10 + 1;
		int endNumber = beginNumber + 9;
		if(endNumber > pageCount) {
			endNumber = pageCount;
		}
		return new Paging1(beginNumber, endNumber, pageCount);
		
	}

	public int getBeginPageNumber() {
		return beginPageNumber;
	}

	public int getEndPageNumber() {
		return endPageNumber;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}
		
	
}
