<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/deptcs.css'/>" />
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>

<script>
	$(function() {

		var url = "depts.do";

		$.ajax({
			type : "post",
			url : url,
			dataType : "json"
		}).done(
				function(args) { //응답이 성공 상태 코드를 반환하면 호출되는 함수
					for (var i = 0; i < args.length; i++) {
						$("#dept_name").append(
								"<option value='"+args[i].dept_no+"'>"
										+ args[i].dept_name + "</option>");
					}
				}).fail(function(e) {
			alert(e.responseText);
		})
	});//ready 끝

	function selectDept() {

		var dept_no = $("#dept_name").val();

		if (dept_no == "") {
			$("#position option").each(function() {
				$("#position option:eq(1)").remove();
			});

			$("#name option").each(function() {
				$("#name option:eq(1)").remove();
			});

			$("#employee_no option").each(function() {
				$("#employee_no option:eq(1)").remove();
			});

			return;
		}

		var url = "position.do";
		var params = "dept_no=" + dept_no;

		$.ajax({
			type : "post",
			url : url,
			data : params,
			dataType : "json"
		})
				.done(
						function(args) {
							$("#position option").each(function() {
								$("#position option:eq(0)").remove();
							});

							$("#position").append(
									"<option value=''>::직급선택::</option>");

							for (var idx = 0; idx < args.length; idx++) {
								$("#position").append(
										"<option value='"+args[idx].position+"'>"
												+ args[idx].position
												+ "</option>");
							}
						}).fail(function(e) {

					alert(e.responseText);
				});

	}

	function selectName() {

		var dept_no = $("#dept_name").val();
		var position = $("#position").val();

		if (position == "") {
			$("#name option").each(function() {
				$("#name option:eq(1)").remove();
			});

			$("#employee_no option").each(function() {
				$("#employee_no option:eq(1)").remove();
			});
			return;
		}

		var url = "name.do";
		var params = "position=" + position + "&dept_no=" + dept_no;

		$.ajax({
			type : "post",
			url : url,
			data : params,
			dataType : "json"
		}).done(
				function(args) {
					$("#name option").each(function() {
						$("#name option:eq(0)").remove();
					});

					$("#name").append("<option value=''>::사원선택::</option>");

					for (var idx = 0; idx < args.length; idx++) {
						$("#name").append(
								"<option value='"+args[idx].name+"'>"
										+ args[idx].name + "</option>");
					}
				}).fail(function(e) {

			alert(e.responseText);
		});

	}
	function selectNumber() {

		var name = $("#name").val();
		var dept_no = $("#dept_name").val();
		var position = $("#position").val();

		if (name == "") {
			$("#employee_no option").each(function() {
				$("#employee_no option:eq(1)").remove();
			});
			return;
		}

		var url = "employee_no.do";
		var params = "dept_no=" + dept_no + "&position=" + position + "&name="
				+ name;

		$.ajax({
			type : "post",
			url : url,
			data : params,
			dataType : "json"
		}).done(
				function(args) {
					$("#employee_no option").each(function() {
						$("#employee_no option:eq(0)").remove();
					});

					$("#employee_no").append(
							"<option value='0'>::사번선택::</option>");

					for (var idx = 0; idx < args.length; idx++) {
						$("#employee_no").append(
								"<option value='"+args[idx].employee_no+"'>"
										+ args[idx].employee_no + "</option>");
					}
				}).fail(function(e) {

			alert(e.responseText);
		});

	}

	function pushList() {

		var chk = $("#dept_name").val();

		if (chk == "") {
			alert('부서를 선택해주세요.')
			return false
		}

		var dept_no = $("#dept_name option:selected").val();
		var position = $("#position option:selected").val();
		var name = $("#name option:selected").val();
		var employee_no = $("#employee_no option:selected").val();

		var url = "pushList.do";

		var params = "dept_no=" + dept_no + "&position=" + position + "&name="
				+ name + "&employee_no=" + employee_no;

		$
				.ajax({
					type : "get",
					url : url,
					data : params,
					dataType : "json"
				})
				.done(
						function(args) {

							$("#empList2").empty();

							for (var idx = 0; idx < args.length; idx++) {

								$("#empList2")
										.append(
												"<tr><td id =부서"+idx+" align='center'>"
														+ args[idx].dept_name
														+ "</td><td id=직위"+idx+" align='center'>"
														+ args[idx].position
														+ "</td><td id=이름"+idx+" align='center'>"
														+ args[idx].name
														+ "</td><td align='center'><select id=authority"+idx+" name=authority><option value='"+args[idx].authority+"'>"
														+ args[idx].authority
														+ "</option><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option></select></td></tr>");
							}

						})

				.fail(function(e) {
					alert(e.responseText);
				})
	};
