package zuoye1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class dao {
	public static void add(JavaBokeModel model) {//��
		//������Ӷ���
				Connection connection = DBUtil.getConnection();
				//׼��sql���
				
				//������䴫�����
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
					//�ر���Դ
				
					DBUtil.close(preparedStatement);
					DBUtil.close(connection);
				}
				
			}

	

}
