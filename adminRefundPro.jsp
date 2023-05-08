<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
	
<%
	request.setCharacterEncoding("UTF-8"); 
%>

<%
	
		String number = request.getParameter("주문번호"); 
	
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			String DB_URL = "jdbc:mysql://localhost:3306/newdb";
			
			String userName="root";
			String password="pjypjypjy";
			
			Connection con = DriverManager.getConnection(DB_URL, userName, password);
			String sql = "UPDATE 주문 SET 환불상태=2 WHERE LPAD(주문.주문번호,8,0) = ?"; // sql문 작성(입력받은 값들을 보내기 위한 작업)

			
			PreparedStatement pstmt = con.prepareStatement(sql);
			
			
			pstmt.setString(1, number);

			
			
			int result = pstmt.executeUpdate();
			
			if(result == 1){ // 성공
				%>
				<script>
					alert("주문번호 : "+<%out.print(number);%>+" 환불 되었습니다.");
					location.href="adminRefund.jsp";
				</script>
				<% 
				
			} else{ // 실패
				%>
				<script>
					alert("환불을 실패했습니다.");
					
				</script>
				<% 
			}
 
			pstmt.close();
			con.close();
		}
	 
		catch(ClassNotFoundException e) {
			out.println(e);
		}
		catch(SQLException e) {
			out.println(e);
		}
%>

