package mc.admin.model;

public class AnnualVo {
	
	int attendance_no;
	double annual_leave;
	
	public int getAttendance_no() {
		return attendance_no;
	}
	public void setAttendance_no(int attendance_no) {
		this.attendance_no = attendance_no;
	}
	public double getAnnual_leave() {
		return annual_leave;
	}
	public void setAnnual_leave(double annual_leave) {
		this.annual_leave = annual_leave;
	}
	@Override
	public String toString() {
		return "AnnualVo [attendance_no=" + attendance_no + ", annual_leave=" + annual_leave + "]";
	}
	
	
	
	

}
