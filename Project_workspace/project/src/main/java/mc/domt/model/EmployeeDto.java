package mc.domt.model;

import com.google.protobuf.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class EmployeeDto {

	int employee_no;
	int dept_no;
	String password;
	String email;
	String phone;
	String job;
	String position;
	Timestamp birth;
	int authority;
	String name;
	String photo;
	String address;
	Timestamp hiredate;
	int Annual_leave;
	String dept_name;
;
	

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public Timestamp getBirth() {
		return birth;
	}

	public void setBirth(Timestamp birth) {
		this.birth = birth;
	}

	public int getAuthority() {
		return authority;
	}

	public void setAuthority(int authority) {
		this.authority = authority;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Timestamp getHiredate() {
		return hiredate;
	}

	public void setHiredate(Timestamp hiredate) {
		this.hiredate = hiredate;
	}

	public int getAnnual_leave() {
		return Annual_leave;
	}

	public void setAnnual_leave(int annual_leave) {
		Annual_leave = annual_leave;
	}

	@Override
	public String toString() {
		return "EmployeeDto [employee_no=" + employee_no + ", dept_no=" + dept_no + ", password=" + password
				+ ", email=" + email + ", phone=" + phone + ", job=" + job + ", position=" + position + ", birth="
				+ birth + ", authority=" + authority + ", name=" + name + ", photo=" + photo + ", address=" + address
				+ ", hiredate=" + hiredate + ", Annual_leave=" + Annual_leave + "]";
	}

}
