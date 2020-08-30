<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>회원 상세 페이지</title>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>

<script>
<!-- 수정 버튼 : 정보 onchange 생기면 활성화. -->
	$(document).ready(function() {
		$("#photo").on('click', function() {
			// 이미지 파일 유효성 검사
			var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf|PNG)$/;
			var maxSize = 5 * 600 * 800;
			var fileSize;
			
			if ($('#photo').val() != "" && $('#photo').val() != null) {
				fileSize = document.getElementById('photo').files[0].size;

				if (!$('#photo').val().match(fileForm)) {
					alert("이미지 파일만 업로드 가능");
					return;
				} else if (fileSize > maxSize) {
					alert("파일 사이즈는 5MB까지 가능");
					return;
				}
			}
		});
		
		$("#udtEmp").on('click', function() {
			// 사원 정보 수정
			var form = document.getElementById('sltDtlEmp');

			var position = $("select[name='position']:selected").val();
			var dept_no = $("select[name='dept_no']:selected").val();

			var result = confirm("수정하시겠습니까?");
			if (result) {
				form.action = 'udtEmp.do';
				form.method = 'post';
				form.submit();
				alert("수정되었습니다.");

			} else {
				alert("취소되었습니다.");
			}
		});
		
		/* function deptChange(){
			var dept_no = $("#dept_no").val();
			var url = "deptInfo.do";
			var params = "dept_no=" + dept_no;
			$.ajax({
				type : "post",
				url : url,
				data : params,
				dataType : "json"
			}).done(
					function(args) {
						$("#dept_addr").empty();
						$("#dept_zipcode").empty();
						$("#dept_phoneNum").empty();
						$("#dept_fax").empty();

						$("#dept_addr").append(args.dept_addr);
						$("#dept_zipcode").append(args.zipcode);
						$("#dept_phoneNum").append(args.dept_phoneNum);
						$("#dept_fax").append(args.fax);
					}).fail(function(e) {
				alert(e.responseText);
			})
		} */
		
		
	      });

		// 전 단계
		$("#bfPg").on('click', function() {
			var form = document.getElementById('sltDtlEmp');
			
			form.action = 'sltEmp.do';
			form.method = 'post';
			form.submit();

			});
		
	});
</script>
</head>
<body>
	<form id="sltDtlEmp" enctype="multipart/form-data">
		<input type="hidden" id="employee_no" name="employee_no"
			value="${employee.employee_no}">
		<table width="600" border="1" cellspacing="0" cellpadding="3"
			align="center">
			<tr>
				<td colspan="3" height="39" align="center"><font size="+1"><b>사원 정보</b></font></td>
			</tr>
			<tr>
				<td width="200"><b>이름</b></td>
				<td width="400">${employee.name}</td>
				<td rowspan="3">
					<div>
						<div class="udt_Pt">
							<img src="${employee.photo_path}" width="150" height="200">
						</div>
					</div>

				</td>
			</tr>
			<tr>
				<td width="200"><b>사번</b></td>
				<td width="400">${employee.employee_no}</td>
			</tr>
			<!-- 			<tr>
				<td width="200">생년월일</td>
				<td width="400">
				<input type="text" name="birth" id="birth"></td>
			</tr>
	 -->
			<tr>
				<td width="200">직급</td>
				<td width="400"><select name="position" id="position">
						<option value="주임"
							<c:if test='${employee.position == "주임"}'> selected </c:if>>주임</option>
						<option value="대리"
							<c:if test='${employee.position == "대리"}'> selected </c:if>>대리</option>
						<option value="팀장"
							<c:if test='${employee.position == "팀장"}'> selected </c:if>>팀장</option>
						<option value="과장"
							<c:if test='${employee.position == "과장"}'> selected </c:if>>과장</option>
						<option value="부장"
							<c:if test='${employee.position == "부장"}'> selected </c:if>>부장</option>
				</select></td>

			</tr>
			<tr>
				<td width="200">부서</td>
				<td width="400"><select name="dept_no" id="dept_no">
						<c:forEach items="${department}" var="department">
							<option value="${department.dept_no}" <c:if test="${employee.dept_no == department.dept_no}">selected</c:if>>
								${department.dept_name}</option>
						</c:forEach>
				</select>
				<td><input type="file" id="photo" name="photo" accept="image/*"></td>
			</tr>
			<tr>
				<td width="200">부서 주소</td>
				<td width="600" colspan="2">${employee.dept_addr}</td>
			</tr>
			<tr>
				<td width="200">부서 우편번호</td>
				<td width="200" colspan="2">${employee.zipcode}</td>
			</tr>
			<tr>
				<td width="200">부서 전화번호</td>
				<td width="600" colspan="2">${employee.dept_phoneNum}</td>
			</tr>
			<tr>
				<td width="200">부서 팩스번호</td>
				<td width="200" colspan="2">${employee.fax}</td>
			</tr>
			<tr>
				<td width="200">휴대폰 번호</td>
				<td width="1000" colspan="2">${employee.phone}</td>
			</tr>
			<tr>
				<td width="200">E-Mail</td>
				<td width="1000" colspan="2">${employee.email}</td>
			</tr>
			<tr>
				<td width="200">직무</td>
				<td width="1000" colspan="2">${employee.job}</td>
			</tr>
			<tr>
				<td width="200">내 주소</td>
				<td colspan="2">${employee.address}</td>
			</tr>
			<tr>
				<td colspan="3" align="center">
				<input type="button" name="udtEmp" id="udtEmp" value="수정"> 
				<input type="button" name="bfPg" id="bfPg" value="취소">
			</tr>
		</table>
	</form>
</body>
</html>