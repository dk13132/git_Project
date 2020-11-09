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
<title>사원 정보 조회</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<style>
/*
.fixed_top {
	display:inline-table;
	position:absolute;
}

#scroll-bar{
	overflow:scroll;
	width:invisible;
	height:430px;
}
*/
table.tableBodyScroll tbody {
  display: block;
  max-height: 500px;
  overflow-y: scroll;
}

table.tableBodyScroll thead, table.tableBodyScroll tbody tr {
  display: table;
  width: 100%;
  table-layout: fixed;
}
.tableBodyScroll tr td{
     text-align: center;
}
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
			<div id="rightcontent" style="padding-top:3%; border-left:2px solid #f0f0f0; padding-left:10%; padding-bottom:10%; background: white;min-height: 600px;"><b>
			    <font size="6" color="gray">사원 정보 조회</font></b><br><br>
				<form id = "employee">
				<div id="scroll-bar">
    				<table class="tableBodyScroll " style=" ">
    					<thead >    
       						<tr align="center" height="30px">
					        <td style="width: 50px; text-align: center;"/>
         					<td style="width:100px;">
         						<select name="dept_no" id="dept_no" style="padding:3%; border:1px solid #ced4da; border-radius:.25rem; color:#495057; background-color:#fff;">
					               	<option value="">부서명</option>
            					   	<c:forEach items="${department}" var="department">
               							<option value="${department.dept_no}">${department.dept_name}</option>
            						</c:forEach>
            					</select>	
         					</td>
         					<td style="width:100px;">
            					<select name="position" id="position" style="padding:3%; border:1px solid #ced4da; border-radius:.25rem; color:#495057; background-color:#fff;">
					                <option value="">직급명</option>
        	          				<option value="주임">주임</option>
    	              				<option value="대리">대리</option>
					                <option value="팀장">팀장</option>
                  					<option value="과장">과장</option>
                  					<option value="부장">부장</option>
            					</select>
            				</td>
            				<td style="width:100px;">이름</td>
            				<td style="width:100px;">사번</td>
            				<td style="width:150px;">전화번호</td>
				            <td style="width:200px;">이메일</td>
        				</tr>
        			</thead>
      			<tbody id = "sltFtEmpList" >  
      				<c:forEach items="${employee}" var="employee">
        				<tr height="50px">
           					<td style="width:50px; text-align: center;">
           						<input type="radio" name = "employee_no" id="employee_no" value="${employee.employee_no}"></td>
            				<td style="width:100px">${employee.dept_name}</td>
            				<td style="width:100px;">${employee.position}</td>
            				<td style="width:100px;">${employee.name}</td>
            				<td style="width:100px;">${employee.employee_no}</td>
            				<td style="width:150px;">${employee.phone}</td>
            				<td style="width:200px;">${employee.email}</td>
        				</tr>
 				   </c:forEach>
    			</tbody>
    		</table>
    	</div>
	</form>
		<div style="width: 100%; text-align: right; padding-top:15px; border:0px solid #ced4da; border-radius:.25rem; color:#495057; background-color:#fff;">
  			<input type="button" name="instEmp" id="instEmp" value="신규 사원 등록" onclick="location.href='empInsert.do'" style="border:1px solid #ced4da; border-radius:.25rem; color:#495057; background-color:#fff;">
   			<input type="button" name="sltDtlEmp" id="sltDtlEmp" value="상세 조회" style="border:1px solid #ced4da; border-radius:.25rem; color:#495057; background-color:#fff;">
   		 	<input type="button" name="dltEmp" id="dltEmp" value="사원 삭제" style="border:1px solid #ced4da; border-radius:.25rem; color:#495057; background-color:#fff;">
		</div></div>
	</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
