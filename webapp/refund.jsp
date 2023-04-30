<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
	
<%
	request.setCharacterEncoding("UTF-8"); 
%>

<%
	
		String number = request.getParameter("number"); 
		String refundReason = request.getParameter("refundReason");
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			String DB_URL = "jdbc:mysql://localhost:3306/newdb";
			
			String userName="root";
			String password="pjypjypjy";
			
			Connection con = DriverManager.getConnection(DB_URL, userName, password);
			String sql = "UPDATE 주문 SET 환불상태=1, 환불사유=? WHERE LPAD(주문.주문번호,8,0) = ?"; // sql문 작성(입력받은 값들을 보내기 위한 작업)
	 		String sql2 = "SELECT 환불상태 FROM 주문 WHERE LPAD(주문.주문번호,8,0) = ?";
			
			PreparedStatement pstmt = con.prepareStatement(sql);
			PreparedStatement pstmt2 = con.prepareStatement(sql2);
			
			pstmt.setString(2, number);
			pstmt.setString(1, refundReason);
			pstmt2.setString(1, number);
			
			ResultSet rs = pstmt2.executeQuery();
			rs.next();
			if(rs.getInt(1) == 0){
			
				int result = pstmt.executeUpdate();
				
				if(result == 1){ // 성공
					%>
					<script>
						alert("환불요청 되었습니다.");
						window.close();
					</script>
					<% 
					
				} else{ // 실패
					%>
					<script>
						alert("환불요청을 실패했습니다.");
						window.close();
					</script>
					<% 
				}
			}
			else if(rs.getInt(1) == 1){
				%>
				<script>
					alert("이미 환불요청 되었습니다.");
					window.close();
				</script>
				<%
			}
			else{
				%>
				<script>
					alert("환불된 상품입니다.");
					window.close();
				</script>
				<%
				
			}
	 
			pstmt.close();
			pstmt2.close();
			con.close();
			rs.close();
		}
	 
		catch(ClassNotFoundException e) {
			out.println(e);
		}
		catch(SQLException e) {
			out.println(e);
		}
%>



 