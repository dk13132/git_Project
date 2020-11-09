<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
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
                       	    <c:if test="${mc_authority >= 3 }">
                            <li><a href="sltEmp.do">사원정보</a></li>
                            </c:if>
							<li><a href="blist.do">게시판</a></li>
							<li><a href="meeting_room.do">회의실</a></li>
							<li><a href="projectSearch.do">프로젝트</a></li>
							<li><a href="chat_list.do">채팅</a></li>
							<li><a href="calendar.do">일정(캘린더)</a></li>
							<li><a href="appdomt.do">전자결재</a></li>
							<c:if test="${mc_authority >= 3 }">
							<li><a href="list.do">관리자</a></li>
							<li><a href="attendance.do">근태관리</a></li>
							</c:if>
                        </ul>
                                      
                    </div>
                </div>
                
            </div>
        </section>

</body>
</html>