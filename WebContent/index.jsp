<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardVO" %>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Daelim CAFE</title>
<link rel="stylesheet" href="./css/index.css" />
<link rel="stylesheet" type="text/css" href="./css/font.css">
</head>

<body>
	<%
		String session_userID = null;
		if (session.getAttribute("userID") != null) {
			session_userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<div class="bar1"></div>
	<div class="top">
		<% if (session_userID == null) { %>
		<div class="top-login">
			<a href="login.jsp">로그인</a>
		</div>
		<div class="top-join">
			<a href="join.jsp">회원가입</a>
		</div>
		<% } else { %>
		<div class="top-join">
			<a href="logoutAction.jsp">로그아웃</a>
		</div>
		<% } %>
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
				<% if (session_userID == null) { %>
					<div class="user-id">로그인 해주세요!</div>
				<% } else { %>
					<div class="user-id"><%=session.getAttribute("userID") %></div>
				<% } %>
			</div>
			<div class="sidebar-bar1"></div>
			<div class="sidebar-writebtn">
				<% if (session_userID == null) { %>
					<a href="login.jsp">카페 글쓰기</a>
				<% } else { %>
					<a href="new_write.jsp">카페 글쓰기</a>
				<% } %>
			</div>
			<div class="sidebar-Bar2"></div>

			<div class="sidebar-notice">
				<div class="notice-board">
					<div class="notice-board-icon">
						<img src="./src/megaphone.png" alt="notice" />
					</div>
					<div class="notice-board-title">공지사항</div>
				</div>
				<div class="sidebar-bar2"></div>
				<ul>
					<li><a href="read_notice.html">필독</a></li>
					<li><a href="cafe_notice.html">카페 공지</a></li>
				</ul>
			</div>
			<div class="sidebar-Bar3"></div>

			<div class="sidebar-board">
				<div class="board-board">
					<div class="board-board-icon">
						<img src="./src/document.png" alt="board" />
					</div>
					<div class="board-board-title">게시판</div>
				</div>
				<div class="sidebar-bar3"></div>
				<ul>
					<li><a href="free_board.html">자유 게시판</a></li>
					<li><a href="freshman_board.html">새내기 게시판</a></li>
					<li><a href="class_board.html">강의평</a></li>
					<li><a href="foodstore_board.html">학교주변 맛집</a></li>
				</ul>
			</div>
			<div class="sidebar-Bar4"></div>
		</div>
		<!--//sidebar-->

		<div class="list">
			<div class="list-name">전체 글보기</div>
			<div class="list-Bar"></div>
			<div class="list-title">
				<ul>
					<li>NO</li>
					<li>제목</li>
					<li>작성자</li>
					<li>작성일</li>
					<li>조회</li>
				</ul>
			</div>
			<div class="list-Bar2"></div>
			<table class="list-table">
			<%
				BoardDAO dao = new BoardDAO();
				ArrayList<BoardVO> list = dao.getList(pageNumber);
				for (int i = 0; i < list.size(); i++) {
			%>
				<tr class="list-table-tr">
					<td class="list-table-number"><%=list.get(i).get_id()%></td>
					<td class="list-table-title"><a href="post.jsp?_id=<%=list.get(i).get_id()%>"><%=list.get(i).getTitle()%></a></td>
					<td class="list-table-writer"><%=list.get(i).getId()%></td>
					<td class="list-table-date"><%=list.get(i).getDate()%></td>
					<td class="list-table-look">0</td>
				</tr>
			<%
				}
			%>
			</table>

			
			<div class="pages">
				<a href="#"><img src="./src/back.png" alt=""></a> <a href="#"
					class="page-num" id="on">1</a> <a href="#" class="page-num">2</a> <a
					href="#" class="page-num">3</a> <a href="#" class="page-num">4</a>
				<a href="#" class="page-num">5</a> <a href="#"><img src="./src/next.png" alt=""></a>
			</div>
		</div>
		<!--//list-->



	</div>
	<!--//container-->

	<div class="bar4"></div>
	<div class="footer">
		<div class="footer-cafename">DAELIM UNIV.</div>
	</div>
</body>

</html>