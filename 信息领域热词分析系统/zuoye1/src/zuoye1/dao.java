package zuoye1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class dao {
	public static void add(JavaBokeModel model) {//增
		//获得链接对象
				Connection connection = DBUtil.getConnection();
				//准备sql语句
				
				//创建语句传输对象
				PreparedStatement preparedStatement = null;
				
				try {
					
					String sql ="INSERT INTO Boke (title,linke,author)VALUES(?,?,?)";
					preparedStatement = connection.prepareStatement(sql);
					preparedStatement.setString(1, model.getTitle());
					preparedStatement.setString(2, model.getLinke());
					preparedStatement.setString(3, model.getAuthor());
					
					
					preparedStatement.executeUpdate();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}finally {
					//关闭资源
				
					DBUtil.close(preparedStatement);
					DBUtil.close(connection);
				}
				
			}

	

}
