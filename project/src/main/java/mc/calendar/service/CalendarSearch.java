package mc.calendar.service;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class CalendarSearch extends Paging {
	private int type;
	private String searchType;
	private String keyword;
}
