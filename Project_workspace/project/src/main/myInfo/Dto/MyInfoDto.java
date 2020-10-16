package mc.myInfo.Dto;

import java.util.Date;

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
public class MyInfoDto {

	private int employee_no;
	
	private int dept_no;
	

	private String password;
	private String email;
	private String phone;
	private String job;			// 직무
	private String position;	// 직급
//	private int authority;		// 권한
	private String name;
	private String address;
//	private Date hiredate;		// 입사일
	private int annual_leave;	// 연차
	
	
	
	//부서 정보들
	private String dept_name;
	private String dept_addr;
	private String zipcode;
	private String fax;
	private String dept_phoneNum;
	
	
	//새로운 비밀번호
	private String password2;
	
	//사진
	private String photo_name;
	private String photo_path;
	private long photo_size;
	
	

}
