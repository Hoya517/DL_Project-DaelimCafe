<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardVO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
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
	} else {
		BoardDAO dao = new BoardDAO();
		int result = dao.delete(boardId);
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
%>
</body>
</html>