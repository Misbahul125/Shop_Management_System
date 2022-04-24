<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>

<%
String id = request.getParameter("id");
String name = request.getParameter("name");
String category = request.getParameter("category");
String price = request.getParameter("price");
String active = request.getParameter("active");

try{
	
	Connection c = ConnectionProvider.getConnectionProvider();
	Statement s = c.createStatement();
	
	String q1 = "update product set name='"+name+"', category='"+category+"', price='"+price+"', active='"+active+"' where id='"+id+"'";
	s.executeUpdate(q1);
	
	//delete product from cart if its active field is set to No/Not Available 
	//only if it is not ordered
	if(active.equals("No")) {
		String q2 = "delete from cart where productId='"+id+"' and address is NULL";
		s.executeUpdate(q2);
	}
	
	c.close();
	response.sendRedirect("allProductEditProduct.jsp?msg=success");
	
}
catch(Exception e) {
	System.out.println(e.getMessage());
	response.sendRedirect("allProductEditProduct.jsp?msg=error");
}
%>