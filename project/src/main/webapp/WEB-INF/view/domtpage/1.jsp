<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>휴가신청서</title>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/deptdomlist.css'/>" />
<style>
	.textar{width: 100%;}
	h2 {text-align: center;}
	h4 {margin-bottom: 10px; text-align: left;}
	#apptable{margin-bottom: 40px;}
</style>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/smarteditor/js/service/HuskyEZCreator.js"></script>

<script type="text/javascript">
	function winOpen() {
		var url = "../emplist_selectAdd.do"; //
		window.open(url, "", "width=500,height=400,left=700");
	}
</script>

<script type="text/javascript">
	var windowObj;
	function openChildWindow() {
		windowObj = window.open("../emplist_selectAdd.do", "",
				"width=500,height=400,left=700");
	}
</script>



<script type="text/javascript">
$(document).ready(function() {
	var date = new Date(); 
	var yyyy = date.getFullYear(); 
	var mm = new String(date.getMonth()+1); 
	var dd = new String(date.getDate()); 
	var nowdate = yyyy+"-"+(("00"+mm.toString()).slice(-2))+"-"+(("00"+dd.toString()).slice(-2));
	$("#now_date").html(nowdate);
	$(".now_date2").attr("value",nowdate)
    });
</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="/WEB-INF/view/head.jsp" flush="false" />
		<section id="content">
			<div id="leftcontent">
				<ul>
					<li><a href="appdomt.do">결재진행함</a></li>
					<li><a href="domt_imok_list.do">결재완료함</a></li>
				</ul>
			</div>

			<div id="rightcontent">
				<div id="appwarp">
	<table id=apptable>
		<tr id="first">
			<td style="background-color: #ccc;" rowspan="2">결<br>제
			</td>
			<td>기안</td>
		</tr>
		<tr id="second">
			<td>${name}</td>
		</tr>
	</table>
	<h2>  휴가신청서</h2>
	<table id="domtinfortable">
		<tr style="font-weight: bold;">
			<td>문서번호</td>
			<td>작성일</td>
			<td>작성부서</td>
			<td>작성자</td>
		</tr>
			<tr>
				<td>자동채번(${document_no})</td>
				<td id="now_date"></td>
				<td>${dept_name}</td>
				<td>${name}</td>
			</tr>
	</table>
	<br>
	
	<form action="../insert_App_And_Domt.do" method="POST" id="app_line_add_input">

		<input    name="document_no" type="hidden" value="${document_no}"  >
		<input    name="employee_no1" type="hidden" value="${employee_no}"  >
		<input class="textar"    name="subject" class="subject" type="text" placeholder="제목을 입력하세요"><br>
		<h4>내용</h4>
		
		<textarea class="textar" name="contents" id="naversm" class="naversm"></textarea>
		
		
		
		<input    name="reg_date"    type="hidden" class="now_date2" >
		<input    name="type"        type="hidden" value="1" >
		
		<input    name="approval_no" 	type="hidden"  value="${approval_no}" >
		<input    name="approval_date"  type="hidden"  class="now_date2" >
		<input    name="state"      	type="hidden"  value="0">
		<br><br>
		<input type="button" onclick="history.go(-1)" value="취소">
 		<input type="button" onclick="openChildWindow()"value="결재선"/>
		<input type="submit" id="save" value="결재요청">
	</form>
	
	
	</div>

			</div>

		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
</body>





























<script>
    var oEditors = [];
    $(function() {
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "naversm", 
            sSkinURI : "<%=request.getContextPath()%>/resources/smarteditor/SmartEditor2Skin.html",
					htParams : {
						bUseToolbar : true, // 툴바 사용 여부
						bUseVerticalResizer : true, // 입력창 크기 조절바 사용 여부
						bUseModeChanger : true, // 모드 탭(Editor | HTML | TEXT) 사용 여부
						fOnBeforeUnload : function() {
						}
					},
					fOnAppLoad : function() {
						oEditors.getById["naversm"].exec("PASTE_HTML",
								[ contents ]);
					},
					fCreator : "createSEditor2"
				});
		$("#save").click(function() {
			oEditors.getById["naversm"].exec("UPDATE_CONTENTS_FIELD", []);
		});
	});
</script>
</html>