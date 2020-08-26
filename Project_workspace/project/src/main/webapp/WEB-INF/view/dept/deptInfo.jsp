<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title> </title>
    <link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>"/>
    <link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>"/>
</head>


<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script>
$(function(){

	var dept_name= "";

	$(".depts").on("click", function(){

		 dept_name = $(this).attr('value'); 
		
	var url="emps.do";
	var params="dept_name="+dept_name;
	
	//$('#empList').empty();
	
	$.ajax({
		type:"get"
		,url:url	
		,data:params
		,dataType:"json"})
		.done(function(args){
			$("#empList").find("tbody:gt(0)").remove();
			
			 for(var idx=0; idx<args.length; idx++) {	

				 $("#empList").append("<tbody><tr><td width='100' align='center'>"+args[idx].name+"</td><td align='center' width='100'>"+args[idx].dept_name+"</td><td align='center' width='100'>"+args[idx].position
						 +"</td><td align='center' width='200'>"+args[idx].email+"</td><td align='center' width='200'>"+args[idx].phone+"</td></tr></tbody>");
			 } 
		})
		
	    .fail(function(e) {
	    	alert(e.responseText);
	    	
	    })	
	 });
   
});

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
							<li><a href="#">회의실</a></li>
							<li><a href="#">프로젝트</a></li>
							<li><a href="#">채팅</a></li>
							<li><a href="#">일정(캘린더)</a></li>
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
        
        	<div id="sidemenu">
        		<ul>
        		
        			<li><a class="active" href="list.do">부서관리</a></li><br>
        			<li><a href="authority.do">권한관리</a></li>
        		
        		</ul>
        		
			</div>
			
        </div>
        <div id="article">
      
				<P><h2>부서관리</h2></p>

<center><p><b>전체 부서&nbsp:&nbsp${list.count}</b></p>
<div style="position: relative;">
<form action="delete.do" method="get" name="removefrm" onsubmit="return removeCheck()">

<table border ="1" style="margin:auto" width="950">
	<tr>
		<th>순번</th>
		<th>부서no.</th>
		<th>부서명</th>
		<th>부서 주소</th>
		<th>Tel.</th>
		<th>Fax.</th>
		<th>상태</th>
	</tr>
	<c:forEach var="row" items="${list.boardList}">
	<tr>
		<td	align= "center" width="50"><c:out value="${number}"/><c:set var="number" value="${number - 1}"/></td>
		<td align= "center" width="70">${row.dept_no}</td>		
		<td width="100"><a href="javascript:void(0);" class= "depts" value = "${row.dept_name}">${row.dept_name}</a></td>
		<td width="440">${row.dept_addr}</td>
		<td align= "center" width="125">${row.dept_phoneNum}</td>
		<td align= "center" width="125">${row.fax}</td>
		<td align= "center" width="40"><input type="checkbox" id="delete_dept" name="delete_dept" value="${row.dept_no}"></td>
		
	</tr>	
	</c:forEach>	
</table>
<div style="position: relative; right:-430px; bottom:-5px;">
<button type="button" onclick="updateOpen();">수정</button>
<input type="submit" value="삭제"> 
</div>
</form>
</div>

<div>

<c:if test="${list.count > 0}">
  <c:if test="${list.p.beginPageNumber > 5}">
			<a href="list.do?p=${list.p.beginPageNumber-1}"><<</a>&nbsp
		</c:if>
		<c:forEach var="pno" begin="${list.p.beginPageNumber}" end="${list.p.endPageNumber}">
		<a href="list.do?p=${pno}">[${pno}]</a>
		</c:forEach>
		<c:if test="${list.p.endPageNumber < list.p.totalPageCount}">
			&nbsp<a href="list.do?p=${list.p.endPageNumber + 1}">>></a>
		</c:if>
		
</c:if>

</div>
<br><br><br>
<div style="magin : 0 0 100px 0;"><p><b>신규부서 등록</b></p></div>
<div></div>

<div>
<form action="insert.do" method="get" name ="deptinput"  onSubmit="return checkIt()">
<table width="780" frame="void">
<tr><td width = "280"><label for ="dept_no">부서번호&nbsp:&nbsp</label><input type="text" value="" name = "dept_no" id = "dept_no"></td>
<td><label for ="dept_name">부서명&nbsp:&nbsp</label><input type="text" value="" name = "dept_name" id = "dept_name"></td>
<td width = "213"><label for ="dept_phoneNum">Tel.&nbsp&nbsp</label><input type="text" value="" name = "dept_phoneNum" id = "dept_phoneNum"></td></tr>
<tr><td colspan="2"><label for ="zipcode">우편번호&nbsp:&nbsp</label><input type="text" value="" name = "zipcode" id = "zipcode" readonly>
<input type="button" value = "우편번호" onClick="sample4_execDaumPostcode()"></td>
<td width = "213"><label for ="fax">Fax.&nbsp&nbsp</label><input type="text" style="width:166px" value="" name = "fax" id = "fax"><br></td>
<tr><td colspan="3"><label for ="dept_addr">부서주소&nbsp:&nbsp</label><input type="text" value="" name = "dept_addr" id = "dept_addr" style="width:438px;"></td></tr>
</table>
<input type ="submit" value="등록">
</form>

</div>
<br>

<div></div>

<div>
<br>
<p><b>사원 목록</b><p>
<table id = "empList" frame="void" width="700">
<tr><th width="100" align="center">이름</th><th width="100" align="center">부서</th><th width="100" align="center">직급</th><th width="200" align="center">이메일</th><th width="200" align="center">Tel.</th></tr>

</table>
</div>

</center>
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

function removeCheck() {
	
	var delete_dept  = $("#delete_dept:checked").val();
	
	if (delete_dept == null){

		alert("부서를 선택해주세요.")
		return false;
	}	
	
	 if (confirm("정말 삭제하시겠습니까??") == true){    //확인
	     document.removefrm.submit();
	 }else{   //취소
     return false;
	 }
}
	

function sample4_execDaumPostcode() {
	   new daum.Postcode({
		    oncomplete: function(data) {
		    	 document.getElementById('zipcode').value = data.zonecode;
		         document.getElementById("dept_addr").value = data.address;
		    }
		}).open();
	}
	
function checkIt() {
    var deptinput = eval("document.deptinput");
    
    if(!deptinput.dept_no.value) {
        alert("부서번호를 입력하세요.");
        return false;
    }
  
    if(!deptinput.dept_name.value ) {
        alert("부서명을 입력하세요.");
        return false;
    }
    
    return true;
}
function updateOpen(){
	
	var checked = $("#delete_dept:checked").length;
	
	if(checked >= 2){
		alert("하나만 선택해주세요.")
		return false
	}
	
	window.name = "list"
	var update_dept = $("#delete_dept:checked").val();

	if(update_dept == null){
	alert("부서를 선택해주세요.")
	return false;
	}
	window.open('updateForm.do?delete_dept='+update_dept,'update_dept','width=560,height=300,location=no,status=no,scrollbars=yes');
	
}

</script>


</html>