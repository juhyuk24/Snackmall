<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
	
<%
	request.setCharacterEncoding("UTF-8"); 
%>
<%	
	Cookie ck[] =request.getCookies();
	String id = null;
	if(ck.length>=2 && ck[1].getName().equals("ID")){
		id = (String) ck[1].getValue();
	}
	String cPw = request.getParameter("cusPw");
	String cName = request.getParameter("cusName");
	String cAddr = request.getParameter("cusAddr");
	String cPhone = request.getParameter("cusPhone");
	int result = 0;
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
		
		String sql = "update 고객 set 비밀번호=?,이름=?,배송지=?,연락처=? where 고객아이디=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,cPw);
		pstmt.setString(2,cName);
		pstmt.setString(3,cAddr);
		pstmt.setString(4,cPhone);
		pstmt.setString(5,id);
		
		result = pstmt.executeUpdate();
		if(result == 1){
			%>
			<script>
				alert("회원정보 수정완료");
				location.href="index.jsp";
			</script>
			<%
		}else {
			%>
				<script>
					alert("정보 수정실패");
				</script>
			<%
		}
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
	window.history.back();
</script>