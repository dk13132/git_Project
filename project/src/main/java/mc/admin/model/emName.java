package mc.admin.model;

public class emName {
	
	String dept_name;
	String position;
	String name;
	int authority;
	
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
	public int getAuthority() {
		return authority;
	}
	public void setAuthority(int authority) {
		this.authority = authority;
	}
	
	
	@Override
	public String toString() {
		return "emName [dept_name=" + dept_name + ", position=" + position + ", name=" + name + ", authority="
				+ authority + "]";
	}
	
	

}
