<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>

<%
	request.setCharacterEncoding("UTF-8"); 
%>

<html>
<head>
<link href="css/styles.css" rel="stylesheet" />
</head>
</html>
<%
	
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
		
		String sql = "select 상품번호, 상품명, 가격, 재고량 from 상품";
		
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
%>	
		<body>
	<!-- Section-->
	
	
		<section class="py-5">
			<div class="container px-4 px-lg-5 mt-5">
				<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <% while(rs.next()) {%>
					<div class="col mb-5" onClick="location.href='item.jsp?상품번호=<%=rs.getString(1)%>'">
						<div class="card h-100">
							<img class="card-img-top" src="snackImgs/<%=rs.getString(2)%>.PNG" />
								<div class="card-body p-4">
								<div class="text-center">
								<h5 class="fw-bolder"><%=rs.getString(2)%></h5>
									<%=rs.getString(3)%> 원
								</div>
							</div>
						</div>
                    </div>
				<%
				}
				%>
		
                </div>
            </div>
        </section>
</body>
		
<%

	
	} catch (ClassNotFoundException e){
		out.println(e);
	} catch (SQLException e){
		out.println(e);
	} 
%>

	
