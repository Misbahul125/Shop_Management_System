package project;

import java.sql.*;

public class ConnectionProvider {
	
	public static Connection getConnectionProvider() {
		try{  
            //Class.forName("oracle.jdbc.driver.OracleDriver");
			
			Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop_management_system_jsp","root","rootlocalhost1234");    
            //Statement statement =connection.createStatement();
            System.out.println("Successful");
            return connection;
        }catch(Exception e){ 
            System.out.println(e.getMessage());
            return null;
        }  
	}
}