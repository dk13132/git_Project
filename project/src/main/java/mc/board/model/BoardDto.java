package mc.board.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor 
@AllArgsConstructor
public class BoardDto {
	private int employee_no;
	private int dept_no;
	
	private String subject; // 제목
	private String name; // 사원명
	@DateTimeFormat(pattern="yyyy-MM-dd")   
	private Date reg_date; // 작성일
	private int readcount; // 조회수
	private int type; // 분류
	private String contents; // 게시판 내용, 댓글내용
	
	private int board_no;  //글번호
	private int file_no;
	private String file_name; // 파일명
	private String file_path; //파일경로
	private String stored_file_name; //파일 변경
	private String del_gb; //삭제파일
	private int filesize; // 파일크기

}
