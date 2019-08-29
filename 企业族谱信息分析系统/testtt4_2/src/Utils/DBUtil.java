package Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtil {
	public static Connection getConection() {
		Connection con = null;
		try {
			Class.forName(PropertiesUtil.getValue("jdbcName"));
			con = DriverManager.getConnection(PropertiesUtil.getValue("dbUrl"), PropertiesUtil.getValue("dbUserName"), PropertiesUtil.getValue("dbPassword"));
		} catch (Exception e) {
			
			System.out.println(e.getMessage());
		}
		return con;
	}
    public static void close(PreparedStatement pre) {
		if(pre == null)return;
		try {
			pre.close();
		} catch (SQLException e) {
			
			System.err.println(e.getMessage());
		}
	}
	
	public static void close(ResultSet rs) {
		if(rs == null)return;
		try {
			rs.close();
		} catch (SQLException e) {
		
			System.err.println(e.getMessage());
		}
	}
	
	public static void close(Connection con) {
		if(con == null)return;
		try {
			con.close();
		} catch (SQLException e) {
			
			System.err.println(e.getMessage());
		}
	}
}
