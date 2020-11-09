<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title> 전자결재 </title>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/depinfo.css'/>" />
<style type="text/css">
.iframebox {
 position: relative; top:0px; left: 0px; }

.iframebox iframe { position: absolute; width: 100%; height: 100%;
}​

</style>
</head>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<script>
$(function(){
	
	var url="notice.do";
	
	$.ajax({
		type:"post"		
		,url:url		
		,dataType:"json" })
		.done(function(args){	//응답이 성공 상태 코드를 반환하면 호출되는 함수
			 for(var i=0; i < args.length; i++) {
				 
				var date = moment(args[i].reg_date).format('YY-MM-DD');
			
				 $("#notice").append(
						 
				 	"<tr><td><a href='#'>"+args[i].subject+"</a></td><td>&nbsp;&nbsp;&nbsp;</td><td>"+date+"</td></tr>");
			 }	
			 						
 			})
	    .fail(function(e) {
	    	alert(e.responseText);
	    })
});//ready 끝
</script>

<body>
    <div id="wrap">
        <jsp:include page ="/WEB-INF/view/head.jsp" flush="false"/>
        <section id="content">
        <div id="leftcontent">
        
        	<div id="login">
        		<br>                    
                <h1 align="left">환영합니다. ${mc_name}님</h1>
                <br>
				<button type="button" onclick="location.href='conPw.do'">내정보</button>&nbsp;&nbsp;
				<button type="button" onclick="javascript:location.href='logout.do'">로그아웃</button>	
			</div>
			
			<div id="cal">
				<table id="calendar" frame="void">
				    <tr>
				        <td><label onclick="prevCalendar()"><<</label></td>
				        <td align="center" id="tbCalendarYM" colspan="5">
				        yyyy년 m월</td>
				        <td><label onclick="nextCalendar()">>>
					            
				        </label></td>
				    </tr>
				    <tr>
				        <td align="center"><font color ="#F79DC2">일</td>
				        <td align="center">월</td>
				        <td align="center">화</td>
				        <td align="center">수</td>
				        <td align="center">목</td>
				        <td align="center">금</td>
				        <td align="center"><font color ="skyblue">토</td>
					    </tr> 
					</table>
         	</div>
        </div>
        <div id=rightcontent>
        
			
        </div>
        
        </section>
        <jsp:include page="/WEB-INF/view/foot.jsp"  flush="false"/>
    </div>

</body>
<script>
        var today = new Date();
        var date = new Date();
        function prevCalendar() {
         today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
         buildCalendar(); 
        }
 
        function nextCalendar() {
             today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
             buildCalendar();
        }
        function buildCalendar(){
            var doMonth = new Date(today.getFullYear(),today.getMonth(),1);
            
            var lastDate = new Date(today.getFullYear(),today.getMonth()+1,0);
            
            var tbCalendar = document.getElementById("calendar");
           
            var tbCalendarYM = document.getElementById("tbCalendarYM");
             
             tbCalendarYM.innerHTML = today.getFullYear() + "년 " + (today.getMonth() + 1) + "월"; 
 
             
            while (tbCalendar.rows.length > 2) {
            
                  tbCalendar.deleteRow(tbCalendar.rows.length-1);
                  
             }
             var row = null;
             row = tbCalendar.insertRow();
             
             var cnt = 0;
             for (i=0; i<doMonth.getDay(); i++) {
            
                  cell = row.insertCell();
                  cnt = cnt + 1;
             }
           
             for (i=1; i<=lastDate.getDate(); i++) { 
             
                  cell = row.insertCell();
                  cell.innerHTML = i;
                  cnt = cnt + 1;
              if (cnt % 7 == 1) {
                cell.innerHTML = "<font color=#F79DC2>" + i
                
            }    
              if (cnt%7 == 0){
                  cell.innerHTML = "<font color=skyblue>" + i
                  
                   row = calendar.insertRow();
                   
              }
              
              if (today.getFullYear() == date.getFullYear()
                 && today.getMonth() == date.getMonth()
                 && i == date.getDate()) {
                  
                cell.bgColor = "#FAF58C"; 
               }
             }
        }
</script>
<script>
    buildCalendar();
</script>

</html>