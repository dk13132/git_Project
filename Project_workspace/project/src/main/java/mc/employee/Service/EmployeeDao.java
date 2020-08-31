package mc.employee.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import mc.employee.Dto.EmployeeDto;

public class EmployeeDao extends SqlSessionDaoSupport{
	
	// �궗�썝 �젙蹂� 由ъ뒪�듃 議고쉶
	public List<Object> sltEmp(EmployeeDto dto) throws Exception {
		List<Object> list = getSqlSession().selectList("employee.sltEmp", dto);
		list.remove(0);
		return list;
	}
	
	// �궗�썝 �젙蹂� 遺��꽌 �븘�꽣 議고쉶
	public List<Object> sltDptFlt(EmployeeDto dto) throws Exception {
		return getSqlSession().selectList("employee.sltDptFlt", dto);
	}
	
	// �궗�썝 �젙蹂� 吏곴툒 �븘�꽣 議고쉶
	public List<Object> sltPstFlt(EmployeeDto dto) throws Exception {
		return getSqlSession().selectList("employee.sltPstFlt", dto);
	}
	
	// �궗�썝 �젙蹂� �븘�꽣 �떎以� 議고쉶
	public List<Object> sltAllFlt(EmployeeDto dto) throws Exception {
		return getSqlSession().selectList("employee.sltAllFlt", dto);
	}
	
	// �궗�썝 �젙蹂� �긽�꽭 議고쉶
	public EmployeeDto sltEmpDtl(EmployeeDto dto) throws Exception {
		return getSqlSession().selectOne("employee.sltEmpDtl", dto);
	}
	
	
	// �궗�썝 �젙蹂� �긽�꽭 議고쉶 - 遺��꽌 �젙蹂�
	public List<Map<String, EmployeeDto>> sltbxDno() throws Exception {
		List<Map<String, EmployeeDto>> list = getSqlSession().selectList("employee.sltbxDno");
		list.remove(0);
		return list;
	}
	
	
	// �궗�썝 �젙蹂� �닔�젙
	public void udtEmp(EmployeeDto dto) throws Exception {
		getSqlSession().update("employee.udtEmp", dto);
	}
	
	// �궗�썝 �젙蹂� �궗吏� �닔�젙
	public void udtEmpPt(EmployeeDto dto) throws Exception {
		getSqlSession().update("employee.udtEmpPt", dto);
	}
	
	// �궗�썝 �궘�젣
	public void dltEmp(EmployeeDto dto) throws Exception {
		getSqlSession().delete("employee.dltEmp", dto);
	}
	
	// �궗�썝 �궘�젣 �떆 沅뚰븳 �솗�씤 �슜
	public int cntatrt(Map<String, Object> map) throws Exception {
		return getSqlSession().selectOne("employee.cntatrt", map);
	}
	
	// �떊洹쒖궗�썝 �벑濡�
	public void istEmp(EmployeeDto dto) throws Exception {
		getSqlSession().insert("employee.istEmp", dto);
	}
	
	// �떊洹� �궗�썝 �궗吏� �벑濡�
	public void istEmpPt(EmployeeDto dto) throws Exception {
		getSqlSession().insert("employee.istEmpPt",dto);
	}
	
	
	
	
	// �꽑�깮�맂 遺��꽌 �젙蹂� 媛� 媛��졇�샂
	public EmployeeDto deptInfo(EmployeeDto dto) {
		return getSqlSession().selectOne("employee.deptInfo", dto);
	}
	
	// �궗踰� 泥댄겕
	public String employee_noCheck(String employee_no) {
		return getSqlSession().selectOne("employee.employee_noCheck", employee_no);
	}
	
}
