<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<%@include file="../footer.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="css/addressPaymentForOrder-style.css">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<title>Home</title>
	<script>
		if(window.history.forward(1)) {
			window.history.forward();
		}
	</script>
</head>
<body>
<br>
<table>
<thead>

<%
String email = session.getAttribute("email").toString();
int total=0, sno=0;
try{
	Connection c = ConnectionProvider.getConnectionProvider();
	Statement s = c.createStatement();
	 
	String q1 = "select sum(subTotal) from cart where email='"+email+"'";

	ResultSet rs1 = s.executeQuery(q1);
	while(rs1.next()) {
		total = rs1.getInt(1);
	}
%>

          <tr>
          <th scope="col"><a href="myCart.jsp"><i class='fas fa-arrow-circle-left'> Back</i></a></th>
            <th scope="col" style="background-color: yellow;">Total: <i class="fa fa-inr"></i> <%out.println(total); %></th>
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
          </tr>
        </thead>
        <tbody>
        
        <%
        	String q2 = "select * from cart where email='"+email+"'";
      		ResultSet rs2 = s.executeQuery(q2);
      		while(rs2.next()) {
      	%>
        
          <tr>
          <%sno = sno+1; %>
            <td><%out.println(sno); %></td>
            <td><%=rs2.getString(4) %></td>
            <td><%=rs2.getString(5) %></td>
            <td><i class="fa fa-inr"></i> <%=rs2.getString(7) %></td>
            
            <td>
            <a href="cartQuantityAction.jsp?id=<%=rs2.getString(2) %>&quantity=inc">
            <i class='fas fa-plus-circle'></i>
            </a> 
            <%=rs2.getString(6) %> 
            <a href="cartQuantityAction.jsp?id=<%=rs2.getString(2) %>&quantity=dec">
            <i class='fas fa-minus-circle'></i></a>
            </td>
            
            <td><i class="fa fa-inr"></i> <%=rs2.getString(8) %> </td>
            </tr>
         <%}
      		String q3 = "select * from users where email='"+email+"'";
      		ResultSet rs3 = s.executeQuery(q3);
      		while(rs3.next()) {
      			
         %>
        </tbody>
      </table>
      
<hr style="width: 100%">

<form action="addressPaymentForOrderAction.jsp?<%=total %>" method="post">

<div class="left-div">
<h3>Mobile Number</h3>
<input class="input-style" type="number" name="mobileNumber" value="<%=rs3.getString(3) %>" placeholder="Enter Mobile Number" required>
<h3 style="color: red">*This mobile number will also updated to your profile</h3>
</div>

<div class="right-div">
<h3>Enter pincode</h3>
	<input class="input-style" type="number" name="pincode" value="<%=rs3.getInt(12) %>" placeholder="Enter Pincode" required>
</div>

 <div class="left-div">
 <h3>Enter Address</h3>
 	<input class="input-style" type="text" name="address" value="<%=rs3.getString(7) %>" placeholder="Enter Address" required>
 </div>

<div class="right-div">
<h3>Enter city</h3>
	<input class="input-style" type="text" name="city" value="<%=rs3.getString(8) %>" placeholder="Enter City" required>
</div> 

<div class="left-div">
<h3>Enter State</h3>
	<input class="input-style" type="text" name="state" value="<%=rs3.getString(9) %>" placeholder="Enter State" required>
</div>

<div class="right-div">
<h3>Enter country</h3>
	<input class="input-style" type="text" name="country" value="<%=rs3.getString(10) %>" placeholder="Enter Country" required>
</div>
<h3 style="color: red">*If there is no address its mean that you did not set you address!</h3>
<h3 style="color: red">*This address will also updated to your profile</h3>
<hr style="width: 100%">
<div class="left-div">
<h3>Select way of Payment</h3>
 <select class="input-style" name="paymentMode">
 	<option value="Cash on delivery (COD)">Cash on delivery (COD)</option>
 	<option value="Online Payment">Online Payment</option>
 </select>
</div>

<div class="right-div">
<h3 style="color: red">*If you enter wrong transaction id then your order will we can cancel!</h3>
<button class="input-style" type="submit"> Proceed to Order & Generate Bill <i class='far fa-arrow-alt-circle-right'></i></button>
<h3 style="color: red">*Fill form correctly</h3>
</div>

<!-- <div class="right-div">
<h3>Pay online on this btechdays@pay.com</h3>
<input class="input-style" type="text" name="transactionId" placeholder="Enter Transaction ID">
<h3 style="color: red">*If you select online Payment then enter you transaction ID here otherwise leave this blank</h3>
</div> -->
<!-- <hr style="width: 100%">
 -->

<!-- <div class="right-div">
<h3 style="color: red">*If you enter wrong transaction id then your order will we can cancel!</h3>
<button class="input-style" type="submit"> Proceed to Order & Generate Bill <i class='far fa-arrow-alt-circle-right'></i></button>
<h3 style="color: red">*Fill form correctly</h3>
</div> -->
</form>

<%
      		}
c.close();      		
}
catch(Exception e) {
	System.out.println(e.getMessage());
}
%>

      <br>
      <br>
      <br>

</body>
</html>