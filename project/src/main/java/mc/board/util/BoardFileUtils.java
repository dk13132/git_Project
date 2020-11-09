package mc.board.util;

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

import mc.board.model.BoardDto;


@Component("BoardfileUtils")
public class BoardFileUtils {
	private static final String filePath = "D:\\board\\"; // 파일이 저장될 위치

	public List<Map<String, Object>> parseInsertFileInfo(BoardDto dto, MultipartHttpServletRequest mpRequest) throws Exception {

		Iterator<String> iterator = mpRequest.getFileNames();

		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> listMap = null;

		int board_no = dto.getBoard_no();

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
				listMap.put("board_no", board_no);
				listMap.put("file_name", originalFileName);
				listMap.put("stored_file_name", storedFileName);
				listMap.put("filesize", multipartFile.getSize());
				listMap.put("file_path", file.getPath());
				list.add(listMap);
			}
		}
		return list;
	}
	
	
	public List<Map<String, Object>> parseUpdateFileInfo(BoardDto dto, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception{ 
		Iterator<String> iterator = mpRequest.getFileNames();
		MultipartFile multipartFile = null; 
		String originalFileName = null; 
		String originalFileExtension = null; 
		String storedFileName = null; 
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null; 
		int board_no = dto.getBoard_no();
		
		
		File file = new File(filePath);
		if (file.exists() == false) {
			file.mkdirs();
		}
		while(iterator.hasNext()){ 
			multipartFile = mpRequest.getFile(iterator.next()); 
			if(multipartFile.isEmpty() == false){ 
				originalFileName = multipartFile.getOriginalFilename(); 
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf(".")); 
				storedFileName = getRandomString() + originalFileExtension; 

				file = new File(filePath + storedFileName);
				multipartFile.transferTo(file);
				listMap = new HashMap<String,Object>();
				listMap.put("del_gb", "N");
				listMap.put("board_no", board_no); 
				listMap.put("file_name", originalFileName);
				listMap.put("stored_file_name", storedFileName); 
				listMap.put("filesize", multipartFile.getSize());
				list.add(listMap); 
			} 
		}
		if(files != null && fileNames != null){ 
			for(int i = 0; i<fileNames.length; i++) {
					listMap = new HashMap<String,Object>();
                    listMap.put("del_gb", "Y");
					listMap.put("file_no", files[i]); 
					list.add(listMap); 
			}
		}
		return list; 
	}

	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
}
