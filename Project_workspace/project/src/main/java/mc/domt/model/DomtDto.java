package mc.domt.model;

import java.sql.Date;

/*import org.springframework.format.annotation.DateTimeFormat;*/

import com.google.protobuf.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class DomtDto {
	int document_no;
	int employee_no;
	String subject;
	String contents;
	/* @DateTimeFormat(pattern = "yyyy-MM-dd") */
	Date reg_date;
	int type;

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

	@Override
	public String toString() {
		return "DomtDto [document_no=" + document_no + ", employee_no=" + employee_no + ", subject=" + subject
				+ ", contents=" + contents + ", reg_date=" + reg_date + ", type=" + type + "]";
	}

}
