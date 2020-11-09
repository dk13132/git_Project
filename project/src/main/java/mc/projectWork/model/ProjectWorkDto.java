package mc.projectWork.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ProjectWorkDto {

/*  `work_no`      INT             NOT NULL    AUTO_INCREMENT COMMENT '일감번호', 
    `project_no`   INT             NOT NULL    COMMENT '프로젝트번호', 
    `employee_no`  INT             NOT NULL    COMMENT '일감담당자', 
    `subject`      VARCHAR(100)    NULL        COMMENT '일감제목', 
    `contents`     VARCHAR(600)    NULL        COMMENT '일감내용', 
    `priority`     INT             NULL        COMMENT '중요도', 
    `start_time`   DATE            NULL        COMMENT '일감등록날짜', 
    `end_time`     DATE            NULL        COMMENT '일감완료날짜', 
    `state`        INT             NULL        COMMENT '진행상황', 
    `authority`    INT             NULL        COMMENT '권한', 
    PRIMARY KEY (work_no) */
	private int work_no; //일감번호
	private int project_no; //프로젝트번호
	private int employee_no; //일감담당자
	private String subject; //일감제목
	private String contents; //일감내용
	private int priority; //중요도
	private int state; //진행상황
	private int authority; //권한
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date start_time; //일감등록날짜
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date end_time; //일감완료날짜

	private String name;	//사원 이름
	/*							댓글 테이블
	`comment_no`   INT             NOT NULL    AUTO_INCREMENT COMMENT '댓글번호', 
    `work_no`      INT             NOT NULL    COMMENT '일감번호', 
    `employee_no`  INT             NOT NULL    COMMENT '댓글쓴사원', 
    `contents`     VARCHAR(600)    NULL        COMMENT '내용', 
    PRIMARY KEY (comment_no)
	 */
	private int comment_no;

	/*							파일 테이블
	`file_no`    INT             NOT NULL    AUTO_INCREMENT COMMENT '파일번호', 
    `work_no`    INT             NOT NULL    COMMENT '일감번호', 
    `file_name`  VARCHAR(200)    NULL        COMMENT '파일이름', 
    `file_path`  VARCHAR(200)    NULL        COMMENT '파일경로', 
    `filesize`   INT             NULL        COMMENT '파일크기', 
    PRIMARY KEY (file_no)
	 */
	private int file_no;//파일번호
	private String file_name;//파일이름
	private String stored_file_name; //변경될 이름
	private String file_path;//파일경로
	private int filesize;//파일크기
	private String del_ch;
	//ORG_FILE_NAME과 STORED_FILE_NAME 여기서 파일 이름에 관련된 컬럼을 2개 만든 이유는 
	//파일 업로드를 하게 되면 그 파일은 서버에 저장이 되어야하는데 이미 파일의 이름이 저장된 상태에서 
	//같은 이름으로 저장을 또 하게 된다면 저장중에 문제가 발생하거나 파일 이름이 변경될 수도 있습니다.
	//원본파일(ORG_FILE_NAME)의 이름을 저장하고 서버로는 변경된 파일(STORED_FILE_NAME)의 이름으로 파일을 저장합니다. 
	
	/*			참여 리스트
    `participation_no`  INT    NOT NULL    AUTO_INCREMENT COMMENT '참여번호', 
    `project_no`        INT    NOT NULL    COMMENT '프로젝트번호', 
    `employee_no`       INT    NOT NULL    COMMENT '참여사원번호', 
    PRIMARY KEY (participation_no) */
	private int participation_no;
	
	public int getWork_no() {
		return work_no;
	}

	public void setWork_no(int work_no) {
		this.work_no = work_no;
	}

	public int getProject_no() {
		return project_no;
	}

	public void setProject_no(int project_no) {
		this.project_no = project_no;
	}

	public int getEmployee_no() {
		return employee_no;
	}

	public void setEmployee_no(int employee_no) {
		this.employee_no = employee_no;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getAuthority() {
		return authority;
	}

	public void setAuthority(int authority) {
		this.authority = authority;
	}

	public Date getStart_time() {
		return start_time;
	}

	public void setStart_time(Date start_time) {
		this.start_time = start_time;
	}

	public Date getEnd_time() {
		return end_time;
	}

	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getComment_no() {
		return comment_no;
	}

	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
	}

	public int getFile_no() {
		return file_no;
	}

	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public String getStored_file_name() {
		return stored_file_name;
	}

	public void setStored_file_name(String stored_file_name) {
		this.stored_file_name = stored_file_name;
	}

	public String getFile_path() {
		return file_path;
	}

	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	public int getFilesize() {
		return filesize;
	}

	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}

	public String getDel_ch() {
		return del_ch;
	}

	public void setDel_ch(String del_ch) {
		this.del_ch = del_ch;
	}

	public int getParticipation_no() {
		return participation_no;
	}

	public void setParticipation_no(int participation_no) {
		this.participation_no = participation_no;
	}

	
}
