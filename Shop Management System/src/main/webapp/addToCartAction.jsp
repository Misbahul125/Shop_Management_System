<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>

<%
String email = session.getAttribute("email").toString();
String productId = request.getParameter("id");
int quantity=1 , productPrice=0 , productTotal=0 , cartTotal=0;
boolean isProductExist = false;

try{
	Connection c = ConnectionProvider.getConnectionProvider();
	Statement s = c.createStatement();
	c.setAutoCommit(false);
	
	//get product's detail
	String q1 = "select * from product where id='"+productId+"'";
	ResultSet rs1 = s.executeQuery(q1);
	while(rs1.next()) {
		productPrice = rs1.getInt(4);
		productTotal = productPrice;
		
	}
	
	//if product already exists in cart yhen update its quantity and price
	String q2 = "select * from cart where productId='"+productId+"' and email='"+email+"' and address is NULL";
	ResultSet rs2 = s.executeQuery(q2);
	while(rs2.next()) {
		cartTotal = rs2.getInt(5);
		cartTotal = cartTotal+productTotal;
		quantity = rs2.getInt(3);
		quantity = quantity+1;
		
		isProductExist = true;
	}
	
	String q3="";
	if(isProductExist) {
		q3 = "update cart set total='"+cartTotal+"', quantity='"+quantity+"' where productId="+productId+" and email='"+email+"' and address is NULL";
		s.executeUpdate(q3);
		c.commit();
		c.close();
		response.sendRedirect("home.jsp?msg=exist");
	}
	else {
		q3 = "insert into cart(email,productId,quantity,price,total) values(?,?,?,?,?)";
		PreparedStatement ps = c.prepareStatement(q3);
		ps.setString(1, email);
		ps.setString(2, productId);
		ps.setInt(3, quantity);
		ps.setInt(4, productPrice);
		ps.setInt(5, productTotal);
		ps.executeUpdate();
		
		c.commit();
		c.close();
		response.sendRedirect("home.jsp?msg=added");
	}
}
catch(Exception e) {
	System.out.println(e.getMessage());
	response.sendRedirect("home.jsp?msg=error");
}
%>