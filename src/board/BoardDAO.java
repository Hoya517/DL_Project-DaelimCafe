package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
		return "";
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
		return -1;
	}
	
	public ArrayList<BoardVO> getList(int pageNumber) {
		String SQL = "SELECT * FROM board ORDER BY _iD DESC";
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardVO vo = new BoardVO();
				vo.set_id(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setId(rs.getString(4));
				vo.setDate(rs.getString(5));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public BoardVO getBoard(int boardId) {
		String SQL = "SELECT * FROM board WHERE _id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				BoardVO vo = new BoardVO();
				vo.set_id(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setContent(rs.getString(3));
				vo.setId(rs.getString(4));
				vo.setDate(rs.getString(5));
				vo.setCategory(rs.getString(6));
				return vo;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int boardId, String title, String category, String content) {
		String SQL = "UPDATE board SET title = ?, category = ?, content = ? WHERE _id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, title);
			pstmt.setString(2, category);
			pstmt.setString(3, content);
			pstmt.setInt(4, boardId);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;  // db 오류
	}
	
	public int delete(int boardId) {
		String SQL = "DELETE FROM `daelimcafe2`.`board` WHERE (`_id` = ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardId);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
