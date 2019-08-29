package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.Key;
import com.util.DBUtil;
import com.util.UserException;

public class KeyDao implements IKey{


	

	@Override
	public List<String> loadKeyContent() {
		//select * FROM ( SELECT key from sort ORDER BY NUM DESC)WHERE ROWNUM < 21;
		// TODO Auto-generated method stub
		Connection connection=DBUtil.getConnection();
		String sql="select * FROM ( SELECT key from MOON.sort ORDER BY NUM DESC)WHERE ROWNUM < 50";
		PreparedStatement preparedStatement=null;
		ResultSet resultSet=null;
		//String[] keys=new []String;
		List <String>keys=new ArrayList<String>();
		String key=null;
		try {
			System.out.println(sql);
			preparedStatement=connection.prepareStatement(sql);
			resultSet=preparedStatement.executeQuery();
			while(resultSet.next())
			{
				key=new String();
				key=resultSet.getString("key");
				System.out.println(key);
				keys.add(key);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return keys;
	}

	@Override
	public List<Key> loadKey(String type) {
		Connection connection=DBUtil.getConnection();
		
		String sql=null;
		if(!"".equals(type)&&type!=null)
		{
			sql="SELECT key from sort where type='"+type+"'";
		}
		PreparedStatement preparedStatement=null;
		ResultSet resultSet=null;
		//String[] keys=new []String;
		List <Key>keys=new ArrayList<Key>();
		Key key;
		try {
			preparedStatement=connection.prepareStatement(sql);
			resultSet=preparedStatement.executeQuery();
			while(resultSet.next())
			{
				key=new Key();
				key.setKey(resultSet.getString("key"));
				keys.add(key);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return keys;
	}

	@Override
	public List<Key> loadKey() {
		Connection connection=DBUtil.getConnection();
		String sql="select * FROM ( SELECT key,num from MOON.sort ORDER BY NUM DESC)WHERE ROWNUM < 50";
		PreparedStatement preparedStatement=null;
		ResultSet resultSet=null;
		//String[] keys=new []String;
		List <Key>keys=new ArrayList<Key>();
		Key key;
		try {
			System.out.println(sql);
			preparedStatement=connection.prepareStatement(sql);
			resultSet=preparedStatement.executeQuery();
			while(resultSet.next())
			{
				key=new Key();
				key.setKey(resultSet.getString("key"));
				key.setNum(resultSet.getString("num"));
				keys.add(key);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return keys;
	}

	@Override
	public String loadKeyCon(String content) {
		Connection connection=DBUtil.getConnection();
		String sql = null;
		if(!"".equals(content)&&content!=null)
		{
		sql="SELECT content from detail where key = '"+content+ "'";
		}
		PreparedStatement preparedStatement=null;
		ResultSet resultSet=null;
		//String[] keys=new []String;
		String result=null;
		try {
			preparedStatement=connection.prepareStatement(sql);
			resultSet=preparedStatement.executeQuery();
			System.out.println(sql);
			while(resultSet.next())
			{
				
				result=resultSet.getString("content");
				System.out.println(result);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return result;
	}

	@Override
	public List<String> loadKeyType() {
		Connection connection=DBUtil.getConnection();
		String sql = null;
		sql="SELECT DISTINCT type from sort ";
		PreparedStatement preparedStatement=null;
		ResultSet resultSet=null;
		List <String>types=new ArrayList<String>();
		String type=null;
		try {
			preparedStatement=connection.prepareStatement(sql);
			resultSet=preparedStatement.executeQuery();
			while(resultSet.next())
			{
				type=resultSet.getString("type");
				types.add(type);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBUtil.close(resultSet);
			DBUtil.close(preparedStatement);
			DBUtil.close(connection);
		}
		return types;
	}



	

}
