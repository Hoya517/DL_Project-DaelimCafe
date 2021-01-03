<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardVO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String title = request.getParameter("title");
	String category = request.getParameter("category");
	String content = request.getParameter("content");
	out.println(title);
	out.println(category);
	out.println(content);
	
	BoardDAO dao = new BoardDAO();
	BoardVO vo = new BoardVO();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Daelim CAFE</title>
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
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
	} else {
		if(title == null || content == null )	// 글제목, 글내용 미작성시
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else
		{	
			// db에 데이터 넣어주기
			vo.setTitle(title);
			vo.setCategory(category);
			vo.setContent(content);
			vo.setId(session_userID);
			int result = dao.insert(vo);
			if (result == -1)
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다..')");
				script.println("history.back()");
				script.println("</script>");
			}
			else
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'index.jsp'");
				script.println("</script>");
			}
		}
	}
%>
</body>
</html>