</div>
<script>
   $(document).ready(function(){
      
         // 에이작스 쓰고 sltEmp.do 호출하기.
         // 등록 성공/실패 여부에 따라 알럿창띄워주게 (db가 다운되던 뭐하던 해서 실패한느 경우가잇고, 그 결과를 사용자에게 보여줘야함.)
         // 유효성 체크 >>> 입력 안되면 입력해주세요 하고, 막게.
         
      // 사원 상세 조회
      $("#sltDtlEmp").on('click',function () {
    	  var checked = $("input:radio[name='employee_no']").is(":checked");

      	 if(checked == true) { 
      		 var form = document.getElementById('employee');
	         form.action = 'sltDtlEmp.do';
        	 form.submit();
      	 }else {
	         alert("조회할 사원을 선택해 주세요.");
      	 }
      }); // sltdtlemp 끝
      
      // 사원 삭제
      $("#dltEmp").on('click', function () {
		 var checked = $("input:radio[name='employee_no']").is(":checked");
         if (checked == true) { 
        	var result = confirm("정말 삭제하시겠습니까?"); 
       	 	if (result) {
            	$.ajax({
               		type : "POST",
               		url : "dltEmp.do",
               		data : "employee_no=" + $("input[name='employee_no']:checked").val(),
               		dataType : "json",
               		success : function(map) {   
                  		if(map.errCode == "1") {
                     		alert(map.errMsg);
                     		location.reload();
                  		}
                  		else if(map.errCode =="0") {
                     		alert(map.errMsg);
                  		}
               		}
            	});
         	}else {
            	alert("취소되었습니다.");
         	}
         } else {
	         alert("삭제할 사원을 선택해 주세요.");
         } 
      }); // dltemp 끝

      
		// 사원 부서 필터 변경
      $("#dept_no").on('change', function() {
          var dept_no = $("#dept_no option:selected").val();

			// 직급 필터 초기화.
      	  $("#position option:eq(0)").prop("selected", true);
          $.ajax({
             type : "POST",
             url : "sltFtEmp.do",
             data : "dept_no=" + $("#dept_no option:selected").val(),
             dataType : "json",
             success :  
                 function(data) {
           		  $("#sltFtEmpList").html("");
          		   var inner = '';
            		if(data.employee.length != 0){
         		      for(var i = 0; i < data.employee.length; i++){
          		        var employee = data.employee[i];
						
						if(employee.phone == null){phone = "";}
							else{phone = employee.phone;}
						if(employee.email == null){email = "";}
							else{email = employee.email;}
						
						
          		       
         		        inner += '<tr height="50px">';
             		    inner += '<td style="width:50px; text-align: center;"><input type="radio" name = "employee_no" id="employee_no" value="' + employee.employee_no + '"></td>';
      		           	inner += '<td style="width:100px">'+ employee.dept_name +'</td>';
         		        inner += '<td style="width:100px">'+ employee.position +'</td>';
             		    inner += '<td style="width:100px">'+ employee.name +'</td>';
             		    inner += '<td style="width:100px">'+ employee.employee_no +'</td>';
               			inner += '<td style="width:150px">'+ phone +'</td>';
                 		inner += '<td style="width:200px">'+ email +'</td>';
                 		inner += '</tr>';
               		}
             	}
             		$("#sltFtEmpList").append(inner);
             	}
             });
       });
      

      // 사원 직급 필터 변경
      $("#position").on('change', function() {
        var position = $("#position option:selected").val();
        	$.ajax({
            	type : "POST",
            	url : "sltFtEmp.do",
            	data : "dept_no=" + $("#dept_no option:selected").val() + "&position=" + $("#position option:selected").val(),
            	dataType : "json",
            	success :   
                	function(data) { 
    					$("#sltFtEmpList").html("");
       		   			var inner = '';
       		   			if(data.employee.length != 0){
      		      			for(var i = 0; i < data.employee.length; i++){
       		       				var employee = data.employee[i];

       							if(employee.phone == null){phone = "";}
       								else{phone = employee.phone;}
       							if(employee.email == null){email = "";}
       								else{email = employee.email;}

	       		       			inner += '<tr height="50px">';
    	             		    inner += '<td style="width:50px; text-align: center;"><input type="radio" name = "employee_no" id="employee_no" value="' + employee.employee_no + '"></td>';
        	  		           	inner += '<td style="width:100px">'+ employee.dept_name +'</td>';
            	 		        inner += '<td style="width:100px">'+ employee.position +'</td>';
                	 		    inner += '<td style="width:100px">'+ employee.name +'</td>';
                 			    inner += '<td style="width:100px">'+ employee.employee_no +'</td>';
                   				inner += '<td style="width:150px">'+ phone +'</td>';
                     			inner += '<td style="width:200px">'+ email +'</td>';
                     			inner += '</tr>';
       		       				}
          				}
          				$("#sltFtEmpList").append(inner);
            		}
           	});
         });      
   }); // 레디 끝

</script>

</body>
</html>