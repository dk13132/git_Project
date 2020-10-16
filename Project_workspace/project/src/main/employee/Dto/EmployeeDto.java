package mc.employee.Dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@NoArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@Setter
public class EmployeeDto {

	private String dept_name;
	private String position;
	private String name;
	private Integer employee_no;	// 입사년도 + 시퀀스
	private String phone;
	private String email;
	private Integer authority;
	
	private String password;	// 생년월일 + dept_no?
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birth;
	private String job;
	
	private String address;
	private String photo_name;
	private String photo_path;
	private long photo_size;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date hiredate;
	private Integer annual_leave;
	
	private Integer dept_no;
	private String dept_addr;
	private String zipcode;
	private String fax;
	private String dept_phoneNum;
	
	
	
}
