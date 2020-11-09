package mc.project.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ProjectDto {
/*
	`project_no`           INT             NOT NULL    COMMENT '프로젝트번호', 
    `employee_no`          INT             NOT NULL    COMMENT '프로젝트담당자', 
    `subject`              VARCHAR(100)    NULL        COMMENT '프로젝트제목', 
    `start_time`           DATE            NULL        COMMENT '프로젝트시작날짜', 
    `end_time`             DATE            NULL        COMMENT '프로젝트종료날짜', 
    `contents`             VARCHAR(600)    NULL        COMMENT '프로젝트설명', 
    `public_availability`  INT             NULL        COMMENT '프로젝트공개여부', 
    `progress`             INT             NULL        COMMENT '프로젝트진행상황', 
    PRIMARY KEY (project_no)
*/
	
	private int project_no; //프로젝트번호
	private int employee_no; //프로젝트담당자
	private String subject; //프로젝트제목
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date start_time;  //프로젝트시작날짜
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date end_time;  //프로젝트종료날짜
	private String contents; //프로젝트설명
	private int public_availability;  //프로젝트공개여부
	private int progress; //프로젝트진행상황
	private String name;
	private int participation_no;//참여번호
	
	/*
	participation_no`  INT    NOT NULL    AUTO_INCREMENT COMMENT '참여번호', 
	project_no`        INT    NOT NULL    COMMENT '프로젝트번호', 
	employee_no`       INT    NOT NULL    COMMENT '참여사원번호', 
	PRIMARY KEY (participation_no) */

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
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getPublic_availability() {
		return public_availability;
	}
	public void setPublic_availability(int public_availability) {
		this.public_availability = public_availability;
	}
	public int getProgress() {
		return progress;
	}
	public void setProgress(int progress) {
		this.progress = progress;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getParticipation_no() {
		return participation_no;
	}
	public void setParticipation_no(int participation_no) {
		this.participation_no = participation_no;
	}
}
