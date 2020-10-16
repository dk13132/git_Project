package mc.employee.Service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mc.employee.Dto.EmployeeDto;

@Service
public class EmployeeService {

	@Autowired
	private EmployeeDao dao;
	
	// 사원 정보 조회
	
	public List<Object> sltEmp(EmployeeDto dto) throws Exception {
		
		List<Object> list = new ArrayList<Object>();
		
		if(dto.getDept_no() != null) {
			if(dto.getPosition() != null || dto.getPosition() != "") {
				list = dao.sltAllFlt(dto);
			}
			if(dto.getPosition() == null || dto.getPosition() == ""){
				list = dao.sltDptFlt(dto);
			}
		}
		if(dto.getDept_no() == null) {
			if(dto.getPosition() != null ||  dto.getPosition() != "") {
				list = dao.sltPstFlt(dto);
			}
			if(dto.getPosition() == null || dto.getPosition() == ""){
				list = dao.sltEmp();
			}
		}
		
		
		return list;
	}



	// 사원 정보 상세조회
	public EmployeeDto sltDtlEmp(EmployeeDto dto) throws Exception {
		return dao.sltEmpDtl(dto);
	}

	// 부서정보 셀렉트박스
	public List<Map<String, EmployeeDto>> sltbxDno() throws Exception {
		return dao.sltbxDno();
	}

	// 사원 정보 수정
	public void udtEmp(EmployeeDto dto, MultipartHttpServletRequest request) throws Exception {
		dao.udtEmp(dto);

		String rootPath = request.getSession().getServletContext().getRealPath("/resources/employee/");
		List<MultipartFile> fileList = request.getFiles("photo");

		if (request.getFiles("photo").get(0).getSize() != 0) {
			fileList = request.getFiles("photo");

			for (MultipartFile mf : fileList) {
				dto.setPhoto_name(mf.getOriginalFilename());
				dto.setPhoto_size(request.getFiles("photo").get(0).getSize());
				dto.setPhoto_path("resources/employee/" + dto.getPhoto_name());
				String path = rootPath + mf.getOriginalFilename();
				mf.transferTo(new File(path));
			}

			{
				dao.udtEmpPt(dto);
			}
		}
	}

	// 사원 삭제
	public void dltEmp(EmployeeDto dto) throws Exception {
		dao.dltEmp(dto);
	}

	// 삭제 관리자 권한 인증
	public int cntatrt(HttpSession hs) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("authority", hs.getAttribute("mc_authority"));
		map.put("employee_no", hs.getAttribute("mc_employee_no"));

		int cntatrt = dao.cntatrt(map);
		return cntatrt;
	}

	// 사원 등록
	public void istEmp(EmployeeDto dto) throws Exception {
		
		Random rand = new Random();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
		Date now = new Date();
		dto.setHiredate(now);

		String employee_no;
		do {
			employee_no = sdf.format(now);
			for (int i = 0; i < 4; i++) {
				String randNum = Integer.toString(rand.nextInt(10));
				employee_no += randNum;
			}
		} while (dao.employee_noCheck(employee_no) != null);
		dto.setEmployee_no(Integer.parseInt(employee_no));
		dto.setPassword(sdf2.format(dto.getBirth()));

		dao.istEmp(dto);
	}

	// 사원 사진 등록
	public void istEmpPt(EmployeeDto dto, MultipartHttpServletRequest request) throws Exception {
		
		String rootPath = request.getSession().getServletContext().getRealPath("/resources/employee/");
		List<MultipartFile> fileList = request.getFiles("photo");

		if (request.getFiles("photo").get(0).getSize() != 0) {
			fileList = request.getFiles("photo");

			for (MultipartFile mf : fileList) {
				dto.setPhoto_name(mf.getOriginalFilename());
				dto.setPhoto_size(request.getFiles("photo").get(0).getSize());
				dto.setPhoto_path("resources/employee/" + dto.getPhoto_name());
				String path = rootPath + mf.getOriginalFilename();
				mf.transferTo(new File(path));
			}
			dao.istEmpPt(dto);
		}
	}
	
	// 부서 정보
	public EmployeeDto deptInfo(EmployeeDto dto) {
		return dao.deptInfo(dto);
	}
	
}
