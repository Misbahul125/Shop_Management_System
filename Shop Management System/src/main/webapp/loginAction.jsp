<%@page import="project.SQLTableStatus"%>
<%@page import="project.ConnectionProvider"%>
<%@page import="project.CreateSQLTable"%>
<%@page import="project.UserConstant"%>
<%@page import="java.sql.*"%>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");

try{
	
	Connection c = ConnectionProvider.getConnectionProvider();
	Statement s = c.createStatement();
	
	if(!SQLTableStatus.isTableExixts("users")) {
		CreateSQLTable ct = new CreateSQLTable(c);
		ct.createUsersTable();
	}

	try {
		
		String q1 = "select * from users where email='"+email+"' and password='"+password+"'";
		
		ResultSet rs = s.executeQuery(q1);
		if(rs.next()) {
			
			String userType  = rs.getString("userType");
			
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
			response.sendRedirect("login.jsp?msg=notexist");
		}
	}
	catch(Exception e) {
		System.out.println(e.getMessage());
		c.close();
		response.sendRedirect("login.jsp?msg=somethingWrong");
	}
	
}
catch(Exception e) {
	System.out.println(e.getMessage());
	response.sendRedirect("login.jsp?msg=somethingwrong");
}
%>