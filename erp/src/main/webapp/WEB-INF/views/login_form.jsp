<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
  	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

	<style>
		
		img:hover {
			cursor: pointer;
		}
	
	</style>

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
			<form>
				<table>
					<tr>
						<td>
							<input type="text" name="user_id">
						</td>
						<td rowspan="2">
							<button type="submit">로그인</button>
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" name="user_pwd">					
						</td>
					</tr>
				</table>
				
				<br>
				
				
			</form>
		</div>
		<div>
			<div class="otherButton text-center">
				<img width="150px" height="40px" src='http://static.nid.naver.com/oauth/big_g.PNG' onclick="location.href='${url}'">
			</div>		
		</div>
	
	
	
	</div>




</body>
</html>