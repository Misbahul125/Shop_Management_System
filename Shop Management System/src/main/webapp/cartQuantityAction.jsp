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
	
	String q1 = "select * from cart where email='"+email+"' and productId="+id+" and address is NULL";
	ResultSet rs1 = s.executeQuery(q1);
	while(rs1.next()) {
		price = rs1.getInt(4);
		total = rs1.getInt(5);
		quantity = rs1.getInt(3);
		
	}
	
	String q2 = "";
	
	if(quantity==1 && action.equals("dec")) {
		c.close();
		response.sendRedirect("myCart.jsp?msg=one");
	}
	else if(quantity!=1 && action.equals("dec")) {
		total = total-price;
		quantity--;
		q2 = "update cart set total="+total+", quantity="+quantity+" where email='"+email+"' and productId="+id+" and address is NULL";
		s.executeUpdate(q2);
		c.close();
		response.sendRedirect("myCart.jsp?msg=decreased");
	}
	else {
		total = total+price;
		quantity++;
		q2 = "update cart set total="+total+", quantity="+quantity+" where email='"+email+"' and productId="+id+" and address is NULL";
		s.executeUpdate(q2);
		c.close();
		response.sendRedirect("myCart.jsp?msg=increased");
	}
}
catch(Exception e) {
	System.out.println(e.getMessage());
	response.sendRedirect("home.jsp?msg=error");
}
%>