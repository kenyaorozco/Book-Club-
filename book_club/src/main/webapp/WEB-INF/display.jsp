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
<title>Display</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/main.css">
<!-- change to match your file/naming structure -->
<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<nav class="navbar">
		<h3>${book.title}</h3>
		<p>
			<a href="/dashboard">back to the shelves</a>
		</p>
	</nav>
	<c:choose>
		<c:when test="${user_Id eq book.users.id }">
			<p>You read ${book.title } by ${book.author}</p>
			<h2>Here are your thoughts:</h2>

		</c:when>
		<c:otherwise>
			<h2>Here are ${book.users.userName} thoughts:</h2>
		</c:otherwise>
	</c:choose>
	<p>${book.thoughts }</p>
	<c:if test="${user_Id eq book.users.id }">
		<button>
			<a href="/edit/${book.id}">edit</a>
		</button>
		<form action="/book/${book.id}" method="post">
			<input type="hidden" name="_method" value="delete"> <input
				type="submit" value="Delete">
		</form>
	</c:if>
	${user }
</body>
</html>