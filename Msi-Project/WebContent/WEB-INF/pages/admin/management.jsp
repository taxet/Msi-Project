<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Management</title>
</head>
<body>
<table border="1">
	<tr>
		<th>firstname</th>
		<th>lastname</th>
		<th>email</th>
		<th>username</th>
		<th>config</th>
		<th>active</th>
		<th>active</th>
	</tr>
	<c:forEach var="trader" items="${traderInfo.traders}">
		<tr>
			<td>${trader.first_name}</td>
			<td>${trader.last_name}</td>
			<td>${trader.email}</td>
			<td>${trader.login.username}</td>
			<td><a href="config/${trader.lid}.htm">config</a></td>
			<td>${trader.active }</td>
			<td><a href="active/${trader.lid}.htm">active</a></td>
		</tr>
	</c:forEach>
</table>
<a href="<c:url value='/j_spring_security_logout'/>">Logout</a>
</body>
</html>