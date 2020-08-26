package mc.admin.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class AttenDto {
	
	String dept_name;
	String position;
	String name;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	Date start_time;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	Date end_time;
	double state;
	int attendance_no;
	int dept_no;
	
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public double getState() {
		return state;
	}
	public void setState(double state) {
		this.state = state;
	}
	public int getAttendance_no() {
		return attendance_no;
	}
	public void setAttendance_no(int attendance_no) {
		this.attendance_no = attendance_no;
	}
	public int getDept_no() {
		return dept_no;
	}
	public void setDept_no(int dept_no) {
		this.dept_no = dept_no;
	}
	
	@Override
	public String toString() {
		return "AttenDto [dept_name=" + dept_name + ", position=" + position + ", name=" + name + ", start_time="
				+ start_time + ", end_time=" + end_time + ", state=" + state + ", attendance_no=" + attendance_no
				+ ", dept_no=" + dept_no + "]";
	}
	
	
	
	
	
	

}
