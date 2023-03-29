<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	
	<div>
		<div>
			<form method="post" action="naverEnroll">
				이메일 : <span>${ mem.memEmail }</span>
				<br><br>
				해당 계정으로 가입됩니다.
				
				<div>
					약관 동의 
					<input type="checkbox">
				</div>
				
				<button type="submit">가입하기</button>
				
				<input type="hidden" name="memEmail" value="${mem.memEmail}">
				<input type="hidden" name="memName" value="${mem.memName}">
				<input type="hidden" name="memMobile" value="${mem.memMobile}">
			</form>
		</div>
	
	
	
	</div>



</body>
</html>