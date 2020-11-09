package mc.admin.model;

public class DeptDto {
	
	int dept_no;
	String dept_name;
	String dept_addr;
	String zipcode;
	String fax;
	String dept_phoneNum;
	
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
	public String getDept_addr() {
		return dept_addr;
	}
	public void setDept_addr(String dept_addr) {
		this.dept_addr = dept_addr;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getDept_phoneNum() {
		return dept_phoneNum;
	}
	@Override
	public String toString() {
		return "DeptDto [dept_no=" + dept_no + ", dept_name=" + dept_name + ", dept_addr=" + dept_addr + ", zipcode="
				+ zipcode + ", fax=" + fax + ", dept_phoneNum=" + dept_phoneNum + "]";
	}
	public void setDept_phoneNum(String dept_phoneNum) {
		this.dept_phoneNum = dept_phoneNum;
	}
	
	

}
