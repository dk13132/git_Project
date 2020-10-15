<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>

<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/deptcs.css'/>" />
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>

<script>

$(function(){

	var url="depts.do";
	
	$.ajax({
		type:"post"		
		,url:url		
		,dataType:"json" })
		.done(function(args){	//응답이 성공 상태 코드를 반환하면 호출되는 함수

			 for(var i=0; i < args.length; i++) {
				 $("#dept_name").append("<option value='"+args[i].dept_no+"'>"+args[i].dept_name+"</option>");
			 }
 			})
	    .fail(function(e) {
	    	alert(e.responseText);
	    })
});//ready 끝


</script>

</head>
<body>
	<div id="wrap">
		 
		<jsp:include page ="/WEB-INF/view/head.jsp" flush="false"/>
		
		<section id="content">
			<div id="leftcontent">	
					<ul>
						
						<li><a class="active" href="attendance.do">근태 현황</a></li>
						
					</ul>
			</div>
			
			<div id="rightcontent">

				<h2>근태 현황</h2>

				<div class="bttbl1">
				
				<form class="alin" action="attenList.do" method="get" onsubmit="return checkVal();">
				<label for="start_time"><b>조회일자</b></label>&nbsp;&nbsp;
				<input type="date" name="start_time" id="start_time">
				
				<!-- <input type="date" size="40" maxlength="50"  name="start_time" id="start_time" 
				value="<fmt:formatDate value="${list.boardList.start_time}" pattern="yyyy-MM-dd"/>"> -->
				
				<!-- <input type="date" size="40" maxlength="50" name="end_time" id="end_time"> -->
				
				<input class="myButt" type="submit" value = "조회">
				
				</form>
				 
				<table id = "empList">
				<tr><th></th><th>
				<select id = "dept_name" name="dept_name"><option value="">부서</option></select>
				</th><th>직급</th><th>이름</th>
				<th>일자</th><th>출근시간</th><th>퇴근시간</th><th>구분</th>
				
				</table>           
				
				</div>

			</div>
		</section>
		 <jsp:include page="/WEB-INF/view/foot.jsp"  flush="false"/>
	</div>
	

</body>

<script>
function checkVal(){
	
	var ch = $("#start_time").val();

	if(ch == ''){
		alert('일자를 선택해주세요.')
		return false;
		}
	}



</script>
</html>