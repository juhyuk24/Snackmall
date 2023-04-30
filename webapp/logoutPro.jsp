<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<% 
		Cookie ck[] =request.getCookies();
		
			for(int i=1; i<ck.length; i++){
				ck[i].setMaxAge(0);
				ck[i].setPath("/");
				response.addCookie(ck[i]);
			}
		
		
	%>
	<script>
	alert("로그아웃 되었습니다.");
	location.href=("index.jsp");
	</script>
</body>
</html>