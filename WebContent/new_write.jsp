<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Daelim CAFE</title>
<link rel="stylesheet" href="./css/new_write.css" />
<link rel="stylesheet" type="text/css" href="./css/font.css">
<script type="text/javascript" src="./ckeditor/ckeditor.js"></script>
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

	<!--//container-->
	<form id="new_write" action="new_writeAction.jsp" method="post">
		<div class="container">
			<div class="write-name">새 글 쓰기</div>
			<div class="write-Bar"></div>
			<div class="write-title">
				<input class="write-title-title" name="title" type="text"
					placeholder="제목을 입력해 주세요.">
			</div>
			<div>
				카테고리 <select name="category">
					<option value="read_notice">필독</option>
					<option value="cafe_notice">카페 공지</option>
					<option value="free_board">자유 게시판</option>
					<option value="freshman_board">새내기 게시판</option>
					<option value="class_board">강의평</option>
					<option value="foodstore_board">학교주변 맛집</option>
				</select>
			</div>
			<div class="wirte-editor">
				<textarea name="content" id="editor"></textarea>
				<script type="text/javascript">
				 CKEDITOR.replace('editor'
				                , {height: 500                                                  
				                 });
				</script>
			</div>
			<div class="wirte-btn">
				<div class="wirte-cancel">
					<a href="index.jsp">취소</a>
				</div>
				<div class="wirte-upload">
					<a href="javascript:{}"
						onclick="document.getElementById('new_write').submit();">등록</a>
				</div>
			</div>
		</div>
	</form>

	<!--//footer-->
	<div class="bar4"></div>
	<div class="footer">
		<div class="footer-cafename">DAELIM UNIV.</div>
	</div>
</body>
</html>