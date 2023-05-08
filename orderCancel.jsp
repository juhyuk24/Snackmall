<%@ page contentType="text/html;charset=utf-8"

	import="java.sql.*" %>

<%

	request.setCharacterEncoding("utf-8");
	String pNumber = request.getParameter("주문번호");
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
		String sql = "DELETE FROM 주문 WHERE LPAD(주문.주문번호,8,0)=? and 고객아이디=?";
		String sql2 = "SELECT 주문수량, 상품번호 FROM 주문 WHERE LPAD(주문.주문번호,8,0)=?";
		String sql3 = "UPDATE 상품 SET 재고량 = 재고량 + ? WHERE 상품번호 = ?"; 
		
		int result = 0;
		
		PreparedStatement pstmt = con.prepareStatement(sql); 
		pstmt.setString(1,pNumber);
		pstmt.setString(2, id);
		PreparedStatement pstmt2 = con.prepareStatement(sql2); 
		pstmt2.setString(1,pNumber);
		ResultSet rs = pstmt2.executeQuery();
		PreparedStatement pstmt3 = con.prepareStatement(sql3); 
		
		rs.next();
		
		pstmt3.setInt(1, rs.getInt(1));
		pstmt3.setInt(2, rs.getInt(2));
		
		pstmt3.executeUpdate();
		
		result = pstmt.executeUpdate();
		
		if(result == 1){
			%>
			<script>
				alert("주문을 취소했습니다.");
				location.href="order.jsp";
			</script>
			<% 
		}
		else{ // 실패
			%>
			<script>
				alert("주문취소 실패");
				location.href="order.jsp";
			</script>
			<% 
		}
		pstmt.close();
		pstmt2.close();
		pstmt3.close();
		rs.close();
		con.close();

	}catch(ClassNotFoundException e){
		out.println(e);
	}catch(SQLException e){
		out.println(e);
	}

%>