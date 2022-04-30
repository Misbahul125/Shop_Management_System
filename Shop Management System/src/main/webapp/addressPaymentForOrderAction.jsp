<%@page import="project.ConnectionProvider"%>
<%@page import="project.OrderStatusConstant"%>
<%@page import="java.sql.*"%>

<%
String email = session.getAttribute("email").toString();
String name = "" , orderDate="", deliveryDate="";
String cartTotal = request.getParameter("total");
String address = request.getParameter("address");
int pincode = Integer.parseInt((request.getParameter("pincode")));
String city = request.getParameter("city");
String state = request.getParameter("state");
String country = request.getParameter("country");
String mobileNumber = request.getParameter("mobileNumber");
String paymentMode = request.getParameter("paymentMode");
String status = OrderStatusConstant.PROCESSING.toString();

Connection c = null;

try{
	c = ConnectionProvider.getConnectionProvider();
	Statement s = c.createStatement();
	c.setAutoCommit(false);
	
	String q1 = "update users set address=?, city=?, state=?, country=?, mobileNumber=?, pincode=? where email=?";
	PreparedStatement ps1 = c.prepareStatement(q1);
	
	ps1.setString(1, address);
	ps1.setString(2, city);
	ps1.setString(3, state);
	ps1.setString(4, country);
	ps1.setString(5, mobileNumber);
	ps1.setInt(6, pincode);
	ps1.setString(7, email);
	ps1.executeUpdate();
	
	System.out.println("1");
	
	String q2 = "select name from users where email='"+email+"'";
	ResultSet rs2 = s.executeQuery(q2);
	if(rs2.next()) {
		name = rs2.getString(1);
		System.out.println("2");
	}
	
	String q3 = "select NOW()";
	ResultSet rs3 = s.executeQuery(q3);
	if(rs3.next()) {
		orderDate = rs3.getString(1);
		System.out.println("3");
	}
	
	String q4 = "select DATE_ADD(NOW(), INTERVAL 7 DAY)";
	ResultSet rs4 = s.executeQuery(q4);
	if(rs4.next()) {
		deliveryDate = rs4.getString(1);
		System.out.println("4");
	}
	
	String orderId = "OID"+(Long.toString(System.currentTimeMillis()));
	
	String q6 = "";
	PreparedStatement ps6;
	
	String q5 = "select * from cart where email='"+email+"'";
	ResultSet rs5 = s.executeQuery(q5);
	while(rs5.next()) {
		
		System.out.println("5");
		
		//q6 = "insert into orders values(name=?,email=?, mobileNumber=?,productId=?,cartProductId=?,productName=?,category=?,quantity=?,price=?,subTotal=?,address=?,city=?,state=?,country=?,pincode=?,orderDate=?,deliveryDate=?,paymentMethod=?,orderId=?,status=?)";
		q6 = "insert into orders values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		ps6 = c.prepareStatement(q6);
		
		ps6.setString(1, name);
		ps6.setString(2, email);
		ps6.setString(3, mobileNumber);
		ps6.setInt(4, rs5.getInt(2));
		ps6.setInt(5, rs5.getInt(3));
		ps6.setString(6, rs5.getString(4));
		ps6.setString(7, rs5.getString(5));
		ps6.setInt(8, rs5.getInt(6));
		ps6.setInt(9, rs5.getInt(7));
		ps6.setInt(10, rs5.getInt(8));
		ps6.setString(11, address);
		ps6.setString(12, city);
		ps6.setString(13, state);
		ps6.setString(14, country);
		ps6.setInt(15, pincode);
		ps6.setString(16, orderDate);
		ps6.setString(17, deliveryDate);
		ps6.setString(18, paymentMode);
		ps6.setString(19, orderId);
		ps6.setString(20, status);
		ps6.executeUpdate();
		
		System.out.println("6");
		
	}
	
	String q7 = "delete from cart where email='"+email+"'";
	s.executeUpdate(q7);
	
	System.out.println("7");
	
	c.commit();
	c.close();
	response.sendRedirect("bill.jsp?orderID="+orderId);
}
catch(Exception e) {
	c.rollback();
	c.close();
	System.out.println(e.getMessage());
	response.sendRedirect("home.jsp?msg=error");
}
%>