<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>

<%
String email = session.getAttribute("email").toString();
String id = request.getParameter("id");
String action = request.getParameter("quantity");
int price=0, total=0, quantity=0, finalTotal=0;
try{
	Connection c = ConnectionProvider.getConnectionProvider();
	Statement s = c.createStatement();
//	c.setAutoCommit(false);
	
	String q1 = "delete from cart where email='"+email+"' and productId="+id+" and address is NULL";
	s.executeUpdate(q1);
	c.close();
	response.sendRedirect("myCart.jsp?msg=removed");
	
}
catch(Exception e) {
	System.out.println(e.getMessage());
	response.sendRedirect("home.jsp?msg=error");
}
%>