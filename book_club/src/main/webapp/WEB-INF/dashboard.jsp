<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (dates) -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<!-- change to match your file/naming structure -->
<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>

	<nav class="navbar navbar-dark bg-dark">
		<h3 class="text-white">
			Welcome,
			<c:out value="${user.userName}"></c:out>
			!
		</h3>
		<p><a href="/logout">logout</a></p>
	</nav>
	<div class="navbar">
		<p>Books from everyone's shelves:</p>
		<p>	<a href="/create">+ Add to my shelf</a></p>
	</div>
	<table class="table">
		<thead>
			<tr>
				<th scope="col">ID</th>
				<th scope="col">Title</th>
				<th scope="col">Author Name</th>
				<th scope="col">Posted By:</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${allDaBooks }" var="info">
				<tr>
					<th scope="row">${info.id }</th>
					<td><a href="display/${info.id}">${info.title}
					</a></td>
					<td>${info.author }</td>
					<td>${info.users.userName}</td>
				</tr>
			</c:forEach>

		</tbody>
	</table>

</body>
</html>