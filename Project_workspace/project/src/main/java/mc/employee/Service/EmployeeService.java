package mc.employee.Service;

import java.io.File;
import java.text.SimpleDateFormat;
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
		List<Object> list = null;

		if (dto.getDept_no() != null || dto.getPosition() != null) {
			if (dto.getDept_no() != null && dto.getPosition() == null || dto.getPosition() == "") {
				list = dao.sltDptFlt(dto);
			} else if (dto.getDept_no() == null && dto.getPosition() != null || dto.getPosition() != "") {
				list = dao.sltPstFlt(dto);
			} else if (dto.getDept_no() != null && dto.getPosition() != null || dto.getPosition() != "") {
				list = dao.sltAllFlt(dto);
			}
		} else {
			list = dao.sltEmp(dto);
		}
		return list;
	}

	// 사원 정보 상세 조회
	public EmployeeDto sltDtlEmp(EmployeeDto dto) throws Exception {
		return dao.sltEmpDtl(dto);
	}

	// 사원 정보 상세 조회 - 부서 정보
	public List<Map<String, EmployeeDto>> sltbxDno() throws Exception {
		return dao.sltbxDno();
	}

	// 사원 정보 수정
	public void udtEmp(EmployeeDto dto, MultipartHttpServletRequest request) throws Exception {
		// 두개 변경하는 부분 중에 하나가 없거나 하면은 없는건 실행 안되게끔.

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

	// 사원 삭제 - 관리자 인증
	public int cntatrt(HttpSession hs) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("authority", hs.getAttribute("authority"));
		map.put("employee_no", hs.getAttribute("employee_no"));

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

	public EmployeeDto deptInfo(EmployeeDto dto) {

		return dao.deptInfo(dto);

	}

}
