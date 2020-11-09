package mc.domt.model;

import java.sql.Date;
// �Ⱦ��� DTO
public class DomtApprovalDto {
	int approval_no;
	int document_no;
	int employee_no;
	int state;
	Date approval_date;
	String reason;
	public int getApproval_no() {
		return approval_no;
	}
	public void setApproval_no(int approval_no) {
		this.approval_no = approval_no;
	}
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
	@Override
	public String toString() {
		return "DomtApprovalDto [approval_no=" + approval_no + ", document_no=" + document_no + ", employee_no="
				+ employee_no + ", state=" + state + ", approval_date=" + approval_date + ", reason=" + reason + "]";
	}
	
}
