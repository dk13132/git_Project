package mc.calendar.model;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import mc.calendar.service.Paging;

@Setter
@Getter
public class CalendarListModel {
	private int count; //전체 글 개수
	private List<CalendarDto> boardList; //현재페이지에서 보여줄 글들
	private int requestPage; //요청페이지번호
	private int totalPageCount; //전체 페이지 수
	private int startRow; //현재페이지의 첫번째 글 번호
	private Paging p; //페이징에 필요한 값
	
	public CalendarListModel() {
		this(new ArrayList<CalendarDto>(), 0, 0, 0, new Paging(),0);
	}
	
	public CalendarListModel(List<CalendarDto> boardList, int requestPage, int totalPageCount, int startRow, Paging p,int count) {
		super();
		this.boardList = boardList;
		this.requestPage = requestPage;
		this.totalPageCount = totalPageCount;
		this.startRow = startRow;
		this.p = p;
		this.count = count;
	
	}
}
