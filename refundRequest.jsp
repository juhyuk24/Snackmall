<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import="java.time.LocalDateTime" import="java.time.format.DateTimeFormatter"%>
    
<%
	Cookie ck[] =request.getCookies();
	String cId; 
	if(ck.length>=2 && ck[1].getName().equals("ID")){
		cId = (String) ck[1].getValue();
	}
	String number = request.getParameter("주문번호");
	Connection conn = null;
	PreparedStatement pstmt1 = null;
	ResultSet rs = null;
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/newdb";
		String userName="root";
		String password="pjypjypjy";
		conn = DriverManager.getConnection(url, userName, password);
		
		
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환불요청</title>
<style>
	table{
    width: 70%;
    margin-left:15%;
    margin-right:15%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
  div {
    width: 70%;
    margin-left:15%;
    margin-right:15%; 
  }
</style>
</head>
<body>
	<br>
	
	<br>
	<form method="get" action="refund.jsp">
	<div style="position:relative; left:18%">
		환불 요청 사유<br><br>
	</div>	
		<input type="text" name="number" style="visibility:hidden" value="<%=number%>">
		<input type="text" name="refundReason" size=30 style="position:relative; left:15%"><br><br>
	<div style="position:relative; left:13%">
		<button type="submit" class="btn btn-info" style="margin:10px;">환불요청<i class="fa fa-check spaceLeft"></i></button>
		<input type="button" value="취소" onClick="window.close()">
	</div>		
	</form>	

</body>
</html>

<%		
	
	} catch (ClassNotFoundException e){
		out.println(e);
	} catch (SQLException e){
		out.println(e);
	} finally {
		
		 	
	}
	
%>