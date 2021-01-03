package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BoardDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BoardDAO() {
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
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";  // db 오류
	}
	
	public int insert(BoardVO vo) {
		String SQL = "INSERT INTO `daelimcafe2`.`board` (`title`, `content`, `id`, `date`, `category`) VALUES (?, ?, ?, ?, ?);";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getId());
			pstmt.setString(4, getDate());
			pstmt.setString(5, vo.getCategory());
			return pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		
		}
		return -1; //데이터 베이스 오류
	}
}
