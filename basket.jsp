<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8"); 
%>	
<%
		Cookie ck[] =request.getCookies();
		String type = "";
		String id = (String) session.getAttribute("ID");
		if(ck.length>=2 && ck[1].getName().equals("ID")){
			id = (String) ck[1].getValue();
			type = (String) ck[2].getValue();
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

<%
	
	String tPrice = (String) session.getAttribute("TOTAL_PRICE");
	int pCount = 1;
	
	Connection conn = null;
	PreparedStatement pstmt1 = null;
	PreparedStatement pstmt2 = null;
	ResultSet rs = null;
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/newdb";
		String userName="root";
		String password="pjypjypjy";
		conn = DriverManager.getConnection(url, userName, password);
		
		
		String sql1 = "select 상품.상품번호, 상품.상품명, 상품.가격, 장바구니.수량 from 상품, 장바구니 where 상품.상품번호 = 장바구니.상품번호 and 고객아이디=?";
		
		
		pstmt1 = conn.prepareStatement(sql1);
		pstmt1.setString(1,id);
		
		pstmt1.executeQuery();
		
		rs = pstmt1.executeQuery();

		
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>장바구니</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/track.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
        
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">장바구니</h1>
                </div>
            </div>
        </header>
        <div class="container px-4 px-lg-5">
            	<h5 class="title-sub5depth">장바구니 목록</h5>
                <div class="common-hrTable-1">
                
                    <table>
                      <colgroup>
                            <col style="width:15%;">
                            <col style="width:10%;">
                            <col style="width:20%;">
                            <col style="width:10%;">
                            <col style="width:15%;">
                            <col style="width:15%;">
                            <col style="width:15%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col" class="number">상품번호 SKU<br/></th>
                                <th scope="col" class="thumb">이미지</th>
                                <th scope="col" class="product">상품정보</th>
                                <th scope="col" class="quantity">수량</th>
                                <th scope="col" class="price">상품 금액</th>
                                <th scope="col" class="state">합계</th>
                                <th scope="col" class="service">삭제</th>
                            </tr>
                        </thead>
                        
                        <%while(rs.next()) {
                        	%>
                        <form method="post" action="basketCountModify.jsp">
                        
                        	
                            <tr>
                            	<td class="text-alignCenter" style="line-height:200px;"><%=rs.getString(1)%>
                                <td class="text-alignCenter"><img src="snackImgs/<%=rs.getString(2)%>.PNG"  width=120px /></td>
                                <td class="text-alignCenter" style="line-height:200px;"><%=rs.getString(2)%><strong></strong>
                                </td>
                                <td class="text-alignCenter">
                                <br><br>
                                <input type="text" name="productCount" placeholder="<%=rs.getString(4)%>" size=2/>개<br><br>
                                <input type="submit" value="수정"/>&nbsp;
                               	<input type="hidden" name="productNumber" value="<%=rs.getString(1)%>"/>
                                </td>
                                <td class="text-alignCenter" style="line-height:200px;"><strong><script>document.writeln((<%=rs.getInt(3)%>).toLocaleString()+"원"); </script></strong>
                                <td class="text-alignCenter" style="line-height:200px;"><strong><script>document.writeln((<%=rs.getInt(3) * rs.getInt(4)%>).toLocaleString()+"원"); </script></strong></td>
                                <td class="text-alignCenter" ><br><br><br><input type="button" value="삭제" onClick="location.href='deleteItemInBasket.jsp?상품번호=<%=rs.getString(1)%>'"/></td>  
                            </tr>
                            
                        
                        </form>
                        <%} %> 
                        
                    </table>
                    
                    <br><br><br>
                    <div style="position:relative; left:30%">
                    	<button type="button" onClick="location.href='orderAll.jsp'"  class="btn btn-outline-dark">전체 상품 주문<i class="fa fa-check spaceLeft"></i></button>
                    	<button type="button" onClick="location.href='deleteBasketAll.jsp'"  class="btn btn-outline-dark">장바구니 상품 전체 삭제<i class="fa fa-check spaceLeft"></i></button>
                    </div>
                    
                </div>
        </div>
        <div style="margin-bottom: 246px !important;"></div>
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2022</p></div>
        </footer>
    </body>
</html>


<%		
	rs.close();
	pstmt1.close();     // Statement 종료
	conn.close();

	} catch (ClassNotFoundException e){
		out.println(e);
	} catch (SQLException e){
		out.println(e);
	} finally {
		
		 	// Connection 종료
	}
	
%>