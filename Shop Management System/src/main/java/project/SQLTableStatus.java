package project;

import java.sql.*;

public class SQLTableStatus {
	
	private static Connection c = null;
	
	public static boolean isTableExixts(String tableName) throws SQLException {
		
		try {
			c = ConnectionProvider.getConnectionProvider();
			DatabaseMetaData metaData = c.getMetaData();
			ResultSet resultSet = metaData.getTables(null, null, tableName, new String[] {"TABLE"});
			
			while(resultSet.next()) {
				c.close();
				return true;
			}
			
			c.close();
			return false;
		}
		catch(Exception e) {
			c.close();
			System.out.println(e.getMessage());
			return false;
		}
	
	}
	
}
