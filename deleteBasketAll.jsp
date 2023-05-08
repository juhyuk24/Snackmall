<%@ page contentType="text/html;charset=utf-8"

	import="java.sql.*" %>

<%

	request.setCharacterEncoding("utf-8");
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
		String sql = "DELETE FROM 장바구니 WHERE 고객아이디=?";

		PreparedStatement pstmt = con.prepareStatement(sql); 
		
		pstmt.setString(1, id);
		pstmt.executeUpdate();

		pstmt.close();
		con.close();

	}catch(ClassNotFoundException e){
		out.println(e);
	}catch(SQLException e){
		out.println(e);
	}

	response.sendRedirect("basket.jsp");

%>