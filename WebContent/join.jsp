<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daelim CAFE</title>
    <link rel="stylesheet" href="./css/join.css" />
    <link rel="stylesheet" type="text/css" href="./css/font.css">
</head>

<body>
    <div class="bar1"></div>
    <div class="top">
        <div class="top-name"><a href="index.jsp">DAELIM UNIV.</a></div>
    </div>
    <!--//top-->
    <div class="bar2"></div>
    <div class="content">
        <div class="join">
            <div class="join-title">Join</div>
            <div class="bar3"></div>
            <div class="join-box">
                <form method="post" action="joinAction.jsp">
                    <p><label for="id">아이디</label></p>
                    <div class="box-join"><input type="text" name="userID" maxlength="20"></div>
                    <p><label for="pw">비밀번호</label></p>
                    <div class="box-join"><input type="password" name="userPassword" maxlength="20"></div>
                    <p><label for="pw">비밀번호 확인</label></p>
                    <div class="box-join"><input type="password" name="userPasswordCheck" maxlength="20"></div>
                    <p><label for="name">이름</label></p>
                    <div class="box-join"><input type="text" name="name" maxlength="20"></div>
                    <p><label for="studentnum">학번</label></p>
                    <div class="box-join"><input type="text" name="studentNumber" maxlength="20"></div>
                    <input class="join-joinbtn" type="submit" value="회원가입">
                    <div class="join-cancelbtn"><a href="index.jsp">취소</a></div>
                </form>
            </div>
        </div>
    </div>

    <div class="bar4"></div>
    <div class="footer">
        <div class="footer-cafename">DAELIM UNIV.</div>
    </div>
</body>

</html>