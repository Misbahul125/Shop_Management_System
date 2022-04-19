<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%
try
{
	Connection c = ConnectionProvider.getConnectionProvider();
	Statement s = c.createStatement();
	
	String q1 = "create table users(name varchar(100),email varchar(100) primary key,mobileNumber bigint,securityQuestion varchar(200),securityAnswer varchar(200),password varchar(100),address varchar(500),city varchar(100),state varchar(100),country varchar(100))";
	
	System.out.println(q1);
	s.execute(q1);
	System.out.println("Table created");
	c.close();
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>