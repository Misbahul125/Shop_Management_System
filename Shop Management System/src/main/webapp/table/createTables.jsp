<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%
Connection c = null;
try
{
	c = ConnectionProvider.getConnectionProvider();
	Statement s = c.createStatement();
	
	//String q1 = "create table users(name varchar(50),mobileNumber bigint,email varchar(25) primary key,password varchar(15),userType varchar(15),securityQuestion varchar(100),securityAnswer varchar(50),address varchar(100),city varchar(30),state varchar(30),country varchar(30))";
	
	//String q2 = "create table product(id int, name varchar(200), category varchar(200), price int, status varchar(10))";
	
	String q3 = "create table cart(email varchar(100), productId int, quantity int, price int, total int, address varchar(200), city varchar(50), state varchar(50), country varchar(50), mobileNumber bigint, orderDate varchar(30), deliveryDate varchar(30), paymentMethod varchar(30), transactionId varchar(50), status varchar(20))";
	
	//System.out.println(q1);
	//s.execute(q1);
	
	//System.out.println(q2);
	//s.executeUpdate(q2);
	s.executeUpdate(q3);
	System.out.println("Table created");
	c.close();
}
catch(Exception e)
{
	System.out.println(e.getMessage());
	c.close();
}
%>