package mc.admin.service;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.format.annotation.DateTimeFormat;

import mc.admin.model.AnnualVo;
import mc.admin.model.AttenDto;
import mc.admin.model.DeptDto;
import mc.admin.model.DeptInfo;
import mc.admin.model.emName;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptDao extends SqlSessionDaoSupport {

	public int count() {
		return getSqlSession().selectOne("admin.count");

	}

	public List<DeptDto> getList(int start, int per) {
		Map<String, Integer> m = new HashMap<String, Integer>();
		m.put("start", start);
		m.put("per", per);
		return getSqlSession().selectList("admin.list", m);
	}

	public int deleteUser(int dept_no) {
		return getSqlSession().delete("admin.delete", dept_no);
	}

	public void insertDept(DeptDto d) {
		getSqlSession().insert("admin.insert", d);
	}

	public List<Map<String, Object>> getDept(String d) {
		return getSqlSession().selectList("admin.dept_info", d);
	}

	public DeptDto updateUser(int dept_no) {
		return getSqlSession().selectOne("admin.dept_user", dept_no);

	}

	public void update(DeptDto d) {
		getSqlSession().update("admin.update", d);

	}

	public List<DeptDto> selectDepts() {
		return getSqlSession().selectList("admin.depts");
	}

	public List<Map<String, Object>> selectpositions(int dept_no) {
		return getSqlSession().selectList("admin.positions", dept_no);
	}

	public List<Map<String, Object>> selectNames(DeptInfo e) {
		return getSqlSession().selectList("admin.names", e);
	}

	public List<Map<String, Object>> selectNo(DeptInfo e) {
		return getSqlSession().selectList("admin.no", e);
	}

	public List<Map<String, Object>> selectPush(DeptInfo info) {
		return getSqlSession().selectList("admin.push", info);
	}

	public int update_auto(emName e) {

		return getSqlSession().update("admin.update_auto", e);

	}

	public int count1(Date start_time) {
		return getSqlSession().selectOne("admin.count1", start_time);

	}

	public List<AttenDto> getAttrList(int start, int per, @DateTimeFormat(pattern = "yyyy-MM-dd") Date start_time) {

		Map<String, Object> m = new HashMap<String, Object>();
		m.put("start", start);
		m.put("per", per);
		m.put("start_time", start_time);

		return getSqlSession().selectList("admin.list1", m);
	}

	public void updateAttr(AttenDto d) {

		getSqlSession().update("admin.update_attr", d);

	}

	public AttenDto attrForm(int attendance_no) {

		return getSqlSession().selectOne("admin.attr_form", attendance_no);

	}

	public int count2(AttenDto a) {
		return getSqlSession().selectOne("admin.count2", a);

	}

	public List<AttenDto> getAttrList1(int start, int per, @DateTimeFormat(pattern = "yyyy-MM-dd") AttenDto a) {

		Map<String, Object> m = new HashMap<String, Object>();
		m.put("start", start);
		m.put("per", per);
		m.put("start_time", a.getStart_time());
		m.put("dept_no", a.getDept_no());

		return getSqlSession().selectList("admin.list2", m);
	}

	public double getAnnual(AttenDto d) {

		return getSqlSession().selectOne("admin.annual", d);

	}

	public void setAnnual(AnnualVo an) {

		getSqlSession().update("admin.setAnnual", an);

	}

	public String getDeName(int dept_no) {

		return getSqlSession().selectOne("admin.dname", dept_no);

	}

}
