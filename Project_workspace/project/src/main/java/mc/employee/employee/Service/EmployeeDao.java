package mc.employee.Service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import mc.employee.Dto.EmployeeDto;

public class EmployeeDao extends SqlSessionDaoSupport{
	
	// 사원 정보 리스트 조회
	public List<Object> sltEmp() throws Exception {
		List<Object> list = getSqlSession().selectList("employee.sltEmp");
		return list;
	}
	
	// 사원 정보 부서 필터 조회
	public List<Object> sltDptFlt(EmployeeDto dto) throws Exception {
		List<Object> list = getSqlSession().selectList("employee.sltDptFlt", dto);
		return list;
	}
	
	// 사원 정보 직급 필터 조회
	public List<Object> sltPstFlt(EmployeeDto dto) throws Exception {
		List<Object> list = getSqlSession().selectList("employee.sltPstFlt", dto);
		return list;
	}
	
	// 사원 정보 필터 다중 조회
	public List<Object> sltAllFlt(EmployeeDto dto) throws Exception {
		List<Object> list = getSqlSession().selectList("employee.sltAllFlt", dto);
		return list;
	}
	
	// 사원 정보 상세 조회
	public EmployeeDto sltEmpDtl(EmployeeDto dto) throws Exception {
		return getSqlSession().selectOne("employee.sltEmpDtl", dto);
	}
	
	
	// 사원 정보 상세 조회 - 부서 정보
	public List<Map<String, EmployeeDto>> sltbxDno() throws Exception {
		return getSqlSession().selectList("employee.sltbxDno");
	}
	
	
	// 사원 정보 수정
	public void udtEmp(EmployeeDto dto) throws Exception {
		getSqlSession().update("employee.udtEmp", dto);
	}
	
	// 사원 정보 사진 수정
	public void udtEmpPt(EmployeeDto dto) throws Exception {
		getSqlSession().update("employee.udtEmpPt", dto);
	}
	
	// 사원 삭제
	public void dltEmp(EmployeeDto dto) throws Exception {
		getSqlSession().delete("employee.dltEmp", dto);
	}
	
	// 사원 삭제 시 권한 확인 용
	public int cntatrt(Map<String, Object> map) throws Exception {
		return getSqlSession().selectOne("employee.cntatrt", map);
	}
	
	// 신규사원 등록
	public void istEmp(EmployeeDto dto) throws Exception {
		getSqlSession().insert("employee.istEmp", dto);
	}
	
	// 신규 사원 사진 등록
	public void istEmpPt(EmployeeDto dto) throws Exception {
		getSqlSession().insert("employee.istEmpPt",dto);
	}
	
	
	// 선택된 부서 정보 값 가져옴
	public EmployeeDto deptInfo(EmployeeDto dto) {
		return getSqlSession().selectOne("employee.deptInfo", dto);
	}
	
	// 사번 체크
	public String employee_noCheck(String employee_no) {
		return getSqlSession().selectOne("employee.employee_noCheck", employee_no);
	}
	
}
