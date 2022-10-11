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
<title>Create a new Book</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/main.css">
<!-- change to match your file/naming structure -->
<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<nav class="navbar">
		<h3>Add a Book to Your Shelf!</h3>
		<p>
			<a href="/dashboard">back to the shelves</a>
		</p>
	</nav>
	<p>${user} ${user_Id}</p>
	<form:form action="/newBook" method="post" modelAttribute="books">
		<!-- Allows for our db to know who created a post  -->
		<form:input type="hidden" path="users" value="${user_Id}" />
		<form:errors style="color: red;" path="*" />
		<div class="mb-3">
			<form:label path="title">Title:</form:label>
			<form:input path="title" />
		</div>
		<div class="mb-3">
			<form:label path="author">Author </form:label>
			<form:input path="author" />
		</div>
		<div class="mb-3">
			<form:label path="thoughts">My thoughts: </form:label>
			<form:textarea path="thoughts" />
		</div>

		<button type="submit" class="btn btn-primary">Submit</button>
	</form:form>

</body>
</html>