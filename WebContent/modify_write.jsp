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
    <link rel="stylesheet" href="./css/modify_write.css" />
    <link rel="stylesheet" type="text/css" href="./css/font.css">
    <script src="https://cdn.ckeditor.com/ckeditor5/24.0.0/classic/ckeditor.js"></script>

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
		if (!session_userID.equals(vo.getId())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
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

    <form id="modify_write" action="modify_writeAction.jsp?_id=<%= boardId %>" method="post">
	    <div class="container">
	        <div class="write-name">수정하기</div>
	        <div class="write-Bar"></div>
	        <div class="write-title">
				<input class="write-title-title" name="title" type="text"
						value="<%= vo.getTitle() %>">
	        </div>
	       	<div>
	       		카테고리
	       		<select name="category">
	       			<option value="read_notice"<%="read_notice".equals(vo.getCategory())?" selected":""%>>필독</option>
	       			<option value="cafe_notice"<%="cafe_notice".equals(vo.getCategory())?" selected":""%>>카페 공지</option>
	       			<option value="free_board"<%="free_board".equals(vo.getCategory())?" selected":""%>>자유 게시판</option>
	       			<option value="freshman_board"<%="freshman_board".equals(vo.getCategory())?" selected":""%>>새내기 게시판</option>
	       			<option value="class_board"<%="class_board".equals(vo.getCategory())?" selected":""%>>강의평</option>
	       			<option value="foodstore_board"<%="foodstore_board".equals(vo.getCategory())?" selected":""%>>학교주변 맛집</option>
	       		</select>
	       	</div>
	        <div class="wirte-editor">
	            <textarea name="content" id="editor"><%= vo.getContent() %></textarea>
	        </div>
	        <div class="wirte-btn">
	           	<div class="wirte-cancel"><a href="index.jsp">취소</a></div>
	            <div class="wirte-upload"><a href="javascript:{}" onclick="document.getElementById('modify_write').submit();">등록</a></div>
	        </div>
	    </div>
    </form>
    <!--//container-->

    <div class="bar4"></div>
    <div class="footer">
        <div class="footer-cafename">DAELIM UNIV.</div>
    </div>
	<script>
	 ClassicEditor
	  .create( document.querySelector( '#editor' ) )
	  .catch( error => {
	      console.error( error );
	  } );
	</script>
</body>
</html>