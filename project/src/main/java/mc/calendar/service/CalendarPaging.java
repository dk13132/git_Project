package mc.calendar.service;

public class CalendarPaging { //10개씩 보여주는 페이지

	int beginPageNumber; //첫번재 페이지 번호
	int endPageNumber; //마지막 페이지 번호
	int totalPageCount; //전체 페이지 개수
	
	public CalendarPaging() {}
	
	public CalendarPaging(int beginPageNumber, int endPageNumber, int totalPageCount) {
		super();
		this.beginPageNumber = beginPageNumber;
		this.endPageNumber = endPageNumber;
		this.totalPageCount = totalPageCount;
	}

	public CalendarPaging paging(int requestPage, int count, int per) {
		if (count == 0) {
			return new CalendarPaging(0,0,0);
		}
		int pageCount = count / per;
		if (count % per > 0) {
			pageCount++;
		}
		int beginNumber = (requestPage - 1) / 10 * 10 + 1;
		int endNumber = beginNumber + 9; //10
		if(endNumber > pageCount) {
			endNumber = pageCount;
		}
		return new CalendarPaging(beginNumber, endNumber, pageCount);
		
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
