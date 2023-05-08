<!-- /* LoginPro.jsp */-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
	
<%
	request.setCharacterEncoding("UTF-8"); 
	
%>
 
<%
	try {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Class.forName("com.mysql.jdbc.Driver");
		String DB_URL = "jdbc:mysql://localhost:3306/newdb";
		String userName="root";
		String password="pjypjypjy";
		
		con = DriverManager.getConnection(DB_URL, userName, password);
		
		// 로그인 화면에 입력된 아이디와 비밀번호를 가져온다
		String id= request.getParameter("ID");
		String pw = request.getParameter("PWD");
		String type = request.getParameter("TYPE");
		
		//id에 해당하는 passwd 가져오기
		String sql = "SELECT 비밀번호  FROM 고객 WHERE 고객아이디=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
 
		//실행  rs에 저장
		rs = pstmt.executeQuery();
 
		//rs에 데이터(행)가 있으면 아이디 있음
		//패스워드비교 맞으면 로그인 인증(세션값 생성 "ID")
		//패스워드비교 틀리면 "패스워드틀림" 로그인페이지로 이동
		//rs에 데이터(행)가 없으면 "아이디없음" 로그인페이지로 이동
		if (rs.next()) { // 아이디있음
			if (pw.equals(rs.getString("비밀번호"))) {
				Cookie c = new Cookie("ID", id);
				Cookie c2 = new Cookie("TYPE", type);

				c.setMaxAge(60 * 60);
				c.setPath("/");
				c2.setMaxAge(60 * 60);
				c2.setPath("/");
				response.addCookie(c);
				response.addCookie(c2);
				response.sendRedirect("index.jsp");
				
			} else {
 
%>
				<script>
					alert("비밀번호를 확인해주세요.");
					history.back();
				</script>		
<%	
			}
		} else {
			// 아이디없음
%>
			<script>
				alert("아이디를 확인해주세요.");
				//location.href = "loginForm.jsp";  // 서버가 요청을 받는다.
				history.back();  // history.go(-1);  // 서버에 요청없이 브라우저에서 자체적으로 처리
			</script>
<%
 
		}
		
		pstmt.executeUpdate(); // sql문 실행
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