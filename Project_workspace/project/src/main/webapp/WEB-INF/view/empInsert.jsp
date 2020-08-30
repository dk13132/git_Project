<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>사원 등록</title>
</head>
<body>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
	<script>
		function deptChange(){
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
		}

		function istEmployee() { 
			
			var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf|PNG)$/;
			var maxSize = 5 * 600 * 800;
			var fileSize;

			// 혹시 업로드시키는 파일 선택이 안되어있을 때.					// 막지 말고 백단에서 if문으로 데이터 있으면 수정, 없으면 작동 안하게 바꾸기.
		  	if($('#photo').val() == "") {
				alert("사진은 반드시 있어야 합니다.");
			    $("#photo").focus();
			    return;
			}  
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
			
			var form = document.getElementById('istEmp');
			var result = confirm("등록하시겠습니까?");
			
			if (result) {
				form.action = "istEmp.do";
				form.method = 'post';
				form.submit();
				alert("등록되었습니다.");
			} else {
				alert("취소되었습니다.");
			}
		}

		function bfPg() {
			history.go(-1);
			}
		
	</script>
	
	<form id="istEmp" method="post" enctype="multipart/form-data">
		<table width="600" border="1" cellspacing="0" cellpadding="3"
			align="center">
			<tr>
				<td colspan="3" height="39" align="center"><font size="+1"><b>사원
							정보 입력</b></font></td>
			</tr>
			<tr>
				<td width="200"><b>이름</b></td>
				<td width="400"><input type="text" name="name"></td>
			<%-- 	<td rowspan="3">
					<div>
						<div class="udt_Pt">
							<img src="${employee.photo_path}" width="150" height="200">
						</div>
					</div>

				</td> --%>
			</tr>
			<tr>
				<td width="200">생년월일</td>
				<td width="400"><input type="date" name="birth" id="birth"></td>
			</tr>
			
			<tr>
				<td width="200">직급</td>
				<td width="400"><select name="position">
						<option value="주임">주임</option>
						<option value="대리">대리</option>
						<option value="대리">팀장</option>
						<option value="과장">과장</option>
						<option value="부장">부장</option>
				</select></td>

			</tr>
			<tr>
				<td width="200">연차</td>
				<td width="400">
					<input type = "text" name="annual_leave" id="annual_leave" value="${employee.annual_leave}"></td>
			</tr>
			<tr>
				<td width="200">부서</td>
				<td width="400"><select name="dept_no" id="dept_no" onchange="deptChange()">
						<c:forEach items="${department}" var="item">
							<option value="${item.dept_no}">${item.dept_name}</option>
						</c:forEach>
				</select>
				<td><input type="file" id="photo" name="photo" accept="image/*"></td>
			</tr>
			<tr>
				<td width="200">부서 주소</td>
				<td width="600" colspan="2"><div id="dept_addr"></div></td>
			</tr>
			<tr>
				<td width="200">부서 우편번호</td>
				<td width="200" colspan="2"><div id="dept_zipcode"></div></td>
			</tr>
			<tr>
				<td width="200">부서 전화번호</td>
				<td width="600" colspan="2"><div id="dept_phoneNum"></div></td>
			</tr>
			<tr>
				<td width="200">부서 팩스번호</td>
				<td width="200" colspan="2"><div id="dept_fax"></div></td>
			</tr>
			
			
			<tr>
				<td colspan="3" align="center">
				<input type="button" name="istEmpBt" id="istEmpBt" onclick="istEmployee()" value="등록" > 
				<input type="button" name="bfPg" id="bfPg" onclick="bfPg()" value="전 단계">
			</tr>
		</table>
	</form>
</body>
</html>