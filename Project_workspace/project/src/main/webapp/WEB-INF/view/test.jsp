<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title> 전자결재 </title>
    <link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>"/>
    <link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>"/>
</head>
<style type="text/css">
 a:link { text-decoration: none; color: #333}
 a:visited { text-decoration: none; color: #333}
 a:hover { text-decoration: underline;}
 
</style>

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
        <section id="header">
            <div id=headerwrap>
                <div class="logo">
                    <a href="test.do">
                        <img src="resources/img/logo.png" alt="">
                    </a>
                </div>
                <div class="gnb">
                    <div class="gnb_list">
                        <ul>
                            <li><a href="#">사원정보</a></li>
							<li><a href="#">게시판</a></li>
							<li><a href="meeting_room.do">회의실</a></li>
							<li><a href="#">프로젝트</a></li>
							<li><a href="chat_list.do">채팅</a></li>
							<li><a href="calendar.do">일정(캘린더)</a></li>
							<li><a href="#">전자결재</a></li>
							<c:if test="${mc_authority >= 3 }">
							<li><a href="list.do">관리자</a></li>
							<li><a href="#">근태관리</a></li>
							</c:if>
                        </ul>
                                      
                    </div>
                </div>
                
            </div>
        </section>
        <section id="content">
        <div id="nav">
        
        	<div id="login">
        		<br>                    
                <h1 align="left">환영합니다. ${mc_name}님</h1>
                <br>
				<button type="button">내정보</button>&nbsp;&nbsp;
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
        <div id="article">
      
				<div class="post">
			
				<h2 class="title"><a href="#">공지사항</a></h2>
				<div class="entry" style="background-color:red; height: 200px;">
					
					<table id="notice" border="1">
			
					</table>
				</div>
				
			  
			</div>
   
        </div>
        
        </section>
        <section id="foot">
            <div class="fnbwrap">

                    <ul>
                        <li>회사소개</li>
                        <li>이용약관</li>
                        <li>개인정보처리방침</li>
                        <li>스팸정책</li>
                        <li>제휴문의</li>
                    </ul>
                    <p>
                        서울특별시 서초구 서초대로77길 54 서초 W타워 13,14층 | (주)이젠아카데미 | 대표자 : 고태곤<br>
                        사업자등록번호 : 153-88-00321 | 통신판매업신고번호 : 2016-서울서초-1204 호<br>
                        Copyright Ezen IT MaraChoco TECHONOLOGY INC. All rights reserved.<br>
                    </p>

            </div>
        </section>
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