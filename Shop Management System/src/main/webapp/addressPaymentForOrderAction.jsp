<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>

<%
String email = session.getAttribute("email").toString();
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String country = request.getParameter("country");
String mobileNumber = request.getParameter("mobileNumber");
String paymentMode = request.getParameter("paymentMode");
String transactionId = request.getParameter("transactionId");
String status = "bill";

try{
	Connection c = ConnectionProvider.getConnectionProvider();
	Statement s = c.createStatement();
	c.setAutoCommit(false);
	
	String q1 = "update users set address=?, city=?, state=?, country=?, mobileNumber=? where email=?";
	PreparedStatement ps1 = c.prepareStatement(q1);
	
	ps1.setString(1, address);
	ps1.setString(2, city);
	ps1.setString(3, state);
	ps1.setString(4, country);
	ps1.setString(5, mobileNumber);
	ps1.setString(6, address);
	ps1.executeUpdate();
	
	String q2 = "update cart set address=?, city=?, state=?, country=?, mobileNumber=?, orderDate=now(), deliveryDate=DATE_ADD(orderDate,INTERVAL 7 DAY), paymentMethod=?, transactionId=?, status=? where email=? and address is NULL";
	PreparedStatement ps2 = c.prepareStatement(q2);
	
	ps2.setString(1, address);
	ps2.setString(2, city);
	ps2.setString(3, state);
	ps2.setString(4, country);
	ps2.setString(5, mobileNumber);
	ps2.setString(6, paymentMode);
	ps2.setString(7, transactionId);
	ps2.setString(8, status);
	ps2.setString(9, email);
	
	ps2.executeUpdate();
	c.commit();
	c.close();
	response.sendRedirect("bill.jsp");
}
catch(Exception e) {
	System.out.println(e.getMessage());
	response.sendRedirect("home.jsp?msg=error");
}
%>