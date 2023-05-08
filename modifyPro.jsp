<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
	
<%
	request.setCharacterEncoding("UTF-8"); 
%>
<%
	String pNumber = request.getParameter("productNumber");
	String pName = request.getParameter("productName");
	String pPrice = request.getParameter("productPrice");
	String pCount = request.getParameter("productCount");
	
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
		
		String sql = "update 상품 set 상품명=?,가격=?,재고량=? where 상품번호=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,pName);
		pstmt.setString(2,pPrice);
		pstmt.setString(3,pCount);
		pstmt.setString(4,pNumber);
		
		pstmt.executeUpdate();
		
	} catch (ClassNotFoundException e){
		out.println(e);
	} catch (SQLException e){
		out.println(e);
	} finally {
		pstmt.close();   
		conn.close();
    }
%>

<script>
	window.close();
</script>