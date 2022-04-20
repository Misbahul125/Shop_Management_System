<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>

<%
String name = request.getParameter("name");
String mobileNumber = request.getParameter("mobileNumber");
String email = request.getParameter("email");
String password = request.getParameter("password");
String securityQuestion = request.getParameter("securityQuestion");
String securityAnswer = request.getParameter("securityAnswer");
String address = "";
String city = "";
String state = "";
String country = "";

try{
	String q1 = "insert into users values(?,?,?,?,?,?,?,?,?,?)";
	
	Connection c = ConnectionProvider.getConnectionProvider();
	PreparedStatement ps = c.prepareStatement(q1);
	
	ps.setString(1, name);
	ps.setString(2, email);
	ps.setString(3, mobileNumber);
	ps.setString(4, securityQuestion);
	ps.setString(5, securityAnswer);
	ps.setString(6, password);
	ps.setString(7, address);
	ps.setString(8, city);
	ps.setString(9, state);
	ps.setString(10, country);
	
	ps.executeUpdate();
	response.sendRedirect("signup.jsp?msg=valid");
}
catch(Exception e) {
	System.out.println(e.getMessage());
	response.sendRedirect("signup.jsp?msg=invalid");
}
%>