<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@include file="../footer.jsp" %>

<html>
<head>
<link rel="stylesheet" href="css/bill.css">
<title>Bill</title>
</head>
<body>
<%
String email = session.getAttribute("email").toString();
String orderId = request.getParameter("orderID");
try{
	int total=0;
	int sno=0;
	Connection c = ConnectionProvider.getConnectionProvider();
	Statement s = c.createStatement();
	String q1 = "select sum(subTotal) from orders where email='"+email+"' and orderId='"+orderId+"'";
	ResultSet rs1 = s.executeQuery(q1);
	if(rs1.next()) {
		total = rs1.getInt(1);
	}
	
	String q2 = "select * from orders where email='"+email+"' and orderId='"+orderId+"'";
	ResultSet rs2 = s.executeQuery(q2);
	while(rs2.next()) {
		

%>
<h3>Online shopping Bill (BTech Days)</h3>
<hr>
<div class="left-div"><h3>Name:  <%=rs2.getString(1) %></h3></div>
<div class="right-div-right"><h3>Email:  <%out.println(email); %></h3></div>
<div class="right-div"><h3>Mobile Number:  <%=rs2.getString(3) %></h3></div>  

<div class="left-div"><h3>Order Date:  <%=rs2.getString(16) %></h3></div>
<div class="right-div-right"><h3>Payment Method:  <%=rs2.getString(18) %></h3></div>
<div class="right-div"><h3>Expected Delivery:  <%=rs2.getString(17) %></h3></div> 

<div class="left-div"><h3>Order Id:  <%=rs2.getString(19) %></h3></div>
<div class="right-div-right"><h3>City:  <%=rs2.getString(12) %></h3></div> 
<div class="right-div"><h3>Address:  <%=rs2.getString(11) %></h3></div> 

<div class="left-div"><h3>State:  <%=rs2.getString(13) %></h3></div>
<div class="right-div-right"><h3>Country:  <%=rs2.getString(14) %></h3></div>  

<hr>
<%break;} %>

	
	<br>
	
<table id="customers">
<h3>Product Details</h3>
  <tr>
    <th>S.No</th>
    <th>Product Name</th>
    <th>category</th>
    <th>Price</th>
    <th>Quantity</th>
     <th>Sub Total</th>
  </tr>
  
  <%
  	String q3 = "select * from orders where email='"+email+"' and orderId='"+orderId+"'";
	ResultSet rs3 = s.executeQuery(q3);
	while(rs3.next()) {
		sno++;
  %>
  
  <tr>
    <td><%out.println(sno); %></td>
    <td><%=rs3.getString(6) %></td>
    <td><%=rs3.getString(7) %></td>
    <td><%=rs3.getString(9) %></td>
    <td><%=rs3.getString(8) %></td>
    <td><%=rs3.getString(10) %></td>
  </tr>
  <tr>
<%} %>
</table>
<h3>Total: <%out.println(total); %></h3>
<a href="continueShopping.jsp"><button class="button left-button">Continue Shopping</button></a>
<a onclick="window.print();"><button class="button right-button">Print</button></a>
<br><br><br><br>

<%
c.close();      		
}
catch(Exception e) {
	System.out.println(e.getMessage());
}
%>
</body>
</html>