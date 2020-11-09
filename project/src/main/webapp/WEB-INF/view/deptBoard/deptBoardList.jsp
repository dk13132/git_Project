<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/component.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/table.css'/>" />
<link rel="stylesheet" href="<c:url value='/resources/css/tablebtn.css'/>" />
<head>
<title>게시판</title>
<style>
#link a:link {
	text-decoration: none;
	color: black;
	box-shadow: 0 -6px rgba(75, 112, 253, 0.3) inset;
}

#link a:visited {
	text-decoration: none;
	color: black;
	box-shadow: 0 -6px rgba(140, 89, 185, 0.3) inset;
}

#link a {
	display: inline;
}

#link {
	
}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	function btnSearch() {
		$("#btnSearch").click(function(e) {
			e.preventDefault();
			var url = "${getBoardList}";
			url = url + "?searchType=" + $('#searchType').val();
			url = url + "&keyword=" + $('#keyword').val();
			location.href = url;
			console.log(url);
		});
	};

	function search() {

		var searchType = document.getElementsByName("searchType")[0].value;
		var keyword = document.getElementsByName("keyword")[0].value;
		console.log(searchType)
		console.log(keyword)

		location.href = "searchList?p=1" + "&searchType=" + searchType
				+ "&keyword=" + keyword;

	};
</script>
<script>

 
$(document).ready(function(){
    //최상단 체크박스 클릭
    $("#checkall").click(function(){
        //클릭되었으면
        if($("#checkall").prop("checked")){
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
            $("input[name=chk]").prop("checked",true);
            //클릭이 안되있으면
        }else{
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
            $("input[name=chk]").prop("checked",false);
        }
    })
    /* 삭제 처리*/
    $("#delete_btn").on('click', function () {
            
            var result = confirm("정말 삭제하시겠습니까?");
            if (result) {
               $.ajax({
                  type : "POST",
                  url : "DeptBoardDelete.do",
                  data : "board_no=" + $("#boardck:checked").val()
               }).done(function(data){   
                     alert("삭제되었습니다.");
                     location.reload();
                  });
            }else {
               alert("취소되었습니다.");
            }
                        
         }); 
});

 


</script>

<body onload="btnSearch()">
	<div id="wrap">
		<jsp:include page="/WEB-INF/view/head.jsp" flush="false" />
		<section id="content">

			<div id="leftcontent">
				<ul>
					<li><a class="active" href="blist.do">공지사항 게시판</a></li>
					<li><a href="deptBoardList.do?type=2">부서 게시판</a></li>
				</ul>
			</div>


			<div id="rightcontent">

				<form>
					<input type="hidden" name="type" value="2"> 
					<input type="hidden" name="dept_no" value="${board.dept_no}"> 
					<input type="hidden" name="employee_no" value="${mc_employee_no}"> 
					
					<input type="hidden" name="authority" value="3">
						<input type="hidden" name="board_no" value="${ board_no }"> 
						<br>
						<b>부서 게시판</b><br>
					<br>
				


					<c:if test="${list.count == 0}">
						<table width="880" cellpadding="0" cellspacing="0" align="center">
							<tr>
								<td align="center">게시판에 저장된 글이 없습니다.</td>
							</tr>
							
						</table>
					
					</c:if>

					<c:if test="${list.count > 0}">
						<table width="880" cellpadding="0" cellspacing="0" align="center">

							<tr height="45">
								<td align="center" width="50">번 호</td>
								<td align="center" width="280">제 목</td>
								<td align="center" width="130">작성자</td>
								<td align="center" width="170">작성일</td>
								<td align="center" width="100">조 회</td>
								<c:if test="${authority && board.authority == 3}">
								<td align="center" width="50">
								<input type="checkbox" name="checkbox" id="checkall"></td>
								</c:if>

							</tr>

							<c:forEach var="board" items="${list.boardList}">
								<tr height="45">
									<td align="center" width="50"><c:out value="${number}" />
										<c:set var="number" value="${number - 1}" /></td>
									<td align="center" width="280"><a
										href="deptContent.do?board_no=${board.board_no}&p=${list.requestPage}">${board.subject}</a></td>
									<td align="center" width="130">${board.name}</td>
									<td align="center" width="170"><fmt:formatDate
											value="${board.reg_date}" type="date" dateStyle="long" /></td>
									<td align="center" width="100">${board.readcount}</td>
									<c:if test="${authority && board.authority == 3}">					
									<td align="center" width="50">
									<input type="checkbox" name="chk" id="boardck" value="${board.board_no}"
										onclick="fn_checked(this,${board.board_no});"></td>
									
									</c:if>

								</tr>
							</c:forEach>
							
					</table>
					<div id="listButton"> 
						<input id="write_btn" type="button" value="글쓰기" onclick="document.location.href='deptWrite.do'">
						<c:if test="${authority && board.authority == 3}">
						<input id="delete_btn" type="button" value="글삭제" onclick="fn_Delete()">
						</c:if>
					</div>
					</c:if>
					<br>
					<div id="page">
					<c:if test="${list.count > 0}">
						<c:if test="${list.p.beginPageNumber > 10}">
							<a href="deptBoardList.do?p=${list.p.beginPageNumber-1}">이전</a>
						</c:if>
						<c:forEach var="pno" begin="${list.p.beginPageNumber}"
							end="${list.p.endPageNumber}">
							<a href="deptBoardList.do?p=${pno}">[${pno}]</a>
						</c:forEach>
						<c:if test="${list.p.endPageNumber < list.p.totalPageCount}">
							<a href="deptBoardList.do?p=${list.p.endPageNumber + 1}">다음</a>
						</c:if>
					</c:if>
					</div>
					<br>
					<div id="filter" align="center">
					<select name="searchType" id="searchType"
						style="padding: 1px 2px 3px 1px;">
						<option value="subject" ${searchType == "subject"?"selected":""}>제목</option>
						<option value="name" ${searchType == "name"?"selected":""}>작성자</option>
					</select> <input name="keyword" id="keyword" type="text"> <input
						name="btnSearch" id="btnSearch" type="button" value="검색">
					<br>

					</div>
					<br>
				</form>
			</div>
		</section>
		<jsp:include page="/WEB-INF/view/foot.jsp" flush="false" />
	</div>

</body>
</html>