<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>${dto.project_no}프로젝트의일감 게시판</title>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    var formObj = $("form[name='projectWorkWrite']");
    
    fn_addFile();

 function fn_addFile() {
    var fileIndex = 1;
    $(".fileAdd_btn")
          .on("click",
                function() {
                   $("#fileIndex")
                         .append(
                               "<div><input type='file' style='float:left;' name='file_"
                                     + (fileIndex++)
                                     + "'>"
                                     + "<button type='button' style='float:left;' id='fileDelBtn'>"
                                     + "취소"
                                     + "</button></div>"
                                     + "<br>");
                });
    $(document).on("click", "#fileDelBtn", function() {
       $(this).parent().remove();

    });
 }      
});

</script>
</head>
<body>
	<b>${dto.project_no} 프로젝트의 일감 등록</b>
	<br>
	<form method="post" name="projectWorkWrite" action="write.do" enctype="multipart/form-data">	<!-- onsubmit="return writeSave()" -->
		<table>
			<tr>
				<td width="150" height="60" align="center">일감 제목</td>
				<td width="700" height="60"><input type="text" size="40" maxlength="50" name="subject">
			</tr>
			<tr>
				<td width="150" height="60" align="center">시작 날짜</td>
				<td width="700" height="60">
				<input type="date" size="40" maxlength="10" name="start_time" value=<fmt:formatDate value="${article.start_time}" pattern="yyyy-MM-dd"/>>
			</tr>
			<tr>
				<td width="150" height="60" align="center">완료 기한</td>
				<td width="700" height="60">
				<input type="date" size="40" maxlength="10" name="end_time" value=<fmt:formatDate value="${article.end_time}" pattern="yyyy-MM-dd"/>>
			</tr>
			<tr>
				<td width="150" height="60" align="center">진행 상태</td>
				<td width="700" height="60"><select name="state">
						<option value="0" selected>진행중</option>
						<option value="1">완료</option>
						<option value="2">보류</option>
				</select>
			</tr>
			<tr>
				<td width="150" height="60" align="center">중요도</td>
				<td width="700" height="60">
				<select id="priority" name="priority">
						<option value="0" selected>보통</option>
						<option value="1">높음</option>
						<option value="2">낮음</option>
				</select>
			</tr>
			
			<tr>
				<td width="150" height="60" align="center">담당자</td>
				<td width="700" height="60">
				<select>
                  <c:forEach items="${list}" var="list">
                     <option value="${list.name}">${list.name}</option>
                  </c:forEach>
           		 </select>
			</tr>
			
			<tr>
				<td width="150" align="center">내 용</td>
				<td width="700"><textarea name="contents" rows="13" cols="40"></textarea>
				</td>
			</tr>

			<tr>
				<td width="150" height="60" align="center">첨부 파일</td>
				<td width="700" height="60" id="fileIndex">
				  &nbsp;<button type="button" class="fileAdd_btn">파일추가</button></td>
			</tr>
			<tr>
				<td colspan="2" width="900" height="20">
					
					<input type="submit" value="작성">
					<input type="button" value="취소" OnClick="window.location='list.do'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
