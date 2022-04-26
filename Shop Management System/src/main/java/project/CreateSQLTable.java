package project;

import java.sql.*;

public class CreateSQLTable {
	
	Connection c;
	Statement s;
	
	public CreateSQLTable(Connection connection) {
		this.c = connection;
	}
	
	public boolean createUsersTable() {
		
		try
		{
			s = c.createStatement();
			
			String q1 = "create table users(name varchar(50),mobileNumber bigint,email varchar(25) primary key,password varchar(15),userType varchar(15),securityQuestion varchar(100),securityAnswer varchar(50),address varchar(100),city varchar(30),state varchar(30),country varchar(30))";
			
			System.out.println(q1);
			s.execute(q1);
			System.out.println("Table created");
			return true;
			//c.close();
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			return false;
		}
	}
	
public boolean createProductTable() {
		
		try
		{
			s = c.createStatement();
			
			String q1 = "create table product(productID int, productName varchar(200), category varchar(200), price int, status varchar(10))"; 
			
			System.out.println(q1);
			s.execute(q1);
			System.out.println("Table created");
			return true;
			//c.close();
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			return false;
		}
	}

public boolean createCartTable() {
	
	try
	{
		s = c.createStatement();
		
		String q1 = "create table cart(email varchar(100), productId int, quantity int, price int, total int, address varchar(200), city varchar(50), state varchar(50), country varchar(50), mobileNumber bigint, orderDate varchar(30), deliveryDate varchar(30), paymentMethod varchar(30), transactionId varchar(50), status varchar(20))"; 
		
		System.out.println(q1);
		s.execute(q1);
		System.out.println("Table created");
		return true;
		//c.close();
	}
	catch(Exception e)
	{
		System.out.println(e.getMessage());
		return false;
	}
}
}
}
