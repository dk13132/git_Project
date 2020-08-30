<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>사원 정보 조회</title>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>
   $(document).ready(function(){
      $("#istEmp").on('click',function istemp() {
         var form = document.getElementById('employee');
         form.action = 'empInsert.do';
         form.method = 'post';
         form.submit();
      }); // istemp 끝
      
      // 사원 상세 조회
      $("#sltDtlEmp").on('click',function () {
         var form = document.getElementById('employee');
         form.action = 'sltDtlEmp.do';
         form.method = 'post';
         form.submit();
      }); // sltdtlemp 끝
      
      // 사원 삭제
      $("#dltEmp").on('click', function () {
         
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
      }); // dltemp 끝


      $("istEmp").on('click'), function() {
    	  var form = document.getElementById('employee');
          form.action = 'empInsert.do';
          form.method = 'post';
          form.submit();
          }
      

      // 사원 정보 변경
      $("#position").on('change', function() {
         var position = $("#position option:selected").val();
         $.ajax({
            type : "POST",
            url : "sltFtEmp.do",
            data : "position=" + $("#position option:selected").val(),
            dataType : "json",
            success :   function(data) {
                	$("#sltFtEmpList").html("");
       		   var inner = '';
				
         		if(data.employee.length != 0){
      		      for(var i = 0; i < data.employee.length; i++){
       		       var employee = data.employee[i];
      		        inner += '<tr>';
          		    inner += '<td><input type="radio" name = "employee_no" id="employee_no" value="' + employee.employee_no + '"></td>';
   		           	inner += '<td>'+ employee.dept_name +'</td>';
      		        inner += '<td>'+ employee.position +'</td>';
          		    inner += '<td>'+ employee.name +'</td>';
          		    inner += '<td>'+ employee.employee_no +'</td>';
            		inner += '<td>'+ employee.phone +'</td>';
              		inner += '<td>'+ employee.email +'</td>';
              		inner += '</tr>';
            		}
          	}
          		$("#sltFtEmpList").append(inner);
            }
            });
      });
      
      $("#dept_no").on('change', function() {
         var dept_no = $("#dept_no option:selected").val();
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
        		        inner += '<tr>';
            		    inner += '<td><input type="radio" name = "employee_no" id="employee_no" value="' + employee.employee_no + '"></td>';
     		           	inner += '<td>'+ employee.dept_name +'</td>';
        		        inner += '<td>'+ employee.position +'</td>';
            		    inner += '<td>'+ employee.name +'</td>';
            		    inner += '<td>'+ employee.employee_no +'</td>';
              			inner += '<td>'+ employee.phone +'</td>';
                		inner += '<td>'+ employee.email +'</td>';
                		inner += '</tr>';
              		}
            	}
            		$("#sltFtEmpList").append(inner);
            	}
            });
      });

      
   }); // 레디 끝

</script>
</head>
<body>

    <b><font size="6" color="gray">사원 정보 조회</font></b>
    <br><br>
<form id = "employee">
    <table>    
       <tr align="center">
       <td/>
         <td><select name="dept_no" id="dept_no">
               <option value="">부서명</option>
            <c:forEach items="${department}" var="department">
               <option value="${department.dept_no}">${department.dept_name}</option>
            </c:forEach>
            </select>
         </td>
         <td>
            <select name="position" id="position">
                  <option value="">직급명</option>
                  <option value="주임">주임</option>
                  <option value="대리">대리</option>
                  <option value="팀장">팀장</option>
                  <option value="과장">과장</option>
                  <option value="부장">부장</option>
            </select></td>
            <td>이름</td>
            <td>사번</td>
            <td>전화번호</td>
            <td>이메일</td>
        </tr>
      <tbody id = "sltFtEmpList">  
      <c:forEach items="${employee}" var="employee">          
        <tr>
           <td><input type="radio" name = "employee_no" id="employee_no" value="${employee.employee_no}"></td>
            <td>${employee.dept_name}</td>
            <td>${employee.position}</td>
            <td>${employee.name}</td>
            <td>${employee.employee_no}</td>
            <td>${employee.phone}</td>
            <td>${employee.email}</td>
        </tr>
    </c:forEach>
    </tbody>
    </table>
    </form>
    <input type="button" name="istEmp" id="istEmp" value="신규 사원 등록">
    <input type="button" name="sltDtlEmp" id="sltDtlEmp" value="상세 조회">
    <input type="button" name="dltEmp" id="dltEmp" value="사원 삭제">
     


</body>
</html>