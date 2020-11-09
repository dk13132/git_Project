package mc.domt.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import mc.domt.model.DomtApprovalDto;
import mc.domt.model.DomtAutoDto;
import mc.domt.model.DomtDto;
import mc.domt.model.Domt_P_ApprovalDto;
import mc.domt.model.EmployeeDto;

public class DomtDao extends SqlSessionDaoSupport {

//	public List<DomtDto> appDomt_domt_listselect(String employee_no) {
//		return getSqlSession().selectList("appDomtSQL_text.appDomt_domt_listselect",employee_no);
//	}
//	public List<DomtDto> appDomt_domt_listselect2(String employee_no) {
//		return getSqlSession().selectList("appDomtSQL_text.appDomt_domt_listselect2",employee_no);
//	}
	public List<DomtDto> appDomt_domt_imok_list(String employee_no) {
		return getSqlSession().selectList("appDomtSQL_text.appDomt_domt_imok_list",employee_no);
	}
	
	
	
	//게시판의 총 글 수
	public int count(String employee_no) {
		return getSqlSession().selectOne("appDomtSQL_text.count",employee_no);
	}
	//게시판 페이징처리
	public List<DomtDto> getList(int start,int per,String employee_no) {
		Map<String, Object> m = new HashMap<String, Object>(); //왜 해시맵에 담았을까?
		m.put("start",start); //가져올 대상
		m.put("per",per); //가져올 롤의 수
		m.put("employee_no",employee_no);
		return getSqlSession().selectList("appDomtSQL_text.list",m);
	}
	//게시판의 총 글 수2
	public int count2(String employee_no) {
		return getSqlSession().selectOne("appDomtSQL_text.count2",employee_no);
	}
	//게시판 페이징처리2
	public List<DomtDto> getList2(int start,int per,String employee_no) {
		Map<String, Object> m = new HashMap<String, Object>(); //왜 해시맵에 담았을까?
		m.put("start",start); //가져올 대상
		m.put("per",per); //가져올 롤의 수
		m.put("employee_no",employee_no);
		return getSqlSession().selectList("appDomtSQL_text.list2",m);
	}
	
	

	public List<EmployeeDto> appDomt_domt_employee_add_listselect() {
		return getSqlSession().selectList("appDomtSQL_text.appDomt_domt_employee_add_listselect");
	}

	public List<Map<String, Object>> appDomt_domt_employee_add_listselect_two(EmployeeDto emdto) {
		return getSqlSession().selectList("appDomtSQL_text.appDomt_domt_employee_add_listselect_two", emdto);
	}

	public EmployeeDto appDomt_domt_employee_add_listselect_thr(int employee_no) {
		return getSqlSession().selectOne("appDomtSQL_text.appDomt_domt_employee_add_listselect_thr", employee_no);
	}

	public DomtAutoDto appDomt_domt_auto(String employee_no ) {
		return getSqlSession().selectOne("appDomtSQL_text.appDomt_domt_auto",employee_no);
	}

	public int appDomt_domt_auto_Nemder() {
		return getSqlSession().selectOne("appDomtSQL_text.appDomt_domt_auto_Nemder");
	}

	public int insert_app_app_auto_Nemder() {
		return getSqlSession().selectOne("appDomtSQL_text.insert_app_app_auto_Nemder");
	}

	public int insert_app_domt(DomtDto domtdto) {
		return getSqlSession().insert("appDomtSQL_text.insert_app_domt", domtdto);
	}

	public int insert_app_domt_app(DomtApprovalDto domtapp) {
		int i = 0;
		i += getSqlSession().insert("appDomtSQL_text.insert_app_domt_app",domtapp);
		return i;
	}
	//업뎃
	public void insert_app_domt_app_up (DomtDto domtdto) {
		getSqlSession().update("appDomtSQL_text.insert_app_domt_app_up",domtdto);
	}
	
	public Domt_P_ApprovalDto domtViewPage_domt (int document_no) {
		return getSqlSession().selectOne("appDomtSQL_text.domtViewPage_domt",document_no);
	}
	public List<Domt_P_ApprovalDto> domtViewPage_appline (int document_no) {
		return getSqlSession().selectList("appDomtSQL_text.domtViewPage_appline",document_no);
	}
	//승인
	public void imok (DomtApprovalDto domt_app_no) {
		getSqlSession().update("appDomtSQL_text.imok",domt_app_no);
	}
	//승인
	public void imno (DomtApprovalDto domt_app_no) {
		getSqlSession().update("appDomtSQL_text.imno",domt_app_no);
	}
}
