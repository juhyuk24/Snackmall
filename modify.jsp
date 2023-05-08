<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
	
<%
	request.setCharacterEncoding("UTF-8"); 
%>
<%
	String pNumber = request.getParameter("상품번호");
	String pName = request.getParameter("상품명");
	String pPrice = request.getParameter("가격");
	String pCount = request.getParameter("재고량");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
		
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/newdb";
		String userName="root";
		String password="pjypjypjy";
		String type1 = "0";
		conn = DriverManager.getConnection(url, userName, password);
		
		String sql = "select 상품번호, 상품명, 가격, 재고량 from 상품 where 상품번호=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,pNumber);
		
		rs = pstmt.executeQuery();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<style>
 
 table {
 	width:70%;
 	margin-left:15%;
 	margin-right:15%;
 }
 
 th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
    text-align: center;
 }
</style>
<script>
	function checkValue(){
		inputForm = eval("document.modifyInfo");
		if(!inputForm.productName.value){
			alert("상품명을 입력하세요");
			inputForm.productName.focus();
			return false;
		}
		if(!inputForm.productPrice.value){
			alert("가격을 입력하세요");
			inputForm.productPrice.focus();
			return false;
		}
		if(!inputForm.productCount.value){
			alert("재고량을 입력하세요");
			inputForm.productCount.focus();
			return false;
		}
	}
	
</script>
</head>
<body>
	<div>
	<form name="modifyInfo" method="post" action="modifyPro.jsp" onsubmit="return checkValue()" >
		
		
		<table>
			
			<% while(rs.next()) {%>
			<tr>
				<td><input type="hidden" name = "productNumber" value='<%=rs.getString(1)%>'></td>
			</tr>
			<tr>
				<td>상품명 : <input type="text"  name ="productName" placeholder='<%=rs.getString(2)%>'></td>
			</tr>
			<tr>
              	<td>단가 : <input type="text"  name ="productPrice" placeholder='<%=rs.getString(3) %>'></td>
            </tr>
            <tr>  	
              	<td>재고량 : <input type="text"  name ="productCount" placeholder='<%=rs.getString(4)%>'></td>
			</tr>
			<%} %>	
			<tr>
				<td><input type="submit" value="수정" >&nbsp<input type="button" value="취소" onClick="window.close()"></td>
			
			</tr>
		</table>
	</form>
	</div>
</body>
</html>
	
	

<%		
	} catch (ClassNotFoundException e){
		out.println(e);
	} catch (SQLException e){
		out.println(e);
	}
%>