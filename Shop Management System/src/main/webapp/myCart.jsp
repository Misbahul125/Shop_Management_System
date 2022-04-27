<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@include file="header.jsp" %>
<%@include file="../footer.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Cart</title>
<style>
h3
{
	color: yellow;
	text-align: center;
}
</style>
</head>
<body>
<div style="color: white; text-align: center; font-size: 30px;">My Cart <i class='fas fa-cart-arrow-down'></i></div>

<%
  	String msg = request.getParameter("msg");
  	if("one".equals(msg)) {
  	%>
  	<h3 class="alert">There is only one Quantity! So click on remove!</h3>
  	<%} %>
  	
  	<%
  	if("increased".equals(msg)) {
  	%>
  	<h3 class="alert">Quantity  Increased Successfully!</h3>
  	<%} %>
  	
  	<%
  	if("decreased".equals(msg)) {
  	%>
  	<h3 class="alert">Quantity  Decreased Successfully!</h3>
  	<%} %>
  	
  	<%
  	if("removed".equals(msg)) {
  	%>
  	<h3 class="alert">Product Removed Successfully!</h3>
  	<%} %>
  	
  	<%
  	if("error".equals(msg)) {
  	%>
  	<h3>Something Went Wrong! Try Again !</h3>
  	<%} %>
  	

<table>
<thead>

<%
int total=0 , sno=0;
try{
	Connection c = ConnectionProvider.getConnectionProvider();
	Statement s = c.createStatement();
	 
	String q1 = "select sum(total) from cart where email='"+email+"' and address is NULL";

	ResultSet rs1 = s.executeQuery(q1);
	while(rs1.next()) {
		total = rs1.getInt(1);
	}
%>

          <tr>
            <th scope="col" style="background-color: yellow;">Total: <i class="fa fa-inr"></i> <%out.println(total); %></th>
            <%if(total>0) { %>
            <th scope="col"><a href="addressPaymentForOrder.jsp">Proceed to order</a></th>
            <%} %>
          </tr>
        </thead>
        <thead>
          <tr>
          <th scope="col">S.No</th>
            <th scope="col">Product Name</th>
            <th scope="col">Category</th>
            <th scope="col"><i class="fa fa-inr"></i> price</th>
            <th scope="col">Quantity</th>
            <th scope="col">Sub Total</th>
            <th scope="col">Remove <i class='fas fa-trash-alt'></i></th>
          </tr>
        </thead>
        <tbody>
      		<%
      		String q2 = "select * from product inner join cart on product.id=cart.productId and cart.email='"+email+"' and cart.address is NULL";
      		ResultSet rs2 = s.executeQuery(q2);
      		while(rs2.next()) {
      		%>
          <tr>
          <%sno = sno+1; %>
           <td><%out.println(sno); %></td>
            <td><%=rs2.getString(2) %></td>
            <td><%=rs2.getString(3) %></td>
            <td><i class="fa fa-inr"></i> <%=rs2.getString(4) %></td>
            <td><a href="cartQuantityAction.jsp?id=<%=rs2.getString(1) %>&quantity=inc"><i class='fas fa-plus-circle'></i></a> <%=rs2.getString(8) %> <a href="cartQuantityAction.jsp?id=<%=rs2.getString(1) %>&quantity=dec"><i class='fas fa-minus-circle'></i></a></td>
            <td><i class="fa fa-inr"></i> <%=rs2.getString(10) %> </td>
            <td><a href="removeCartProduct.jsp?id=<%= rs2.getString(1) %>">Remove <i class='fas fa-trash-alt'></i></a></td>
          </tr>
<%
      		}
      		c.close();
}
catch(Exception e) {
	System.out.println(e.getMessage());
}
%>
        </tbody>
      </table>
      <br>
      <br>
      <br>

</body>
</html>