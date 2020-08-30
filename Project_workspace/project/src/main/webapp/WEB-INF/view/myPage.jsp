<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="data:;base64">
<title>마이페이지 입니다.</title>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>

	$(document).ready(function(){

		
		
		$("#updInfo").on('click', function() { 
	
			var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf|PNG)$/;
			var maxSize = 5 * 600 * 800;
			var fileSize;

			// 혹시 업로드시키는 파일 선택이 안되어있을 때.					// 막지 말고 백단에서 if문으로 데이터 있으면 수정, 없으면 작동 안하게 바꾸기.
		 /* 	if($('#photo').val() == "") {
				alert("사진은 반드시 있어야 합니다.");
			    $("#photo").focus();
			    return;
			}  */
			

			if($('#photo').val() != "" && $('#photo').val() != null) {
				fileSize = document.getElementById("photo").files[0].size;
			    
			    if(!$('#photo').val().match(fileForm)) {
			    	alert("이미지 파일만 업로드 가능");
			        return;
			    } else if(fileSize > maxSize) {
			    	alert("파일 사이즈는 5MB까지 가능");
			        return;
			    }
			}
	
		// 내정보 수정
			var form = document.getElementById('Info');
			var result = confirm("수정하시겠습니까?");
			if (result) {
				
				form.action = "myPage.do";
				form.method = 'post';
				form.submit();
				alert("수정되었습니다.");
			} else {
				alert("취소되었습니다.");
			}
		}); 

		// 비밀번호 변경
		 $("#updPw").on('click',function updPw() {
			var form = document.getElementById('Info');
			window.open("","updPw","toolbar=no,menubar=no,scrollbar=no,width=700,height=500");
			form.action="reSltPw.do";
			form.target="updPw";
			form.method='post';
			form.submit();	
			}); 
	});
	
	
	</script>
</head>
<body>
	<form id="Info"  enctype="multipart/form-data" >
		<input type="hidden" id="employee_no" name = "employee_no" value="${myInfo.employee_no}" > 
		<table width="600" border="1" cellspacing="0" cellpadding="3"
			align="center">
			<tr>
				<td colspan="3" height="39" align="center">
				<font size="+1"><b>내정보</b></font></td>
			</tr>
			<tr>
				<td width="200"><b>이름</b></td>
				<td width="400">${myInfo.name}</td>
				<td rowspan="4">
					<div>
						<div class="udt_Pt">
						<img src="${myInfo.photo_path}" width="150" height="200"></div>
					</div>

				</td>
			</tr>
			<tr>
				<td width="200"><b>사번</b></td>
				<td width="400">${myInfo.employee_no}</td>
			</tr>
			<tr>
				<td width="200">비밀번호</td>
				<td width="400">
				<input type="button" name="updPw" id="updPw" value="변경"></td>
			</tr>
			<tr>
				<td width="200">직급</td>
				<td width="400">${myInfo.position}</td>
				
			</tr>
			<tr>
				<td width="200">부서</td>
				<td width="400" >${myInfo.dept_name}</td>
				<td><input type="file" id="photo" name="photo" accept="image/*" ></td>
			</tr>
			<tr>
				<td width="200">부서 주소</td>
				<td width="600" colspan="2">${myInfo.dept_addr}</td>
			</tr>
			<tr>
				<td width="200">부서 우편번호</td>
				<td width="200" colspan="2">${myInfo.zipcode}</td>
			</tr>
			<tr>
				<td width="200">부서 전화번호</td>
				<td width="600" colspan="2">${myInfo.dept_phoneNum}</td>
			</tr>
			<tr>
				<td width="200">부서 팩스번호</td>
				<td width="200" colspan="2">${myInfo.fax}</td>
			</tr>
			<tr>
				<td width="200">휴대폰 번호</td>
				<td width="1000" colspan="2">
				<input type="text" name="phone" value="${myInfo.phone}"></td>
			</tr>
			<tr>
				<td width="200">E-Mail</td>
				<td width="1000" colspan="2">
				<input type="text" name="email" value="${myInfo.email}"></td>
			</tr>
			<tr>
				<td width="200">직무</td>
				<td width="1000" colspan="2">
				<input type="text" name="job" value="${myInfo.job}"></td>
			</tr>
			<tr>
				<td width="200">내 주소</td>
				<td colspan="2"><input type="text" name="address" value="${myInfo.address}"></td>
			</tr>
			<tr>
				<td colspan="3" align="center">
				<input type="button" name="updInfo" id="updInfo" value="수정" >
			</tr>
		</table>
		</form>
</body>
</html>

