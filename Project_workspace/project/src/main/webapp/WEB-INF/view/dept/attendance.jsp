<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
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
<P><h2>근태 현황</h2></p><br>

<div>
<form action="attenList.do" method="get" onsubmit="return checkVal();">
<label for="start_time"><b>조회일자</b></label>&nbsp&nbsp
<input type="date" size="40" maxlength="50"  name="start_time" id="start_time">

<!-- <input type="date" size="40" maxlength="50"  name="start_time" id="start_time" 
value="<fmt:formatDate value="${list.boardList.start_time}" pattern="yyyy-MM-dd"/>"> -->

<!-- <input type="date" size="40" maxlength="50" name="end_time" id="end_time"> -->

<input type="submit" value = "조회">

</form><br>
   
<table id = "empList" frame="void" width="700">
<tr><th align="center"></th><th align="center">
<select id = "dept_name" name="dept_name" style="text-align-last:center"><option value="">부서</option></select>
</th><th align="center">직급</th><th align="center">이름</th>
<th align="center">일자</th><th align="center">출근시간</th><th align="center">퇴근시간</th><th align="center">구분</th>

</table>           


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