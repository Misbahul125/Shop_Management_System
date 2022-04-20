package project;

import java.sql.*;

public class SQLTableStatus {
	
	public static boolean isTableExixts(String tableName) {
		
		try {
			Connection c = ConnectionProvider.getConnectionProvider();
			DatabaseMetaData metaData = c.getMetaData();
			ResultSet resultSet = metaData.getTables(null, null, tableName, new String[] {"TABLE"});
			
			while(resultSet.next()) {
				return true;
			}
			
			return false;
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	
	}
	
}
