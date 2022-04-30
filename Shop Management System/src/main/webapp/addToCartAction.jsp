<%@page import="project.ConnectionProvider"%>
<%@page import="java.sql.*"%>

<%
String email = session.getAttribute("email").toString();
String productId = request.getParameter("id");
String category="", productName="";
int cartProductId=1, quantity=1 , productPrice=0 , productTotal=0 , cartTotal=0;
boolean isProductExist = false;
Connection c = null;

try{
	c = ConnectionProvider.getConnectionProvider();
	Statement s = c.createStatement();
	c.setAutoCommit(false);
	
	//get product's detail
	String q1 = "select * from product where id='"+productId+"'";
	ResultSet rs1 = s.executeQuery(q1);
	//if product exists in db
	if(rs1.next()) {
		int q = rs1.getInt(6);
		
		if(q>0) {
			//fetch product price
			productName = rs1.getString(2);
			category = rs1.getString(3);
			productPrice = rs1.getInt(4);
			productTotal = productPrice;
			
			//fetch the last count of order 
			String q2 = "select max(cartProductId) from orders where email='"+email+"'";
			ResultSet rs2 =  s.executeQuery(q2);
			if(rs2.next()) {
				cartProductId = rs2.getInt(1);
				if(Integer.toString(cartProductId) != null) {
					cartProductId++;
				}
				else {
					cartProductId = 1;
				}
			}
			
			/* //check if cart is empty or not for a particular user
			String q2 = "select * from cart where email='"+email+"'";
			ResultSet rs2 = s.executeQuery(q2);
			//if something is already in cart
			if(rs2.next()) {
				String q3 = "select max(cartProductId) from cart where email='"+email+"'";
				ResultSet rs3 =  s.executeQuery(q3);
				if(rs3.next()) {
					cartProductId = rs3.getInt(1);
					System.out.println(Integer.toString(cartProductId));
				}
				else {
					System.out.println("Max id not found");
				} 
			}
			//if cart is empty
			else {
				String q = "select max(cartProductId) from orders where email='"+email+"'";
				ResultSet rs =  s.executeQuery(q);
				if(rs.next()) {
					cartProductId = rs.getInt(4);
				}
				else {
					cartProductId = 1;
				} 
				
			}*/
					
			//if product already exists in cart then update its quantity and price
			String q3 = "select * from cart where productId='"+productId+"' and email='"+email+"'";
			ResultSet rs3 = s.executeQuery(q3);
			while(rs3.next()) {
				cartTotal = rs3.getInt(8);
				cartTotal = cartTotal+productTotal;
				quantity = rs3.getInt(6);
				quantity = quantity+1;
				
				isProductExist = true;
			}
			
			String q4="";
			if(isProductExist) {
				q4 = "update cart set subTotal='"+cartTotal+"', quantity='"+quantity+"' where productId="+productId+" and email='"+email+"'";
				s.executeUpdate(q4);
				c.commit();
				c.close();
				response.sendRedirect("home.jsp?msg=exist");
			}
			else {
				q4 = "insert into cart(email,productId,cartProductId,productName,category,quantity,price,subTotal) values(?,?,?,?,?,?,?,?)";
				PreparedStatement ps1 = c.prepareStatement(q4);
				ps1.setString(1, email);
				ps1.setString(2, productId);
				ps1.setInt(3, cartProductId);
				ps1.setString(4, productName);
				ps1.setString(5, category);
				ps1.setInt(6, quantity);
				ps1.setInt(7, productPrice);
				ps1.setInt(8, productTotal);
				ps1.executeUpdate();
				
				c.commit();
				c.close();
				response.sendRedirect("home.jsp?msg=added");
			}
		}
		else {
			System.out.println("Product is not available right now");
		}
		
	}
	else {
		System.out.println("Something went wrong, product doesn't exists");
	}
	
}
catch(Exception e) {
	c.rollback();
	c.close();
	System.out.println(e.getMessage());
	response.sendRedirect("home.jsp?msg=error");
}
%>