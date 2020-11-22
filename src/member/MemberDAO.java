package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public MemberDAO() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e ) {
		 	e.printStackTrace();
		}
		try{
			String dbURL = "jdbc:mysql://localhost:3306/daelimcafe2?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "hoy2158831a@";
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM user WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(userPassword))
					return 1;  // 로그인 성공
				else
					return 0;  // 비밀번호 불일치
			}
			return -1;  // 아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;  // 데이터베이스 오류
	}
	
	public int join(MemberVO vo) {
		String SQL = "INSERT INTO `daelimcafe2`.`user` (`userID`, `userPassword`, `name`, `studentNumber`) VALUES (?, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, vo.getUserID());
			pstmt.setString(2, vo.getUserPassword());
			pstmt.setString(3, vo.getName());
			pstmt.setString(4, vo.getStudentNumber());
			return pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		
		}
		return -1; //데이터 베이스 오류
	}

}
