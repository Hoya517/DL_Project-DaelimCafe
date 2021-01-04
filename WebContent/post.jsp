<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardVO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Daelim CAFE</title>
    <link rel="stylesheet" href="./css/index.css" />
    <link rel="stylesheet" type="text/css" href="./css/post.css">
</head>
<body>
	<%
		String session_userID = null;
		if (session.getAttribute("userID") != null) {
			session_userID = (String) session.getAttribute("userID");
		}
		if (session_userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용해주세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int boardId = 0;
		if (request.getParameter("_id") !=null) {
			boardId = Integer.parseInt(request.getParameter("_id"));
		}
		if (boardId == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 페이지입니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}
		BoardVO vo = new BoardDAO().getBoard(boardId);
	%>
	<div class="bar1"></div>
	<div class="top">
		<div class="top-join">
			<a href="logoutAction.jsp">로그아웃</a>
		</div>
	</div>
    <!--//top-->
    <div class="bar2"></div>
    <div class="banner">
        <div class="banner-text">
            <span><a href="index.jsp">DAELIM UNIV.</a></span>
        </div>
    </div>
    <!--//banner-->
    <div class="bar3"></div>

    <div class="container">
        <div class="sidebar">
            <div class="sidebar-Bar1"></div>
            <div class="user">
                <div class="user-pic"></div>
                <div class="user-id">아이디겸닉네임</div>
            </div>
            <div class="sidebar-bar1"></div>
            <div class="sidebar-writebtn"><a href="new_write.html">카페 글쓰기</a></div>
            <div class="sidebar-Bar2"></div>

            <div class="sidebar-notice">
                <div class="notice-board">
                    <div class="notice-board-icon"><img src="./src/megaphone.png" alt="notice" /></div>
                    <div class="notice-board-title">공지사항</div>
                </div>
                <div class="sidebar-bar2"></div>
                <ul>
                    <li><a href="read_notice.jsp">필독</a></li>
                    <li><a href="cafe_notice.jsp">카페 공지</a></li>
                </ul>
            </div>
            <div class="sidebar-Bar3"></div>

            <div class="sidebar-board">
                <div class="board-board">
                    <div class="board-board-icon"><img src="./src/document.png" alt="board" /></div>
                    <div class="board-board-title">게시판</div>
                </div>
                <div class="sidebar-bar3"></div>
                <ul>
                    <li><a href="free_board.jsp">자유 게시판</a></li>
                    <li><a href="freshman_board.jsp">새내기 게시판</a></li>
                    <li><a href="class_board.jsp">강의평</a></li>
                    <li><a href="foodstore_board.jsp">학교주변 맛집</a></li>
                </ul>
            </div>
            <div class="sidebar-Bar4"></div>
        </div>
        <!--//sidebar-->
		
		<%
			new BoardDAO().readCount(vo.get_id());
		%>
        <div class="post">
            <div class="post-title"><%= vo.getTitle()%></div>
            <div class="post-user">
                <div class="post-userpic"><img src="src/user.JPG"></div>
                <div class="post-info">
                    <div class="post-userid"><%= vo.getId() %></div>
                    <div class="post-date"><%= vo.getDate() %></div>
                </div>
            </div>
            <div class="sidebar-bar5"></div>
            <div class="post-box">
                    <%= vo.getContent() %>
            </div>
            <div class="sidebar-bar6"></div>
            <div class="post-btn">
            	<% if(session_userID!=null && session_userID.equals(vo.getId())) { %>
	                <div class="post-delete"><a onclick="return confirm('정말로 삭제하시겠습니까?');"
	                							href="deleteAction.jsp?_id=<%= boardId %>">삭제</a></div>
	                <div class="post-rewrite"><a href="modify_write.jsp?_id=<%= boardId %>">수정</a></div>
            	<% } else { %>
         		   	<div class="post-rewrite"><a onclick="javascript:history.go(-1);">목록으로</a></div>
            	<% } %>
            </div>
        </div>
        <!--//post-->

    </div>
    <!--//container-->

    <div class="bar4"></div>
    <div class="footer">
        <div class="footer-cafename">DAELIM UNIV.</div>
    </div>
</body>
</html>