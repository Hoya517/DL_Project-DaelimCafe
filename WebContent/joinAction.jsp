<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="member.MemberVO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	String userID = request.getParameter("userID");
	String userPassword = request.getParameter("userPassword");
	String userPasswordCheck = request.getParameter("userPasswordCheck");
	String name = request.getParameter("name");
	String studentNumber = request.getParameter("studentNumber");
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

	if (userID == null || userPassword == null || name == null || studentNumber == null || userPasswordCheck == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else if (!userPassword.equals(userPasswordCheck)) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호를 동일하게 입력해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		MemberDAO memberDAO = new MemberDAO();
		MemberVO memberVO = new MemberVO();
		memberVO.setUserID(userID);
		memberVO.setUserPassword(userPassword);
		memberVO.setName(name);
		memberVO.setStudentNumber(studentNumber);
		int result = memberDAO.join(memberVO);
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			session.setAttribute("userID", userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}
	}
	%>
</body>
</html>