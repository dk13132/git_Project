package mc.domt.model;

public class DomtAutoDto {

	int employee_no;
	String dept_name;
	String name;
	
	@Override
	public String toString() {
		return "DomtAutoDto [employee_no=" + employee_no + ", dept_name=" + dept_name + ", name=" + name + "]";
	}
	public int getEmployee_no() {
		return employee_no;
	}
	public void setEmployee_no(int employee_no) {
		this.employee_no = employee_no;
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
	
}
