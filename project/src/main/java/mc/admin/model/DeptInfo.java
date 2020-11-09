package mc.admin.model;

public class DeptInfo {
	
	int employee_no;
	int dept_no;
	String name;
	String position;
	int authority;

	
	public int getEmployee_no() {
		return employee_no;
	}
	public void setEmployee_no(int employee_no) {
		this.employee_no = employee_no;
	}
	public int getDept_no() {
		return dept_no;
	}
	public void setDept_no(int dept_no) {
		this.dept_no = dept_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public int getAuthority() {
		return authority;
	}
	public void setAuthority(int authority) {
		this.authority = authority;
	}
	@Override
	public String toString() {
		return "DeptInfo [employee_no=" + employee_no + ", dept_no=" + dept_no + ", name=" + name + ", position="
				+ position + ", authority=" + authority + "]";
	}
	

}
