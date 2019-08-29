package wl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.util.DBUtil;


public class dao {
	public static List<mean> find_allwords1(String type) {
		// 用户登录
		Connection connection = DBUtil.getConnection();
		String sql = "select DETAIL.KEY,DETAIL.CONTENT from SORT join DETAIL on SORT.KEY=DETAIL.KEY WHERE TYPE ='"
				+ type + "'";
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		List<mean> means = new ArrayList<mean>();
		try {
			System.out.println("sql:" + sql);
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				mean m = new mean();
				m.setWord(resultSet.getString("KEY"));
				m.setMeann(resultSet.getString("CONTENT"));
				means.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return means;
	}

	public static String find_mean(String word) {
		// 用户登录
		Connection connection = DBUtil.getConnection();
		String sql = "select DETAIL.CONTENT from DETAIL WHERE KEY='" + word + "'";
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		String mean = "";
		try {
			System.out.println("sql:" + sql);
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				mean = resultSet.getString("CONTENT");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return mean;
	}
	
	public static mean find_mean2(String word) {//查询出词的意思以及类别
		// 用户登录
		Connection connection = DBUtil.getConnection();
		String sql = "select DETAIL.CONTENT,SORT.TYPE from DETAIL join SORT on DETAIL.KEY=SORT.KEY WHERE DETAIL.KEY='" + word + "'";
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		mean mean1=new mean();
		mean1.setMeann("");
		mean1.setType("");
		try {
			System.out.println("sql:" + sql);
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				mean1.setMeann(resultSet.getString("CONTENT")); 
				mean1.setType(resultSet.getString("TYPE"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return mean1;
	}

	public static List<url> find_allUrls2(String word) {
		// 用户登录
		Connection connection = DBUtil.getConnection();
		String sql = "select DISTINCT  URL.KEY,URL.URL,TITLEE.TITLE from URL join TITLEE on URL.URL=TITLEE.URL  WHERE URL.KEY ='"
				+ word + "'";
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		List<url> means = new ArrayList<url>();
		
		try {
			System.out.println("sql:" + sql);
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				url m = new url();
				m.setWord(resultSet.getString("KEY"));
				m.setUrll(resultSet.getString("URL"));
				m.setTitle(resultSet.getString("TITLE"));
				means.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return means;
	}

	public static int find_countWord(String word) {//查询该词是否有解释
		// 用户登录
		Connection connection = DBUtil.getConnection();
		String sql = "select count(KEY) from DETAIL where KEY ='" + word + "'";
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		int count = 0;
		try {
			System.out.println("sql:" + sql);
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				count = resultSet.getInt("count(KEY)");

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return count;
	}
	
	public static int find_countWord2(String word) {//查询该词是否分类
		// 用户登录
		Connection connection = DBUtil.getConnection();
		String sql = "select count(KEY) from SORT where KEY ='" + word + "'";
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		int count = 0;
		try {
			System.out.println("sql:" + sql);
			preparedStatement = connection.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				count = resultSet.getInt("count(KEY)");

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return count;
	}

	public static void addMean(String word, String mean) {

		int count = find_countWord(word);
		System.out.println("count:"+count);
		if (count > 0) {
		} else {

			// 获得连接对象
			Connection connection = DBUtil.getConnection();
			// 创建语句传输对象
			PreparedStatement preparedStatement = null;
			ResultSet resultSet = null;
			try {
				String sql = "INSERT into DETAIL(KEY,CONTENT) VALUES ('" + word + "','" + mean + "')";
				preparedStatement = connection.prepareStatement(sql);
				System.out.println("sql" + sql);
				preparedStatement.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				// 关闭资源
				DBUtil.close(resultSet);
				DBUtil.close(preparedStatement);
				DBUtil.close(connection);
			}
		}
	}
	public static void addleibe(String word, String leibe) {

		int count = find_countWord2(word);
		System.out.println("count:"+count);
		if (count > 0) {
		} else {

			// 获得连接对象
			Connection connection = DBUtil.getConnection();
			// 创建语句传输对象
			PreparedStatement preparedStatement = null;
			ResultSet resultSet = null;
			try {

				String sql = "INSERT into SORT(KEY,NUM,TYPE) VALUES ('" +word +"','10','"+leibe+"')";
				preparedStatement = connection.prepareStatement(sql);
				System.out.println("sql" + sql);
			    preparedStatement.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				// 关闭资源
				DBUtil.close(resultSet);
				DBUtil.close(preparedStatement);
				DBUtil.close(connection);
			}
		}
	}

}
