<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${not empty alertMsg}">
		<script>
			alert('${alertMsg}');
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>

	<div>
	
		<div>
			<a href="#">이메일로 회원가입</a>
		</div>
		<div>
			<a href="${url}">네이버아이디로 간편 회원가입</a>
		</div>
	
	
	</div>

</body>
</html>