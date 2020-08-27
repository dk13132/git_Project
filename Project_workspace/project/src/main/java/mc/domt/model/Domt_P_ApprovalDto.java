package mc.domt.model;

import java.sql.Date;

public class Domt_P_ApprovalDto {
	int document_no;
	int employee_no;

	int approval_no;
	int state;
	Date approval_date;
	String reason;

	String subject;
	String contents;
	Date reg_date;
	int type;
//	추가요소
	
	int dept_no;
	String dept_name;
	String name;
	
	public int getDocument_no() {
		return document_no;
	}
	public void setDocument_no(int document_no) {
		this.document_no = document_no;
	}
	public int getEmployee_no() {
		return employee_no;
	}
	public void setEmployee_no(int employee_no) {
		this.employee_no = employee_no;
	}
	public int getApproval_no() {
		return approval_no;
	}
	public void setApproval_no(int approval_no) {
		this.approval_no = approval_no;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Date getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(Date approval_date) {
		this.approval_date = approval_date;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
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
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getDept_no() {
		return dept_no;
	}
	public void setDept_no(int dept_no) {
		this.dept_no = dept_no;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "Domt_P_ApprovalDto [document_no=" + document_no + ", employee_no=" + employee_no + ", approval_no="
				+ approval_no + ", state=" + state + ", approval_date=" + approval_date + ", reason=" + reason
				+ ", subject=" + subject + ", contents=" + contents + ", reg_date=" + reg_date + ", type=" + type
				+ ", dept_no=" + dept_no + ", dept_name=" + dept_name + ", name=" + name + "]";
	}
	
	

}
