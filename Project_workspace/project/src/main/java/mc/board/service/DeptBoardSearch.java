package mc.board.service;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class DeptBoardSearch extends Paging {
	private String searchType;
	private String keyword;
}
