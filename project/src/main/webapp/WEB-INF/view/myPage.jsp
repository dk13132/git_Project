<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<style>
th, td { text-align: center; padding: 7px;}
</style>
<head>
<link rel="icon" href="data:;base64">
<title>마이페이지 입니다.</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="/WEB-INF/view/head.jsp" flush="false" />
		<section id="content">
			<div id="leftcontent">
				<ul>
					<li><a class="active" href="conPw.do">내 정보 조회</a></li>
					<li><a href="">내 근태 조회</a></li>
				</ul>
			</div>
		<div id="rightcontent" style="text-align: center; padding-top:3%; border-left:2px solid #f0f0f0; padding-left:10%; padding-bottom:10%;width: 750px; background: white;min-height: 600px;">
			
		<form id="Info"  enctype="multipart/form-data" >
		<input type="hidden" id="employee_no" name = "employee_no" value="${myInfo.employee_no}" > 
		<table style="width:750px; border:0px; position:center; height:550px" cellspacing="0" cellpadding="3">
			<tr>
				<td colspan="4" height="50" align="center" style="padding:3%;"><font size="6" color="gray"><b>내 정 보</b></font></td>
			</tr>
						
			<tr>
				<td width="200" height="50">이    름</td>
				<td width="200" height="50" style="padding-height:10px;">${myInfo.name}</td>
				<td rowspan="4" width="150" height="200" >
						<img src="${myInfo.photo_path}" id="imgEmployee" width="150" height="200">
				</td>
			</tr>
			<tr>
				<td width="200" height="50">사    번</td>
				<td width="200" height="50" style="padding-height:10px;">${myInfo.employee_no}</td>
			</tr>
			<tr>
				<td width="200" height="50">비밀번호</td>
				<td width="200" height="50" align="center">
					<input type="button" name="updPw" id="updPw" value="변경" style="border:1px solid #ced4da;border-radius:.25rem;color:#495057;background-color:#fff;padding-height:10px;"></td>
			</tr>
			<tr>
				<td width="200" height="50">직  급</td>
				<td width="200" height="50" align="center">${myInfo.position}</td>
				
			</tr>
			<tr>
				<td width="200" height="50">부  서</td>
				<td width="200" height="50">${myInfo.dept_name}</td>
				<td>
					<input type="file" id="photo" name="photo" accept="image/*" ></td>
			</tr>
			<tr>
				<td width="200" height="50">부서 우편번호</td>
				<td width="200" height="50" id="dept_zipcode">${myInfo.zipcode}</td>
			</tr>
			<tr>
				<td width="200" height="50" align="center">부서 주소</td>
				<td width="400" colspan="2" height="50" style="text-align:left;" id="dept_addr">${myInfo.dept_addr}</td>
			</tr>
			<tr>
				<td width="200" height="50" align="center">부서 전화번호</td>
				<td width="400" height="50" colspan="2" style="text-align:left;" id="dept_phoneNum">${myInfo.dept_phoneNum}</td>
			</tr>
			<tr>
				<td width="200" height="50" align="center">부서 팩스번호</td>
				<td width="400" height="50" width="150" colspan="2" style="text-align:left;" id="dept_fax">${myInfo.fax}</td>
			</tr>
			<tr>
				<td width="200" height="50" align="center">E-Mail</td>
				<td width="400" height="50" width="150" colspan="2" align="left">
					<input type="text" id="email" name="email" size="25" value="${myInfo.email}" class="form-control" style="width:45%; padding-height:10px;"></td>
			</tr>
			<tr>
				<td width="200" height="50" align="center">휴대폰 번호</td>
				<td width="400" height="50" colspan="2"  align="left">
					<input type="text" id="phone" name="phone" size="11" value="${myInfo.phone}" class="form-control" style="width:45%; padding-height:10px;"></td>
			</tr>
			
			<tr>
				<td width="200" height="50" align="center">직    무</td>
				<td width="400" colspan="2" height="50" align="left">
					<input type="text" id="job" name="job" size="50" value="${myInfo.job}" class="form-control" style="width:70%; padding-height:10px;"></td>
			</tr>
			<tr>
				<td width="200" height="50" align="center">내  주소</td>
				<td width="400" colspan="2" width="450" height="50" align="left">
					<input type="text" id="address" name="address" size="50" value="${myInfo.address}" class="form-control" style="width:70%; padding-height:10px;"></td>
			</tr>
			<tr>
				<td width="600" colspan="4" height="50">
				<input type="button" name="updInfo" id="updInfo" value="수정" style="border:1px solid #ced4da;border-radius:.25rem;color:#495057;background-color:#fff;" >
			</tr>
		</table>
		</form>
			</div>

		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
		
<script>
	$(document).ready(function(){

		/* 바꾼 파일 화면에 뿌려주기 위해 읽어오는 코드 시작 */
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    $('#imgEmployee').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
		
        $("#photo").on('change', function () {
            readURL(this);
        }); /* 끝 */

        
		// 비밀번호 변경
		 $("#updPw").on('click',function updPw() {
			var form = document.getElementById('Info');
			window.open("","updPw","toolbar=no,menubar=no,scrollbar=no,width=700,height=450");
			form.action="reSltPw.do";
			form.target="updPw";
			form.method='post';
			form.submit();	
		});
        
		/* 사진 변경 시 파일 유효성 검사 */
		$("#updInfo").on('click', function() { 
	
			var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf|PNG)$/;
			var maxSize = 5 * 600 * 800;
			var fileSize;			
			
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

		// 핸드폰
			var phone = $('#phone').val();
			var regPhone = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
			if(phone == "") {
				alert("핸드폰 번호를 입력해 주세요.");
				$('#phone').focus();
				return;
			}
			if(regPhone.test(phone) == false) {
				alert("유효한 형식이 아닙니다.\n ###-####-#### 형식으로 입력 해 주세요.");
				$('#phone').focus();
				return;
			}

		
		// e-mail
			var email = $("#email").val();
			var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z][_]?)*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			var returnMsg = "유효한 이메일 형식이 아닙니다.";

			if(email == "") {
				alert("이메일을 입력해 주세요.");
				$('#email').focus();
				return;
			}
			
			if (regEmail.test(email) == false) {	
				alert("유효한 이메일 형식이 아닙니다.");
				$('#email').focus();
				return;
			}
		
		
		// 직무
			var job = $('#job').val();
			if(job == "") {
				alert("직무를 입력해 주세요.");
				$('#job').focus();
				return;
			}
		
		// 내주소
			var address = $('#address').val();
			if(address == "") {
				alert("주소를 입력해 주세요.");
				$('#address').focus();
				return;
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

	});
</script>		
</body>
</html>

