<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<!-- Not Finished -->
<form name="f" action="<c:url value='j_spring_security_check'/>" method="POST" id="login-form">
	<input type="text" name="r_username" id="r_username"/>
	<input type="password" name="r_password" id="r_password"/>
	<input type="password" name="r_r_password" id="r_r_password"/>
	<input type="number" name="r_phone" id="r_phone"/>
	<input type="email" name="r_email" id="r_email"/>
	<input type="text" name="r_address" id="r_address"/>
	<input type="text" name="r_city" id="r_city"/>
	<input type="number" name="r_zipcode" id="r_zipcode"/>
</form>
</body>
</html>