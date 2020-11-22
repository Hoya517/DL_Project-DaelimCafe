<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO" %>
<%@ page import="member.MemberVO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String userID = request.getParameter("userID");
	String userPassword = request.getParameter("userPassword");
	
	MemberDAO memberDAO = new MemberDAO();
	MemberVO memberVO = new MemberVO();
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
	if (session_userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
	}

	int result = memberDAO.login(userID, userPassword);
	if(result == 1){
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
	}
	else if(result == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않은 아이디입니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(result == -2){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류!!!.')");
		script.println("history.back()");
		script.println("</script>");
	}
%>
</body>
</html>