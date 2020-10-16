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
<title>사원 등록</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<style>
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
		<form id="istEmp" method="post" enctype="multipart/form-data">
		<table style="width:750px; border:0px; position:center; height:550px" cellspacing="0" cellpadding="3">
			<tr>
				<td colspan="4" height="50" align="center" style="padding:3%;"><font size="6" color="gray"><b>사원 정보 입력</b></font></td>
			</tr>
			<tr>
				<td width="150" height="50">이  름</td>
				<td width="150" height="50" colspan="2" align="center">
					<input class="form-control" style="width:40%; padding-height:10px;" type="text" name="name" id="name"></td>
				<td width="250" height="50" rowspan="4">
					<div class="udt_Pt">
						<img src="" id="imgEmployee" width="150" height="200">
					</div>
				</td>
			</tr>
			<tr>
				<td width="150" height="50">생년월일</td>
				<td width="150" height="50" colspan="2" align="center"><input class="form-control" style="width:60%; padding-height:10px;" type="date" name="birth" id="birth"></td>
			</tr>
			<tr>
				<td width="150" height="50">직  급</td>
				<td width="150" height="50" colspan="2" align="center">
					<select class="form-control" style="width:40%; padding-height:10px;" name="position" id="position">
					 		<option value="" id="position_name">직급명</option>
							<option value="주임">주임</option>
							<option value="대리">대리</option>
							<option value="대리">팀장</option>
							<option value="과장">과장</option>
							<option value="부장">부장</option>
					</select>
				</td>

			</tr>
			<tr>
				<td width="150" height="50">연  차</td>
				<td width="150" height="50" colspan="2" align="center">
					<input class="form-control" style="width:40%; padding-height:10px;" type="text" name="annual_leave" id="annual_leave" value="${employee.annual_leave}"></td>
				
			</tr>
			<tr>
				<td width="150" height="50">부  서</td>
				<td width="150" height="50" colspan="2" align="center">
					<select class="form-control" style="width:55%; padding-height:10px;" name="dept_no" id="dept_no" onchange="deptChange()">
							  <option value="" id=dept_name>부서명</option>
							  
							<c:forEach items="${department}" var="item">
								<option value="${item.dept_no}">${item.dept_name}</option>
							</c:forEach>
					</select>
				</td>
				<td>
					<input type="file" id="photo" name="photo" accept="image/*">
				</td>
			</tr>
			
			<tr>
				<td width="150" height="50">부서 우편번호</td>
				<td width="150" height="50"><div id="dept_zipcode"></div></td>
				<td width="150" height="50">부서 주소</td>
				<td width="250" height="50" align="left"><div id="dept_addr"></div></td>
			</tr>
			<tr>
				<td width="150" height="50">부서 전화번호</td>
				<td width="150" height="50"><div id="dept_phoneNum"></div></td>
				<td width="150" height="50">부서 팩스번호</td>
				<td width="250" height="50"><div id="dept_fax"></div></td>
			</tr>
			<tr>
				<td width="150" height="50" colspan="4">
				<input type="button" name="istEmpBt" id="istEmpBt" onclick="istEmployee()" value="등록" style="border:1px solid #ced4da;border-radius:.25rem;color:#495057;background-color:#fff;" > 
				<input type="button" name="bfPg" id="bfPg" onclick="location.href='sltEmp.do'" value="전 단계" style="border:1px solid #ced4da;border-radius:.25rem;color:#495057;background-color:#fff;" >
			</tr>
		</table>
	</form>
			</div>

		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
<script>

//사진 비었을때 엑박 없애기
/* 
	$(document).ready(function() {
		var img = $("#imgEmployee").val();
		$("#imgEmployee").replaceWith("<p>No image</p>");
		}
	}); */

// 이미지 선택시 파일 읽어옴
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
    	console.log("test");
	});

// 부서 정보 선택시 변경
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


// 사원 등록
	function istEmployee() { 
		
		var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf|PNG)$/;
		var maxSize = 5 * 600 * 800;
		var fileSize;
		var name = $('#name').val();
		var position = $('#position').val();
		var dept_no = $('#dept_no').val();
		var annual_leave = $('#annual_leave').val();
		
		var i = /[0-9]/;
		var hg = /[가-힣]/;
		var en = /[a-z]|[A-Z]/;

	// 이름  입력 값 체크, 
		console.log(annual_leave);
		if(name == "") {
			alert("이름을 입력해 주세요.");
		    $("#name").focus();
		    return;
		}
		if(hg.test(name) == false) {
			if(en.test(name) == false){
				alert("이름을 정확히 입력해 주세요.");
		    	$("#name").focus();
		    	return;
			}
		}

		if($('#birth').val() == "") {
			alert("생년월일을 입력해 주세요.");
		    $("#birth").focus();
		    return;
		}

	// 직급
		if(position == "") {
			alert("직급을 선택해 주세요.");
			$('#position').focus();
			return;
		}
		
	// 연차값 없거나, 정수가 아닐 경우
		if(annual_leave == ""){
			alert("연차를 입력해 주세요.");
		    $("#annual_leave").focus();
		    return;
		}
		else if(annual_leave != ""){
			
			if(i.test(annual_leave) == false){
				alert("숫자만 입력해 주세요.");
			    $("#annual_leave").focus();
			    return;
			}
		}
		
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

		
	// 부서명 .
		if(dept_no == "") {
			alert("부서를 선택해 주세요.");
			$('#dept_no').focus();
			return;
		}
		
	// 파일 등록
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

// 전단계
	/* function bfPg() {
		history.go(-1);
	} */
	
</script>
</body>
</html>