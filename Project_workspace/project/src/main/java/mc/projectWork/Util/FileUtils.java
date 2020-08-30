package mc.projectWork.Util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import mc.projectWork.model.ProjectWorkDto;

@Component("fileUtils")
public class FileUtils {	//첨부파일의 정보를 이용하여 여러가지 조작을 할 클래스

	private static final String filePath = "C:\\file\\"; // 파일이 저장될 위치

	public List<Map<String, Object>> parseInsertFileInfo(ProjectWorkDto dto, MultipartHttpServletRequest mpRequest) throws Exception {

		/*
		 * Iterator은 데이터들의 집합체? 에서 컬렉션으로부터 정보를 얻어올 수 있는 인터페이스입니다. List나 배열은 순차적으로 데이터의
		 * 접근이 가능하지만, Map등의 클래스들은 순차적으로 접근할 수가 없습니다. Iterator을 이용하여 Map에 있는 데이터들을
		 * while문을 이용하여 순차적으로 접근합니다.
		 */

		Iterator<String> iterator = mpRequest.getFileNames();

		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;

		int work_no = dto.getWork_no();

		File file = new File(filePath);
		if (file.exists() == false) {
			file.mkdirs();
		}

		while (iterator.hasNext()) {
			multipartFile = mpRequest.getFile(iterator.next());
			if (multipartFile.isEmpty() == false) {
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = getRandomString() + originalFileExtension;

				file = new File(filePath + storedFileName);
				multipartFile.transferTo(file);
				listMap = new HashMap<String, Object>();
				listMap.put("work_no", work_no);	//게시판 번호
				listMap.put("file_name", originalFileName);	//원본 파일 이름
				listMap.put("filesize", multipartFile.getSize());	//파일 크기
				listMap.put("stored_file_name", storedFileName);	//파일 크기
				listMap.put("file_path", file.getPath());	//파일 크기
				
				list.add(listMap);
			}
		}
		return list;
	}

	//파일 수정 관련
	public List<Map<String, Object>> parseUpdateFileInfo(ProjectWorkDto dto, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception{ 
		Iterator<String> iterator = mpRequest.getFileNames();
		MultipartFile multipartFile = null; 
		String originalFileName = null; 
		String originalFileExtension = null; 
		String storedFileName = null; 
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null; 
		int work_no = dto.getWork_no();
		while(iterator.hasNext()){ 
			multipartFile = mpRequest.getFile(iterator.next()); 
			if(multipartFile.isEmpty() == false){ //multipartFile이 비어있지 않으면 if문을 타게되는데, 새로운 새로운 첨부파일이 등록되었을때 타게됩니다.
				originalFileName = multipartFile.getOriginalFilename(); 
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf(".")); 
				storedFileName = getRandomString() + originalFileExtension; 
				multipartFile.transferTo(new File(filePath + storedFileName)); 

				listMap = new HashMap<String,Object>();
				listMap.put("del_ch", "Y");
				listMap.put("work_no", work_no); 
				listMap.put("file_name", originalFileName);
				listMap.put("stored_file_name", storedFileName); 
				listMap.put("filesize", multipartFile.getSize()); 
				list.add(listMap); 
			} 
		}
		if(files != null && fileNames != null){ //files와 fileNames가 null이 아니면 for문을 타게됩니다. 이 for문은 삭제할 파일의 파일 번호와 파일이름을 받게되어있습니다.
			for(int i = 0; i<fileNames.length; i++) {
					listMap = new HashMap<String,Object>();
                    listMap.put("del_ch", "N");
					listMap.put("file_no", files[i]); 
					list.add(listMap); 
			}
		}
		return list; 
	}
	
	public static String getRandomString() { //getRandomString() 메서드는 32글자의 랜덤한 문자열(숫자포함)을 만들어서 반환해주는 기능
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
}