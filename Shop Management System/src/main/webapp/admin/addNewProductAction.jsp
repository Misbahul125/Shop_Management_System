<%@page import="project.SQLTableStatus"%>
<%@page import="project.ConnectionProvider"%>
<%@page import="project.CreateSQLTable"%>
<%@page import="project.UserConstant"%>
<%@page import="java.sql.*"%>

<%
String id = request.getParameter("id");
String name = request.getParameter("name");
String category = request.getParameter("category");
String price = request.getParameter("price");
String status = request.getParameter("status");

try{
	Connection c = ConnectionProvider.getConnectionProvider();
	
	String q1 = "insert into product values(?,?,?,?,?)";
	PreparedStatement ps = c.prepareStatement(q1);
	
	ps.setString(1, id);
	ps.setString(2, name);
	ps.setString(3, category);
	ps.setString(4, price);
	ps.setString(5, status);
	ps.executeUpdate();
	c.close();
	System.out.println("Product added successfully");
	response.sendRedirect("addNewProduct.jsp?msg=success");
}
catch(Exception e) {
	System.out.println(e.getMessage());
	response.sendRedirect("addNewProduct.jsp?msg=error");
}
%>