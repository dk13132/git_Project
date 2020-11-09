<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>
	$(function() {
		$.ajax({
			type : "post" // 포스트방식
			,url : "appLineAddForm_select_one.do" // url 주소
			,dataType : "json"
		}).done(
				function(args) { //응답이 성공 상태 코드를 반환하면 호출되는 함수
					for (var i = 0; i < args.length; i++) {
						$("#dept").append(
							"<option value='"+args[i].dept_no+"'>"
								+ args[i].dept_name + "</option>");
					}
				}).fail(function(e) {
			alert(e.responseText);
		})
	});//ready 끝

	function selectDept() {
		var dept_no = $("#dept").val();
		if (dept_no == "") {
			$("#emp option").each(function() {
				$("#emp option:eq(1)").remove();
			});
			return;
		}

		var params = "dept_no=" + dept_no;
		$.ajax({
			type : "post",
			url : "appLineAddForm_select_two.do",
			data : params,
			dataType : "json"
		}).done(
				function(args) {
					$("#emp option").each(function() {
						$("#emp option:eq(0)").remove();
					});
					$("#emp").append("<option value=''>::사원선택::</option>");

					for (var idx = 0; idx < args.length; idx++) {
						$("#emp").append(
								"<option value='"+args[idx].employee_no+"'>"
										+ args[idx].name
										+ "</option>");
					}
				}).fail(function(e) {
			alert(e.responseText);
		});
	}
	function selecEmp(){
		var employee_no=$("#emp").val();
		var params="employee_no="+employee_no;

		$.ajax({
			type:"post"
			,url:"appLineAddForm_select_thr.do"	
			,data:params
			,dataType:"json"})
			.done(function(args){
			
				var employee_no = "사원번호 : "+args.employee_no+"<br>";
				var dept_no = "부서번호 : "+args.dept_no+"<br>";
				var position = "포지션 : "+args.position+"<br>";
				var name = "이름 : "+args.name+"<br>";
				
				$("#empInfo").text("");//기존 내용 제거
				$("#empInfo").html(name);

				$("#empmove").attr('value',args.employee_no)
			})
		    .fail(function(e) {
		    	alert(e.responseText);
		    });	
	}
</script>
   <script type="text/javascript">
      function sendToParent(){
        var empno = $("#emp option:checked").val();
		$(opener.document).find("#app_line_add_input").append('<input name="employee_no1" type="hidden" value="'+empno+'"/>'); //나중에 히든추가

        var deptname = $("#dept option:checked").text();
        var name =$("#emp option:checked").text();
        $(opener.document).find("#first").append("<td>"+deptname+"</td>");
        $(opener.document).find("#second").append("<td>"+name+"</td>");
        window.close();
      }
    </script>
</head>

<body>
	<h3>인간 장바구니</h3>
	<h4>결제,참조선 추가하기</h4>
	<select id="dept" onchange="selectDept()" size="10">
		<option value="">::부서선택::</option>
	</select>
	<select id="emp" onchange="sendToParent()" size="10">
		<option value="">::사원선택::</option>
	</select>
	<div id="empInfo"></div>


</body>
</html>