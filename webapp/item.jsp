<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import="java.io.*"%>

<%
	request.setCharacterEncoding("UTF-8"); 
%>	
<%
		Cookie ck[] =request.getCookies();
		String id = null;
		String type = "";
		if(ck.length>=2){
			if(ck[1].getName().equals("ID")){
				id = (String) ck[1].getValue();
				type = (String) ck[2].getValue();
			}
		}
		String zero = "0";
        if(id == null) {       	
%>
	<%@include file="top.jsp" %>
<% 
        } else if(type.equals(zero)) {
%>
	<%@include file="adminLoggedinTop.jsp" %>
<%
        } else {
%>    	
 	<%@include file="userLoggedinTop.jsp" %>
<%
        }
%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>스낵몰</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>

<%
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	String pNumber = request.getParameter("상품번호");
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/newdb";
		String userName="root";
		String password="pjypjypjy";
		String type1 = "0";
		conn = DriverManager.getConnection(url, userName, password);
		
		String sql = "select 상품번호, 상품명, 가격, 재고량 from 상품 where 상품번호=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,pNumber);
		
		rs = pstmt.executeQuery();
		
%>

    <body>
        <!-- Product section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="row gx-4 gx-lg-5 align-items-center">
                <% 
                while(rs.next()){
                %> 
                    <div class="col-md-6"><img class="card-img-top mb-5 mb-md-0" style="width:500px; height:500px;"  src ="snackImgs/<%=rs.getString(2)%>.PNG" /></div>
                    <div class="col-md-6">
                        <div class="small mb-1">SKU:<%=rs.getString(1) %></div>
                        <h1 class="display-5 fw-bolder"><%=rs.getString(2) %></h1>
                        <br>
                        <div class="fs-5 mb-5">
                            <span><script>document.writeln("가격 : "+(<%=rs.getInt(3)%>).toLocaleString()+" 원"); </script></span>
                            <%
                            if(rs.getInt(4)==0) {
                            	
                            %>
                            <p class="lead" style="font-size:15px">남은 수량 : 품절</p>
                        </div>
                        <p class="lead"><%=rs.getString(2) %> 입니다.</p><br>
                        <br>
                        	
                        <%		
                            }
                            	else {
                            		if(id == null || type.equals(zero)){%>
                        				<p class="lead" style="font-size:15px">남은 수량 : <%=rs.getString(4)%>개</p>
				                        </div>
				                        <p class="lead"><%=rs.getString(2) %> 입니다.</p><br>
	                       
                        <%		}else{ %>
                        	<p class="lead" style="font-size:15px">남은 수량 : <%=rs.getString(4)%>개</p>
	                        </div>
	                        <p class="lead"><%=rs.getString(2) %> 입니다.</p><br>
	                       
	                        <br>
	                        	<button class="btn btn-outline-dark flex-shrink-0" type="button" onClick="location.href='basketPro.jsp?상품번호=<%=rs.getString(1)%>&고객아이디=<%=id%>'">
	                                <i class="bi-cart-fill me-1"></i>
	                                장바구니에 넣기
	                            </button>
                        <% }
                            }
                          }%>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2022</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/Item_scripts.js"></script>
    </body>
</html>
<% 

	
	
	} catch (ClassNotFoundException e){
		out.println(e);
	} catch (SQLException e){
		out.println(e);
	} finally {
		rs.close();     // ResultSet 종료

		pstmt.close();     // Statement 종료

		conn.close(); 	// Connection 종료
	}
%>

