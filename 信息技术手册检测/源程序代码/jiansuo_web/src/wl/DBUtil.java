package wl;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DBUtil {
	public  static  Connection getConnection() {
		
			
			try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
			} catch (InstantiationException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (IllegalAccessException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (ClassNotFoundException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		String user = "root";
		String password = "root";
		String url = "jdbc:mysql://localhost:3307/jiansuo";
		Connection connection = null;
		try {	
			 connection = DriverManager.getConnection(url,user,password);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		return connection;
		
	}
	
public static void update_copy(int start,int last,int id) {
		
		Connection connection = DBUtil.getConnection();
		
		String sql = "update copy set start_position="+start+",last_position="+last+" where id="+id;
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
	}
	
	public static void add(citiao c) {
		
				Connection connection = DBUtil.getConnection();
				
				PreparedStatement preparedStatement = null;
				ResultSet resultSet = null;
				try {
				
					String sql = "insert into yuan value ("+c.getId()+",'"+c.getName()+"','"+c.getExplain()+"',null,null)";
					
					preparedStatement = connection.prepareStatement(sql);
					preparedStatement.executeUpdate();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}finally {
					
					DBUtil.close(resultSet);
					DBUtil.close(preparedStatement);
					DBUtil.close(connection);
				}
				
			}
	
	public static void add_copy(copy c) {//��
		
				Connection connection = DBUtil.getConnection();
				
				PreparedStatement preparedStatement = null;
				ResultSet resultSet = null;
				try {
				
					String sql = "insert into copy value (null,"+c.getYuan_id()+",'"+c.getCopy_field()+"','"+c.getUrl()+"')";	
					preparedStatement = connection.prepareStatement(sql);
					preparedStatement.executeUpdate();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}finally {
					
					DBUtil.close(resultSet);
					DBUtil.close(preparedStatement);
					DBUtil.close(connection);
				}
				
			}
	
	
	public static List<citiao> load_all() {
		Connection connection = DBUtil.getConnection();
		
		String sql = "select * from yuan";
	
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		List<citiao> cs =new ArrayList<citiao>();
		try {
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				citiao c = new citiao();
				c.setId(resultSet.getInt("id"));
				c.setName(resultSet.getString("name"));
				c.setExplain(resultSet.getString("explain"));
				c.setKeywords(resultSet.getString("keywords"));
				c.setAbstracts(resultSet.getString("abstract"));
				c.setClasss(resultSet.getString("classs"));
				cs.add(c);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return  cs;
	}
	
	public static List<String> load_allClasss() {
		Connection connection = DBUtil.getConnection();
		String sql = "select distinct classs from yuan";
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		List<String> cs =new ArrayList<String>();
		try {
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				cs.add(resultSet.getString("classs"));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return  cs;
	}
	
	public static List<citiao> load_like(String str) {
		Connection connection = DBUtil.getConnection();
		
		String sql = "select * from yuan where name like '%"+str+"%' or keywords like '%"+str+"%'";
		
		
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		List<citiao> cs =new ArrayList<citiao>();
		try {
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				citiao c = new citiao();
				c.setId(resultSet.getInt("id"));
				c.setName(resultSet.getString("name"));
				c.setExplain(resultSet.getString("explain"));
				c.setKeywords(resultSet.getString("keywords"));
				c.setAbstracts(resultSet.getString("abstract"));
				c.setClasss(resultSet.getString("classs"));
				cs.add(c);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return  cs;
	}
	
	public static List<citiao> load_likeClass(String str) {
		Connection connection = DBUtil.getConnection();
		
		String sql = "select * from yuan where classs='"+str+"'";
		
		
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		List<citiao> cs =new ArrayList<citiao>();
		try {
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				citiao c = new citiao();
				c.setId(resultSet.getInt("id"));
				c.setName(resultSet.getString("name"));
				c.setExplain(resultSet.getString("explain"));
				c.setKeywords(resultSet.getString("keywords"));
				c.setAbstracts(resultSet.getString("abstract"));
				c.setClasss(resultSet.getString("classs"));
				cs.add(c);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return  cs;
	}
	
	
	public static String load_expain(int id) {//��
		Connection connection = DBUtil.getConnection();
		
		String sql = "select * from yuan where id="+id;
		
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		String expain="";
		try {
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				expain=resultSet.getString("explain");
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return  expain;
	}
	
	public static List<copy> load_all2() {//��
		Connection connection = DBUtil.getConnection();
		
		String sql = "select * from copy";
		
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		List<copy> cops =new ArrayList<copy>();
		try {
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				copy c = new copy();
				c.setId(resultSet.getInt("id"));
				c.setYuan_id(resultSet.getInt("yuan_id"));
				c.setCopy_field(resultSet.getString("copy_field"));
				cops.add(c);				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return  cops;
	}
	
	
	
	public static List<copy> load_id(int yuan_id) {//��
		Connection connection = DBUtil.getConnection();
		
		String sql = "select distinct start_position,last_position from copy where yuan_id="+yuan_id+"  ORDER BY start_position";
		
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		List<copy> cops =new ArrayList<copy>();
		try {
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				copy c = new copy();	
				c.setStart_position(resultSet.getInt("start_position"));
				c.setLast_position(resultSet.getInt("last_position"));
				cops.add(c);				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return  cops;
	}
	


	public static void close(Connection connection ) {
		try {
			if (connection != null) {
				connection.close();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void close(PreparedStatement preparedStatement ) {
		try {
			if (preparedStatement != null) {
				preparedStatement.close();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void close(ResultSet resultSet ) {
		try {
			if (resultSet != null) {
				resultSet.close();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
