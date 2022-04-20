<%@page import="project.SQLTableStatus"%>
<%@page import="project.ConnectionProvider"%>
<%@page import="project.CreateSQLTable"%>
<%@page import="project.UserConstant"%>
<%@page import="java.sql.*"%>

<%
String name = request.getParameter("name");
String mobileNumber = request.getParameter("mobileNumber");
String email = request.getParameter("email");
String userType = "";

if(email.contains("@uem.edu.in")) {
	userType = UserConstant.ADMIN_USER.toString();
}
else {
	userType = UserConstant.NORMAL_USER.toString();
}

String password = request.getParameter("password");
String securityQuestion = request.getParameter("securityQuestion");
String securityAnswer = request.getParameter("securityAnswer");
String address = "";
String city = "";
String state = "";
String country = "";

try{
	
	Connection c = ConnectionProvider.getConnectionProvider();
	Statement s = c.createStatement();
	
	if(!SQLTableStatus.isTableExixts("users")) {
		CreateSQLTable ct = new CreateSQLTable(c);
		ct.createUsersTable();
	}
	
	String q1 = "select * from users where email='"+email+"' and mobileNumber='"+mobileNumber+"'";
	try {
		ResultSet rs = s.executeQuery(q1);
		if(rs.next()) {
			System.out.println("User exists");
			c.close();
			response.sendRedirect("signup.jsp?msg=userexists");
		}
		else {
			try {
				String q2 = "insert into users values(?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement ps = c.prepareStatement(q2);
				
				ps.setString(1, name);
				ps.setString(2, mobileNumber);
				ps.setString(3, email);
				ps.setString(4, password);
				ps.setString(5, userType);
				ps.setString(6, securityQuestion);
				ps.setString(7, securityAnswer);
				ps.setString(8, address);
				ps.setString(9, city);
				ps.setString(10, state);
				ps.setString(11, country);
				
				boolean b = ps.execute();
				//response.sendRedirect("signup.jsp?msg=valid");
				
				if(b) {
					session.setAttribute("user_type", userType);
					c.close();
					if(userType.matches(UserConstant.ADMIN_USER.toString())) {
						response.sendRedirect("/admin/adminHome.jsp");
					}
					else {
						response.sendRedirect("home.jsp");
					}
				}
				else {
					c.close();
					response.sendRedirect("signup.jsp?msg=somethingWrong");
				}
			}
			catch(Exception e) {
				System.out.println(e.getMessage());
				c.close();
				response.sendRedirect("signup.jsp?msg=somethingWrong");
			}
		}
	}
	catch(Exception e) {
		System.out.println(e.getMessage());
		c.close();
		response.sendRedirect("signup.jsp?msg=somethingWrong");
	}
	
}
catch(Exception e) {
	System.out.println(e.getMessage());
	response.sendRedirect("signup.jsp?msg=somethingWrong");
}
%>