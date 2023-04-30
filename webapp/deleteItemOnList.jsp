<%@ page contentType="text/html;charset=utf-8"

	import="java.sql.*" %>

<%
	

	request.setCharacterEncoding("utf-8");
	String pNumber = request.getParameter("상품번호");
	Cookie ck[] =request.getCookies();
	String id = null;
	if(ck.length>=2 && ck[1].getName().equals("ID")){
		id = (String) ck[1].getValue();
	}
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		String DB_URL = "jdbc:mysql://localhost:3306/newdb";

		Connection con = DriverManager.getConnection(DB_URL, "root", "pjypjypjy");
		String sql = "delete from 상품 where 상품번호=?";
		String sql2 = "delete from 장바구니 where 상품번호=?";

		PreparedStatement pstmt = con.prepareStatement(sql); 
		PreparedStatement pstmt2 = con.prepareStatement(sql2);
		
		pstmt.setInt(1,Integer.parseInt(pNumber));		
		pstmt.executeUpdate();
		
		pstmt2.setInt(1,Integer.parseInt(pNumber));
		pstmt2.executeUpdate();


		pstmt.close();
		pstmt2.close();
		con.close();

	}catch(ClassNotFoundException e){
		out.println(e);
	}catch(SQLException e){
		out.println(e);
	}

	response.sendRedirect("manageProduct.jsp");

%>