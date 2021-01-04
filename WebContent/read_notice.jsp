<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardVO" %>
<%@ page import="java.util.ArrayList"%>
<%
	int where=1;
  	int totalgroup=0;
  	int maxpages=5;
	int startpage=1;	
	int endpage=startpage+maxpages-1;
	int wheregroup=1;
	if (request.getParameter("go") != null){ 	
  		where = Integer.parseInt(request.getParameter("go"));
 		wheregroup = (where-1)/maxpages + 1;
		startpage=(wheregroup-1) * maxpages+1;  
		endpage=startpage+maxpages-1; 
	} else if (request.getParameter("gogroup") != null) {
  		wheregroup = Integer.parseInt(request.getParameter("gogroup"));
   		startpage=(wheregroup-1) * maxpages+1;  
   		where = startpage ; 
   		endpage=startpage+maxpages-1; 
  	}
	
  	int nextgroup=wheregroup+1;
  	int priorgroup= wheregroup-1;  
  	
  	int nextpage=where+1;
  	int priorpage = where-1;
  	int startrow=0;
	int endrow=0;
	int maxrows=10;
	int totalrows=0;
	int totalpages=0;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Daelim CAFE</title>
<link rel="stylesheet" href="./css/read_notice.css" />
<link rel="stylesheet" type="text/css" href="./css/font.css">
</head>
<body>
	<%
		String session_userID = null;
		if (session.getAttribute("userID") != null) {
			session_userID = (String) session.getAttribute("userID");
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
					<li><a href="read_notice.jsp" id="click">필독</a></li>
					<li><a href="cafe_notice.jsp">카페 공지</a></li>
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
					<li><a href="free_board.jsp">자유 게시판</a></li>
					<li><a href="freshman_board.jsp">새내기 게시판</a></li>
					<li><a href="class_board.jsp">강의평</a></li>
					<li><a href="foodstore_board.jsp">학교주변 맛집</a></li>
				</ul>
			</div>
			<div class="sidebar-Bar4"></div>
		</div>
		<!--//sidebar-->

		<div class="list">
			<div class="list-name">필독</div>
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
				ArrayList<BoardVO> list = dao.getList("read_notice");
				totalrows = list.size();
			    totalpages = (totalrows-1)/maxrows +1;
			    startrow = (where-1) * maxrows;
			    endrow = startrow+maxrows-1  ;
			    if (endrow >= totalrows) endrow=totalrows-1;
			    totalgroup = (totalpages-1)/maxpages +1;
			    if (endpage > totalpages) endpage=totalpages;
				for (int i = startrow; i <= endrow; i++) {
			%>
				<tr class="list-table-tr">
					<td class="list-table-number"><%=list.get(i).get_id()%></td>
					<td class="list-table-title"><a href="post.jsp?_id=<%=list.get(i).get_id()%>"><%=list.get(i).getTitle()%></a></td>
					<td class="list-table-writer"><%=list.get(i).getId()%></td>
					<td class="list-table-date"><%=list.get(i).getDate().substring(0, 11)%></td>
					<td class="list-table-look"><%=list.get(i).getReadcount() %></td>
				</tr>
			<%
				}
			%>
			</table>
			<%
				
			%>
			<div class="pages">
			<%
			if(wheregroup > 1) {
	    	%>
	    		<a href="index.jsp?go=1">&lt;&lt;</a>
	    		<a href="index.jsp?gogroup=<%=priorgroup%>"><img src="./src/back.png" alt=""></a>
	    	<%
	    	} else {
    		%>
    			<a>&lt;&lt;</a>
	    		<a><img src="./src/back.png" alt=""></a>
	    	<%
	    	}
			
	    	for(int jj=startpage; jj<=endpage; jj++) {
	    		if (jj==where) {
	   		%>
	   		    <a class="page-num" id="on"><%= jj %></a>
		    <%
		    	} else {
		    %>
		    	<a href="index.jsp?go=<%=jj %>" class="page-num"><%= jj %></a>
		    <%	   
		    	}
	    	}
		    %>
		    <%	 
	    	if (wheregroup < totalgroup) {
	    	%>
    			<a href="index.jsp?gogroup=<%=nextgroup %>"><img src="./src/next.png" alt=""></a>
    			<a href="index.jsp?gogroup=<%=totalgroup %>">&gt;&gt;</a>
		    <%	 	
	    	} else {
	    	%>
    			<a><img src="./src/next.png" alt=""></a>
    			<a>&gt;&gt;</a>
		    <% 
	    	}
			%>
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