<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/signup-style.css">
<title>ForgotPassword</title>
</head>
<body>
<div id='container'>
  <div class='signup'>
  
  	<form action="forgotPasswordAction.jsp" method="post">
  		<input type="email" name="email" placeholder="Enter Email" required>
  		<input type="number" name="mobileNumber" placeholder="Enter Mobile Number" required>
  		
  		<select name="securityQuestion" required>
  			<option value="What is the name of your country?">What is the name of your country?</option>
  			<option value="What is your favourite sports?">What is your favourite sports?</option>
  			<option value="What is the name of your first school?">What is the name of your first school?</option>
  			<option value="What is the name of your first pet?">What is the name of your first pet?</option>
  		</select>
  		<input type="text" name="securityAnswer" placeholder="Enter Security Answer" required>
  		
  		<input type="password" name="newPassword" placeholder="Enter New Password" required>
  		
  		<input type="submit" style="cursor:pointer" value="Change Password">
  	</form>
  
    <h2><a href="login.jsp">Login</a></h2>
  </div>
  
  <div class='whyforgotPassword'>
  	
	<%
  	String msg = request.getParameter("msg");
  	if("success".equals(msg)) {
  	%>
  	<h1>Password changed successfully</h1>
  	<%} %>
  	
  	<%
  	if("somethingWrong".equals(msg)) {
  	%>
  	<h1>Something Went Wrong! Try Again !</h1>
  	<%} %>
  	
  	<%
  	if("notexist".equals(msg)) {
  	%>
  	<h1>Invalid credentials !!</h1>
  	<%} %>

    <h2>Online Shopping</h2>
    
    <p>The Online Shopping System is the application that allows the users to shop online without going to the shops to buy them.</p>
    
  </div>
</div>
</body>
</html>