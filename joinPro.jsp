<!-- /* JoinPro.jsp */-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
	
<%
	request.setCharacterEncoding("UTF-8"); 
	
%>
 
<%
	String ID = request.getParameter("ID"); // JoinForm.jsp에서 입력받은 값들을 받아옵니다.
	String PWD = request.getParameter("PWD");
	String UserName = request.getParameter("NAME");
	String Address = request.getParameter("ADDR");
	String Contact = request.getParameter("PHONE");
	
 
	try {
		
		Class.forName("com.mysql.jdbc.Driver");
		String DB_URL = "jdbc:mysql://localhost:3306/newdb";
		
		String userName="root";
		String password="pjypjypjy";
		
		Connection con = DriverManager.getConnection(DB_URL, userName, password);
		String sql = "INSERT INTO 고객 VALUES (?,?,?,?,?)"; // sql문 작성(입력받은 값들을 보내기 위한 작업)
 
		PreparedStatement pstmt = con.prepareStatement(sql);
 
		pstmt.setString(1, ID); // values에 들어갈 각각의 ID, PWD, UserName, Email, Contact, Address 설정
		pstmt.setString(2, PWD);
		pstmt.setString(3, UserName);
		pstmt.setString(4, Address);
		pstmt.setString(5, Contact);
		
 
		int result = pstmt.executeUpdate();
		
		if(result == 1){ // 성공
			%>
			<script>
				alert("회원가입을 축하합니다.");
				location.href="index.jsp";
			</script>
			<% 
			
		} else{ // 실패
			%>
			<script>
				alert("빈칸을 모두 채워주세요");
				
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
		%>
		<script>
			alert("중복된 아이디입니다. 다시 입력해주세요");
			window.history.back();
		</script>
		<%
		
	}

%>


 
 

