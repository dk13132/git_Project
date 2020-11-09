package mc.myInfo.Service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mc.myInfo.Dto.MyInfoDto;

@Service
public class MyInfoService {

	@Autowired
	private MyInfoDao dao;

	// 비밀번호 확인
	public MyInfoDto confirmPw(MyInfoDto dto) throws Exception {
		return dao.confirmPw(dto);
	}

	// 기존 비밀번호 카운트 > 비밀번호 변경까지.
	@Transactional
	public Map chgPw(MyInfoDto dto) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String errMsg = "";
		String errCode = "";
		int cnt = dao.countPw(dto);
		if (cnt == 0) { // 비밀번호 불일치로 카운트값x
			errMsg = "기존 비밀번호가 일치하지 않습니다.";
			errCode = "1";
		} else { // 비밀번호 일치 > 새로운 패스워드 입력하기
			udtPw(dto);
			errMsg = "정상적으로 변경되었습니다.";
			errCode = "0";
		}

		resultMap.put("errMsg", errMsg);
		resultMap.put("errCode", errCode);
		return resultMap;
	}

	// 비밀번호 변경
	public void udtPw(MyInfoDto dto) throws Exception {
		System.out.println("###### 비밀번호 변경 service");
		dao.udtPw(dto);
	}

	// 내 정보 수정
	public void udtInfo(MyInfoDto dto, MultipartHttpServletRequest request) throws Exception {

		String rootPath = request.getSession().getServletContext().getRealPath("/resources/employee/");

		List<MultipartFile> fileList = request.getFiles("photo");
		
		dao.udtInfo(dto);
		
		if (request.getFiles("photo").get(0).getSize() != 0) {
			fileList = request.getFiles("photo");

			for (MultipartFile mf : fileList) {
				dto.setPhoto_name(mf.getOriginalFilename());
				dto.setPhoto_size(request.getFiles("photo").get(0).getSize());
				dto.setPhoto_path("resources/employee/" + dto.getPhoto_name());
				String path = rootPath + dto.getPhoto_name();
				try { // 파일 생성
					mf.transferTo(new File(path));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			dao.udtInfoPt(dto);
		}
	}

	// 내 정보 select값
	public MyInfoDto sltInfo(MyInfoDto dto) throws Exception {
		return dao.sltInfo(dto);
	}

	/*
	 * // 사번으로 가져오는 비밀번호값 public String selectPw(MyInfoDto dto) { return
	 * dao.selectPw(dto); }
	 * 
	 */

}
