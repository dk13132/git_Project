<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<head>
<title>회원 상세 페이지</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<style>
#file-upload-button{
	display: block;
	padding: 10px 25px;
	border: 1px solid #ced4da;
	margin: 0 auto;
	letter-spacing: 0.05em;
	cursor: pointer;
}
th, td { text-align: center; padding: 7px;}
</style>
</head>
<body>
	<div id="wrap">
		<jsp:include page="/WEB-INF/view/head.jsp" flush="false" />
		<section id="content">
			<div id="leftcontent">

				<ul>
					<li><a class="active" href="sltEmp.do">사원 정보 조회</a></li>
				</ul>
			</div>
			<div id="rightcontent" style="padding-top:3%; border-left:2px solid #f0f0f0; padding-left:10%; padding-bottom:10%;width: 750px; background: white;min-height: 600px;">
				<form id="sltDtlEmp" enctype="multipart/form-data">
					<input type="hidden" id="employee_no" name="employee_no" value="${employee.employee_no}">
					<table style="width:750px; border:0px; position:center; height:550px" cellspacing="0" cellpadding="3">
						<tr>
							<td colspan="4" height="50" align="center" style="padding:3%;"><font size="6" color="gray"><b>사원 상세 정보</b></font></td>
						</tr>
						<tr>
							<td width="200" height="50">이    름</td>
							<td width="200" height="50" style="padding-height:10px;">${employee.name}</td>
							<td rowspan="4" width="150" height="200" >
										<img src="${employee.photo_path}" id="imgEmployee" width="150" height="200">
							</td>
						</tr>
						<tr>
							<td width="200" height="50">사    번</td>
							<td width="200" height="50" style="padding-height:10px;" >${employee.employee_no}</td>
						</tr>
						<tr>
							<td width="200" height="50" >직  급</td>
							<td width="200" height="50" align="center" >
								<select name="position" id="position" align="center" style="padding: .3em 20px .3em 20px;border:1px solid #ced4da;border-radius:.25rem;color:#495057;background-color:#fff;" >
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
							<td width="200" height="50">부    서</td>
							<td width="200" height="50" align="center">
							<select name="dept_no" id="dept_no" style="padding: .3em 13px .3em 13px;border:1px solid #ced4da;border-radius:.25rem;color:#495057;background-color:#fff;">
									<c:forEach items="${department}" var="department">
										<option value="${department.dept_no}"
											<c:if test="${employee.dept_no == department.dept_no}">selected</c:if>
														>${department.dept_name}</option>
									</c:forEach>
							</select>
							
						</tr>
						<tr>
							<td width="200" height="50">부서 우편번호</td>
							<td width="200" height="50" id="dept_zipcode">${employee.zipcode}</td>
							<td width="200" height="50" align=center>
								<input type="file" id="photo" name="photo" accept="image/*"></td>
						</tr>
						<tr>
							<td width="200" height="50" >부서 주소</td>
							<td width="400" colspan="2" height="50" style="text-align:left;" id="dept_addr">${employee.dept_addr}</td>
						</tr>
						<tr>
							<td width="200" height="50" align="center">부서 전화번호</td>
							<td width="400" height="50" colspan="2" style="text-align:left;" id="dept_phoneNum">${employee.dept_phoneNum}</td>
						</tr>
						<tr>
							<td width="200" height="50" align="center">부서 팩스번호</td>
							<td width="400" height="50" width="150" colspan="2" style="text-align:left;" id="dept_fax">${employee.fax}</td>
						</tr>
						<tr>
							<td width="200" height="50" align="center">E-Mail</td>
							<td width="400" height="50" width="150" colspan="2" style="text-align:left;">${employee.email}</td>
						</tr>
						<tr>
							<td width="200" height="50" align="center">휴대폰 번호</td>
							<td width="400" height="50" colspan="2" style="text-align:left;">${employee.phone}</td>
						
						</tr>
						<tr>
							<td width="200" height="50" align="center">직    무</td>
							<td width="400" colspan="2" height="50" style="text-align:left;">${employee.job}</td>							
						</tr>
						<tr>
							<td width="200" height="50" align="center">내  주소</td>
							<td width="400" colspan="2" width="450" height="50" style="text-align:left;">${employee.address}</td>
						</tr>
						<tr>
						</tr>
						<tr>
							<td width="600" colspan="4" height="50">
							<input type="button" name="udtEmp" id="udtEmp" value="수정" style="border:1px solid #ced4da;border-radius:.25rem;color:#495057;background-color:#fff;" > 
							<input type="button" name="bfPg" id="bfPg" value="취소" onclick="location.href='sltEmp.do'" style="border:1px solid #ced4da;border-radius:.25rem;color:#495057;background-color:#fff;">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
	<script>

	// 사원 정보 수정
	$("#udtEmp").on('click', function() {
		var form = document.getElementById('sltDtlEmp');

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

	 
<!-- 수정 버튼 : 정보 onchange 생기면 활성화. -->
	$(document).ready(function() {

		// 이미지 파일 유효성 검사
		$("#photo").on('click', function() {
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
 
		// 이미지 파일 선택시 읽어오는 펑션 
		function readURL(input) {
	    	if (input.files && input.files[0]) {
	       	 	var reader = new FileReader();
	        	reader.onload = function(e) {
	           	 	$('#imgEmployee').attr('src', e.target.result);
	        	}
	        	reader.readAsDataURL(input.files[0]);
	    	}
		}

		// 선택한 이미지로 변경
		$("#photo").on('change', function () {
	    	readURL(this);	
		});
			
		 

		// 선택한 부서 정보 변경
		$("#dept_no").on('change', function() {
		
			var dept_no = $("#dept_no").val();
			var url = "deptInfo.do";
			var params = "dept_no=" + $("#dept_no option:selected").val();
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
		});
	
	});
</script>
</body>
</html>