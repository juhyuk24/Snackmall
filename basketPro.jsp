<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8"); 
%>

<%
	String pNumber = request.getParameter("상품번호");
	String cName = request.getParameter("고객아이디");
	int pCount = 1;
	
	Connection conn = null;
	PreparedStatement pstmt1 = null;
	
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/newdb";
		String userName="root";
		String password="pjypjypjy";
		conn = DriverManager.getConnection(url, userName, password);
		
		String sql1 = "insert into 장바구니 values(?,?,?)";
		
		pstmt1 = conn.prepareStatement(sql1);
		
		
		pstmt1.setString(1, pNumber);
		pstmt1.setString(2, cName);
		pstmt1.setInt(3, pCount);
		
		
		int rs = pstmt1.executeUpdate();
		
		if(rs == 1){
%>
			<script>
				alert("장바구니에 담았습니다.");
				window.history.back();
			</script>
<%
		}else{
%>
			<script>
				alert("실패");
				window.history.back();
			</script>
<%
		}
		
		pstmt1.close();
		conn.close();
		
	} catch(ClassNotFoundException e){
		out.print(e);
	} catch(SQLException e){
		%>
		
		<script>
			alert("이미 장바구니에 있습니다.");
			window.history.back();
		</script>
		<%
		
	}
		
		

%>