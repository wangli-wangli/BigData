package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtil {
		
		public  static  Connection getConnection() {
			try {
				//1建立连接
				Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
				//System.out.println("数据库驱动加载成功");
			} catch (InstantiationException | IllegalAccessException | ClassNotFoundException e) {
				// TODO Auto-generated catch block
				System.out.println("数据库驱动加载失败");
				e.printStackTrace();
			}
			String user = "moon";//登录oracle的登录名
			String password = "root";
			//url jdbc:oracle:thin表示jdbc连接oracle数据库的通讯协议
			//@localhost主机
			//1521主机上的程序端口
			//orcl程序端口上的数据库
			String url = "jdbc:oracle:thin:@localhost:1521:orcl";
			Connection connection = null;
			try {
				 connection = DriverManager.getConnection(url,user,password);
			} catch (SQLException e) {
				System.out.println("连接失败");
				e.printStackTrace();
			}
			return connection;
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
