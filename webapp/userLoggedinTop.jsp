<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	

	if(ck.length>=2 && ck[1].getName().equals("ID")){
		id = (String) ck[1].getValue();
	}
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/newdb";
		String userName="root";
		String password="pjypjypjy";
		String type1 = "0";
		conn = DriverManager.getConnection(url, userName, password);
	
		String sql = "select count(*) from 장바구니 where 고객아이디=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		
		rs = pstmt.executeQuery();
		
		
%>	
	
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="css/styles.css" rel="stylesheet" />
</head>
<body>
	<!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="index.jsp">Snack Mall</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                        <li class="nav-item"><a class="nav-link" href="allproducts.jsp">All products</a></li>
                   
                    </ul>
                    <form class="d-flex">
                    	<button onClick="location.href='mypage.jsp'" class="btn btn-outline-dark" type="button">
                            마이페이지
                        </button>
                        <% while(rs.next()) {%>
                        <button onClick="location.href='basket.jsp'" class="btn btn-outline-dark" type="button">
                            <i class="bi-cart-fill me-1"></i>
                            장바구니
                            <span class="badge bg-dark text-white ms-1 rounded-pill"><%=rs.getString(1)%></span>
                            
                        </button>
                    	<button onClick="location.href='logoutPro.jsp'" class="btn btn-outline-dark" type="button">
                            로그아웃
                        </button>
                        <%} %>
                    </form>
                </div>
            </div>
        </nav>
</body>
</html>
<%
} catch (ClassNotFoundException e){
		out.println(e);
	} catch (SQLException e){
		out.println(e);
	} finally {
		pstmt.close();   
		conn.close();
}
%>