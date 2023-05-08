<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8"); 
%>

<%
	Cookie ck[] =request.getCookies();
	String cName = null;
	if(ck.length>=2 && ck[1].getName().equals("ID")){
		cName = (String) ck[1].getValue();
	}

	String pNumber = request.getParameter("productNumber");
	String pCount = request.getParameter("productCount");
	String pPrice = request.getParameter("productPrice");
	
	
	
	Connection conn = null;
	PreparedStatement pstmt1 = null;
	
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/newdb";
		String userName="root";
		String password="pjypjypjy";
		conn = DriverManager.getConnection(url, userName, password);
		
		String sql1 = "update 장바구니 set 수량=? where 상품번호=? and 고객아이디=?";
		
		pstmt1 = conn.prepareStatement(sql1);
		
		
		pstmt1.setString(1, pCount);
		pstmt1.setString(2, pNumber);
		pstmt1.setString(3, cName);
		
		pstmt1.executeUpdate();
		
	
		
		pstmt1.close();
		conn.close();
		
		
	} catch(ClassNotFoundException e){
		out.print(e);
	} catch(SQLException e){
		out.print(e);
	}
		
	response.sendRedirect("basket.jsp");	

%>