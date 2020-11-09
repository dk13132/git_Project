package mc.projectWork.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import mc.projectWork.service.Paging;

@Setter
@Getter
@ToString
public class Search extends Paging{
	
	private String searchType;
	private String keyword;
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}	

	
}