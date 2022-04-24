<%@page import="project.SQLTableStatus"%>
<%@page import="project.ConnectionProvider"%>
<%@page import="project.CreateSQLTable"%>
<%@page import="project.UserConstant"%>
<%@page import="java.sql.*"%>

<%
String mobileNumber = request.getParameter("mobileNumber");
String email = request.getParameter("email");

String newPassword = request.getParameter("newPassword");
String securityQuestion = request.getParameter("securityQuestion");
String securityAnswer = request.getParameter("securityAnswer");

try{
	
	Connection c = ConnectionProvider.getConnectionProvider();
	Statement s = c.createStatement();
	
	//check user existence
	String q1 = "select * from users where email='"+email+"' and mobileNumber='"+mobileNumber+"' and securityQuestion='"+securityQuestion+"' and securityAnswer='"+securityAnswer+"'";
	try {
		ResultSet rs = s.executeQuery(q1);
		if(rs.next()) {
			System.out.println("User exists");
			
			//update password
			String q2 = "update users set password='"+newPassword+"' where email='"+email+"' and mobileNumber='"+mobileNumber+"' and securityQuestion='"+securityQuestion+"' and securityAnswer='"+securityAnswer+"'";
			
			s.executeUpdate(q2);
			c.close();
			response.sendRedirect("forgotPassword.jsp?msg=success");
			
		}
		else {
			c.close();
			response.sendRedirect("forgotPassword.jsp?msg=notexist");
		}
	}
	catch(Exception e) {
		System.out.println(e.getMessage());
		c.close();
		response.sendRedirect("forgotPassword.jsp?msg=somethingWrong");
	}
	
}
catch(Exception e) {
	System.out.println(e.getMessage());
	response.sendRedirect("forgotPassword.jsp?msg=somethingWrong");
}
%>