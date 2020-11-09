<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<title>스마트에디터2.0 연결</title>
<style type="text/css">
	table, tr, td {	border-collapse: collapse;	border: solid 1px #7A7A7A;	text-align: center;}
	input, button {	border: 0px;	padding: 5px;}
</style>
<script type="text/javascript" src="se2/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
	function winOpen() {
		var url = "../emplist_selectAdd.do"; //
		window.open(url, "", "width=400,height=400,left=600");
	}
</script>
<script type="text/javascript">
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "ir1",
		sSkinURI : "../se2/SmartEditor2Skin.html",
		fCreator : "createSEditor2"
	});
</script>
</head>
<body>
	<table>
		<tr>
			<td style="background-color: #ccc;" rowspan="2">결<br>제
			</td>
			<td>작성자</td>
		</tr>
		<tr>
			<td>가져온이름</td>
		</tr>
	</table>
	<h3>스마트에디터2.0입니다</h3>
	<table style="width: 700px;">
		<tr style="font-weight: bold;">
			<td>문서번호</td>
			<td>작성일</td>
			<td>작성부서</td>
			<td>작성자</td>
		</tr>
		<tr>
			<td>151125</td>
			<td>2020-07-21</td>
			<td>개발팀</td>
			<td>김광훈</td>
		</tr>
	</table>
	<br>
	<textarea name="ir1" id="ir1" rows="10" cols="100">에디터에 기본으로 삽입할 글(수정 모드)이 없다면 이 value 값을 지정하지 않으시면 됩니다.</textarea>
	<form action="">
		<br> <input type="button" value="기안문서목록"> <input
			style="background-color: #FF4565;" type="reset" value="분노의 다시쓰기">
		<button style="background-color: #91FF3C;" onclick="winOpen();">결제추가</button>
		<button style="background-color: #3CBBFF;" onclick="">참조추가</button>
		<input style="background-color: #2970FF;" type="submit" value="작성완료">
	</form>


</body>
</html>