<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%
Connection c = null;
try
{
	c = ConnectionProvider.getConnectionProvider();
	Statement s = c.createStatement();
	
	String q1 = "create table users(name varchar(50),mobileNumber bigint,email varchar(25) primary key,password varchar(15),userType varchar(15),securityQuestion varchar(100),securityAnswer varchar(50),address varchar(100),city varchar(30),state varchar(30),country varchar(30))";
	
	System.out.println(q1);
	s.execute(q1);
	System.out.println("Table created");
	c.close();
}
catch(Exception e)
{
	System.out.println(e.getMessage());
	c.close();
}
%>