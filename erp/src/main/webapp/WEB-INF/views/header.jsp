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
	
	<c:choose>
		<c:when test="${ not empty loginMember }">
			<div>
				<span>${loginMember.memName}(${loginMember.memEmail})님 환영합니다.</span>
			</div>
			<div>
				<a href="logout.do">로그아웃</a>
				<c:if test="${ not empty accessToken }">
					<a href="deleteNaverLogin.do">네이버 연동 해제</a>
				</c:if>
			</div>
		</c:when>
		<c:otherwise>
			<div>
				<a href="login">로그인하기</a>	
			</div>			
			<div>
				<a href="signIn">회원가입</a>	
			</div>
		</c:otherwise>
	</c:choose>

	
	<c:if test="${not empty alertMsg}">
		<script>
			alert('${alertMsg}');
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>


</body>
</html>