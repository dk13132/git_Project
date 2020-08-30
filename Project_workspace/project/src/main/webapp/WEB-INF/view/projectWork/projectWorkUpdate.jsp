<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>${project_no}프로젝트의 일감 게시판</title>
<style type='text/css'>
a:link {
	color: black;
	text-decoration: none; }
a:visited { }
a:active {
	text-decoration: underline;}
a:hover {
	text-decoration: underline;
	background-position: 50% 100%;}
</style>
<style>
<!--
@font-face {
	font-family: 굴림;
	src: url();
}
body, td, a, div, p, pre, input, textarea {
	font-family: 굴림;
	font-size: 9pt;
}
-->
</style>
</head>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
   $(document).ready(function(){
      var formObj = $("form[name='projectWorkUpdate']");
      $(document).on("click", "#fileDel", function() {
         $(this).parent().remove();
      });  
      fn_addFile();
	});
   
   function fn_valiChk(){
		var updateForm = $("form[name='projectWorkUpdate'] .chk").length;
		for(var i = 0; i<updateForm; i++){
			if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
				alert($(".chk").eq(i).attr("subject"));
				return true;
			}
		}
	}

   function fn_addFile() {
      var fileIndex = 1;
      $(".fileAdd_btn")
            .on("click", function() {
                     $("#fileIndex")
                           .append(
                                 "<div>&nbsp;<input type='file' style='float:left;' name='file_"
                                       + (fileIndex++)
                                       + "'>"
                                       + "<button type='button' style='float:left;' id='fileDelBtn'>"
                                       + "취소"
                                       + "</button></div>");
                  });
      $(document).on("click", "#fileDelBtn", function() {
         $(this).parent().remove();

      });
   }

  var fileNoArry = new Array();
  var fileNameArry = new Array();
      
   function fn_del(value, name) {

        fileNoArry.push(value);
        fileNameArry.push(name);
        $("#fileNoDel").attr("value", fileNoArry);
        $("#fileNameDel").attr("value", fileNameArry);
  }
</script>

<body>
	<header>
	<h1>${project_no} 프로젝트의 일감 등록</h1>
	</header>
	<section id="container">
		<form name="projectWorkUpdate" action="update.do" role="form"  method="post" enctype="multipart/form-data">
			<input type="hidden" name="work_no" value="${article.work_no}" readonly="readonly"/>
			<input type="hidden" name="_method" value="put" />
			<input type="hidden" id="searchType" name="searchType" value="${search.searchType}"> 
			<input type="hidden" id="keyword" name="keyword" value="${search.keyword}"> 
			<input type="hidden" id="fileNoDel" name="fileNoDel[]" value=""> 
			<input type="hidden" id="fileNameDel" name="fileNameDel[]" value=""> 
		<table>
			<tr>
				<td width="300" height="60" align="center">일감 제목 명</td>
				<td width="700" height="60"><input type="text" size="40" maxlength="50" name="subject" value="${article.subject}">
			</tr>
			<tr>
				<td width="300" height="60" align="left">시작 날짜</td>
				<td width="700" height="60"><input type="date" size="40" maxlength="10" name="start_time"
					value=<fmt:formatDate value="${article.start_time}" pattern="yyyy-MM-dd"/>>
			</tr>			
			<tr>
				<td width="300" height="60" align="left">완료 날짜</td>
				<td width="700" height="60"><input type="date" size="40" maxlength="10" name="end_time"
					value=<fmt:formatDate value="${article.end_time}" pattern="yyyy-MM-dd"/>>
			</tr>
			
			<tr>
				<td width="300" height="60" align="left">진행 상태</td>
				<td width="700" height="60">
				<select id="state" name="state" value="${article.state}">
						<option value="0" selected>진행중</option>
						<option value="1">완료</option>
						<option value="2">보류</option>
				</select>
			</tr>
			
			<tr>
				<td width="300" height="60" align="left">중요도</td>
				<td width="700" height="60">
				<select id="priority" name="priority" value="${article.priority}">
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
				<td width="300" align="center">내 용</td>
				<td width="700"><input type="text" size="40" maxlength="10" name="contents" value="${article.contents}">
				</td>
			</tr>
			
			<tr>
            <td width="185" align="center">첨부 파일</td>
            <td align="left" width="555" id="fileIndex">    
            &nbsp;<button type="button" class="fileAdd_btn">파일추가</button><br>
               <c:forEach var="file" items="${file}" varStatus="var"> 
                  <input type="hidden" id="file_no" name="file_no_${var.index}" value="${file.file_no}">
                  <input type="hidden" id="file_name" name="file_name" value="file_no_${var.index}">
                  <input type="hidden" id="file_path" name="file_path" value="file_no_${var.index}">
                  <input type="hidden" id="del_ch" name="del_ch" value="${file.del_ch}">
                  <c:if test="${ file.del_ch == 'N'}">
                  <div>
                  &nbsp;<a href="#" id="fileName" onclick="return false;">${file.file_name}</a>&nbsp;(${file.filesize}kb)
                  <button id="fileDel" onclick="fn_del('${file.file_no}','file_no_${var.index}');" type="button">삭제</button><br>                        
                  </div>
                  </c:if>
               </c:forEach>
            </td>   
         </tr>	 
		<tr><td colspan="2" width="900" height="20">
			<input type="submit" value="저장">
			<button type="button" class="cancel_btn" onclick="document.location.href='list.do?p=${pageNum}'">취소</button>
		</td></tr>		
		</table>
		</form>
		</section>		
		
</body>
</html>