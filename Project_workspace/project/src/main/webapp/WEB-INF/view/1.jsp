<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="<%=request.getContextPath()%>/smarteditor/js/service/HuskyEZCreator.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/deptdomlist.css'/>" />

<script type="text/javascript">
	function winOpen() {
		var url = "../emplist_selectAdd.do"; //
		window.open(url, "", "width=500,height=400,left=700");
	}
</script>

<script type="text/javascript">
	// 자식창 window 객체를 저장할 변수
	var windowObj;
	function openChildWindow() {
		// 자식창을 열고 자식창의 window 객체를 windowObj 변수에 저장
		windowObj = window.open("../emplist_selectAdd.do", "",
				"width=500,height=400,left=700");
		// 자식창의 childText라는 id를 가진 태그 요소의 값에 부모창의 값을 넣음
		//windowObj.document.getElementById("empmove").name/*  = document.getElementById('parentText').value */;
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
<script>
    var oEditors = [];
    $(function() {
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "naversm", //textarea에서 지정한 id와 일치해야 합니다. 
            //SmartEditor2Skin.html 파일이 존재하는 경로
            sSkinURI : "<%=request.getContextPath()%>
	/smarteditor/SmartEditor2Skin.html",
					htParams : {
						// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseToolbar : true,
						// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseVerticalResizer : true,
						// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
						bUseModeChanger : true,
						fOnBeforeUnload : function() {

						}
					},
					fOnAppLoad : function() {
						//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
						oEditors.getById["naversm"].exec("PASTE_HTML",
								[ contents ]);
					},
					fCreator : "createSEditor2"
				});

		//저장버튼 클릭시 form 전송
		$("#save").click(function() {
			oEditors.getById["naversm"].exec("UPDATE_CONTENTS_FIELD", []);
			/* $("#write_b").submit(); */
		});
	});
</script>
</head>
<body>
	<div id="wrap">
		<jsp:include page="/WEB-INF/view/head.jsp" flush="false" />
		<section id="content">
			<div id="leftcontent">
				<ul>
					<li><a>결재진행함</a></li>
					<li><a href="domt_imok_list.do">결재완료함</a></li>
				</ul>
			</div>

			<div id="rightcontent">
				<div id="appwarp">
					<table id=apptable>
						<tr id="first">
							<td rowspan="2">결<br>제
							</td>
							<td>기안</td>
						</tr>
						<tr id="second">
							<td>${name}</td>
						</tr>
					</table>
					<h3 class="clear">휴가신청서</h3>
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

					<form action="../insert_App_And_Domt.do" method="POST"
						id="app_line_add_input">

						<input name="document_no" type="hidden" value="${document_no}">
						<input name="employee_no1" type="hidden" value="${employee_no}">
						<h1 class=textleft>제목</h1>
						<input name="subject" class="subjectf" type="text"><br>
						<h1 class=textleft>내용</h1>
						<textarea name="contents" id="naversm" class="naversm"></textarea>
						<input name="reg_date" type="hidden" class="now_date2"> <input
							name="type" type="hidden" value="1"> <input
							name="approval_no" type="hidden" value="${approval_no}">
						<input name="approval_date" type="hidden" class="now_date2">
						<input name="state" type="hidden" value="0">
						<input class="myButton2" type="button" onclick="history.go(-1)" value="취소" >
						<input class="myButton3" type="submit" id="save" value="결재요청">
						<input class="myButton3" type="button" onclick="openChildWindow()" value="결재선" />
					</form>


				</div>

			</div>

		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>
</body>

</html>