</script>

</head>
<body>
	<div id="wrap">
		<jsp:include page ="/WEB-INF/view/head.jsp" flush="false"/>
		<section id="content">
			<div id="leftcontent">
					<ul>

						<li><a href="list.do">부서관리</a></li>
						
						<li><a class="active" href="authority.do">권한관리</a></li>

					</ul>

			</div>
			<div id="rightcontent">
				
				<h2>권한 관리</h2>
					
					<h4>조 회</h4>
					
					<table>
						<tr>
							<td><label for="dept_name"><b>부서명&nbsp;:&nbsp;</b></label>
								<select id="dept_name" name="dept_name" onchange="selectDept()">
									<option value="">::부서선택::</option>
							</select></td>


							<td><label for="position"><b>직급&nbsp;:&nbsp;</b>
							</label> <select id="position" name="position" onchange="selectName()">
									<option value="">::직급선택::</option>
							</select></td>

							<td><label for="name"><b>사원선택&nbsp;:&nbsp;
								</b></label> <select id="name" name="name" onchange="selectNumber()">
									<option value="">::사원선택::</option>
							</select></td>

							<td><label for="employee_no"><b>사번선택&nbsp;:&nbsp;
								</b></label> <select id="employee_no" name="employee_no">
									<option value="0">::사번선택::</option>
							</select></td>
						</tr>
					</table>
					
					<div class="btncenter">
					<button class="myButt" onclick="pushList()">조회</button>
					</div>
					<div id="bttbl">
					<h4>사원정보</h4>
					

					<table id="empList">
						<thead>
							<tr>
								<th width="200" align="center">부 서</th>
								<th width="200" align="center">직 위</th>
								<th width="200" align="center">이 름</th>
								<th width="100" align="center">권 한</th>
							</tr>
						</thead>
						<tbody id='empList2'>

						</tbody>
					</table>
					<div class="btncenter">
					<!-- <button type ="button" style="width:70px;" id="update" name="update" onclick="update();">수정</button> -->
					<button class="myButt" type="button" id="test" name="test"
						onclick="test();">수 정</button>
					</div>
					</div>
			</div>
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp"  flush="false"/>
	</div>

</body>
<script>
	function test() {

		var list = [];
		var trn = $("#empList2 tr").length;//동적 테이블 tr 갯수
		/* var tdn = $("#empList2 tr:eq(0) td").length;//동적 테이블 n번째 td 갯수
		 */

		var url = "update_auto1.do";

		for (var i = 0; i < trn; i++) {
			var data = {
				dept_name : $("#empList2 tr:eq(" + i + ") td:eq(0)").text(),
				position : $("#empList2 tr:eq(" + i + ") td:eq(1)").text(),
				name : $("#empList2 tr:eq(" + i + ") td:eq(2)").text(),
				authority : $("#authority" + i + "").val()
			};

			list.push(data);
		}
		var emName = JSON.stringify(list);

		jQuery.ajaxSettings.traditional = true;

		/* 	alert(emName)  */

		$.ajax({
			type : "post",
			url : url,
			data : emName,
			contentType : 'application/json',
			dataType : 'json'
		}).done(function(args) {

			if (args == 1) {
				alert("수정되었습니다.")
			}

			if (args != 1) {
				alert("다시 시도해주세요.")
				return false;
			}

		}).fail(function(e) {

			alert(e.responseText);
		});

	}

	/* function update(){

	 var idx = 0;
	 var dept_name = document.getElementById('부서'+idx).innerText;
	 var position = document.getElementById('직위'+idx).innerText;
	 var name = document.getElementById('이름'+idx).innerText;	 
	 var authority = $("#authority").val(); 
	
	 var url="update_auto.do";
	
	 var params="dept_name="+dept_name+"&position="+position+"&name="+name+"&authority="+authority;
	
	
	 $.ajax({
	 type:"post"
	 ,url:url	
	 ,data:params})
	 .done(function(args){

	 if(args == 1){
	 alert("수정되었습니다.")
	 }

	 if(args != 1){
	 alert("다시 시도해주세요.")
	 return false;
	 }
	
	 })
	 .fail(function(e) {

	 alert(e.responseText);
	 });		

	 };
	 */
</script>

</html>